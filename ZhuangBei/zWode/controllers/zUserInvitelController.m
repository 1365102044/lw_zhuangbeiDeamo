//
//  zUserInvitelController.m
//  ZhuangBei
//
//  Created by aa on 2020/5/16.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zUserInvitelController.h"
#import "zMyFriendListCell.h"
#import "zFriendsModel.h"

@interface zUserInvitelController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView*persoanTableView;

@property(strong,nonatomic)NSMutableArray * friendArray;

@end

@implementation zUserInvitelController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(UITableView*)persoanTableView
{
    if (!_persoanTableView) {
        _persoanTableView  = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _persoanTableView.backgroundColor = [UIColor whiteColor];
        _persoanTableView.delegate = self;
        _persoanTableView.dataSource = self;
        _persoanTableView.allowsSelection = NO;
        _persoanTableView.estimatedRowHeight = kWidthFlot(44);
        _persoanTableView.estimatedSectionHeaderHeight = 2;
        _persoanTableView.estimatedSectionFooterHeight = 2;
        _persoanTableView.showsVerticalScrollIndicator = NO;
        _persoanTableView.rowHeight = UITableViewAutomaticDimension;
        _persoanTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _persoanTableView;
}

-(NSMutableArray*)friendArray
{
    if (!_friendArray) {
        _friendArray = [NSMutableArray array];
    }
    return _friendArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.persoanTableView];
    
    NSString * getUserIntevial = [NSString stringWithFormat:@"%@%@",kApiPrefix,kuserGetInvitelList];
    [self getDataurl:getUserIntevial withParam:nil];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.persoanTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuide);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.friendArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    zMyFriendListCell * cell = [zMyFriendListCell instanceWithTableView:tableView AndIndexPath:indexPath];
    zFriendsModel * model = self.friendArray[indexPath.row];
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)RequsetFileWithUrl:(NSString*)url WithError:(NSError*)err
{
    if ([url containsString:kuserGetInvitelList]) {
        
        if (err.code == -1001) {
            [[zHud shareInstance] showMessage:@"无法连接服务器"];
        }
    }

}



-(void)RequsetSuccessWithData:(id)data AndUrl:(NSString*)url
{
    if ([url containsString:kuserGetInvitelList]) {
        NSDictionary * dic = data[@"page"];
        NSString * code = data[@"code"];
        if ([code integerValue] == 0) {
            
            NSArray * list = dic[@"list"];
            if (list.count == 0) {
                [[zHud shareInstance]showMessage:@"暂无邀请人"];
                self.nothingView.alpha = 1;
                [self.view bringSubviewToFront:self.nothingView];
            }else
            {
                [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary * dic = list[idx];
                    zFriendsModel * model = [zFriendsModel mj_objectWithKeyValues:dic];
                    [self.friendArray addObject:model];
                }];
                [self.persoanTableView reloadData];
            }
        }
        NSLog(@"公司认证信息%@",dic);
    }
}


@end
