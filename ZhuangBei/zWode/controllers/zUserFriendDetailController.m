//
//  zUserFriendDetailController.m
//  ZhuangBei
//
//  Created by aa on 2020/5/19.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zUserFriendDetailController.h"
#import "zMyFriendListCell.h"



@interface zUserFriendDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView*persoanTableView;

@property(strong,nonatomic)NSMutableArray * friendArray;

@end

@implementation zUserFriendDetailController

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
       NSArray * array =  @[
        @{
            @"name":@"出生日期",
            @"content":@"",
        },
        @{
            @"name":@"最高学历",
            @"content":@"",
        },
        @{
            @"name":@"工作年限",
            @"content":@"",
        },
        @{
            @"name":@"公司名称",
            @"content":@"",
        },
        @{
            @"name":@"公司类型",
            @"content":@"",
        },
        @{
            @"name":@"公司所在省",
            @"content":@"",
        },
        @{
            @"name":@"部门-职务",
            @"content":@"",
        },
        @{
            @"name":@"管辖地",
            @"content":@"",
        }];
        _friendArray = [[NSMutableArray alloc]initWithArray:array];
    }
    return _friendArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.persoanTableView];
    
    NSString * getUserIntevial = [NSString stringWithFormat:@"%@%@?userId=%@",kApiPrefix,getFriendDetail,self.userId];
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
    if ([url containsString:getFriendDetail]) {
        NSDictionary * dic = data[@"page"];
        NSString * code = data[@"code"];
        if ([code integerValue] == 0) {
            NSDictionary * list = dic[@"list"];
        }
        NSLog(@"公司认证信息%@",dic);
    }
}



@end
