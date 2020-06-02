//
//  LWGroupMemberListViewController.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/19.
//  Copyright © 2020 aa. All rights reserved.
//
//http://test.110zhuangbei.com:8105/app/app/appgroupuser/getMembers
//id=58
#import "LWGroupMemberListViewController.h"
#import "LWGroupMemberListModel.h"
#import "ChatRoomViewController.h"

@implementation LWGroupMemberListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self confiCellUI];
    }
    return self;
}

- (void)confiCellUI
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _icon = [UIImageView new];
    _nameL = [LWLabel lw_lable:@"测试" font:16 textColor:BASECOLOR_TEXTCOLOR];
    
    [self.contentView addSubviews:@[_icon,_nameL]];
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(50);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(20);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_icon.mas_right).mas_offset(20);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    [_icon setBoundWidth:0 cornerRadius:25];
}

@end


@interface LWGroupMemberListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray<LWGroupMemberListModel *> * listDatasArray;

@end

@implementation LWGroupMemberListViewController

- (void)requestDatas
{
    [self requestPostWithUrl:@"app/appgroupuser/getMembers" para:@{@"id":LWDATA(_roomId)} paraType:(LWRequestParamTypeString) success:^(id  _Nonnull response) {
        if ([response[@"code"] intValue] == 0) {
            NSArray *list = response[@"data"][@"list"];
            for (NSDictionary *dict in list) {
                [self.listDatasArray addObject:[LWGroupMemberListModel modelWithDictionary:dict]];
            }
        }else
        {
            [zHud showMessage:response[@"msg"]];
        }
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.listDatasArray = [NSMutableArray array];
  
    self.title = self.roomName;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self requestDatas];
}
#pragma mark TableView

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listDatasArray.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    LWGroupMemberListModel * model =  [self.listDatasArray objectAtIndex:row];
    LWGroupMemberListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWGroupMemberListCell" forIndexPath:indexPath];
    [cell.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kApiPrefix,model.avatar]] placeholderImage:IMAGENAME(@"testtouxiang")];
    cell.nameL.text = model.username;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWGroupMemberListModel *model = self.listDatasArray[indexPath.row];
    [self.navigationController pushViewController:[ChatRoomViewController chatRoomViewControllerWithRoomId:model.customId roomName:model.username roomType:(LWChatRoomTypeOneTOne) extend:nil] animated:YES];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 66;
        [_tableView registerClass:[LWGroupMemberListCell class] forCellReuseIdentifier:@"LWGroupMemberListCell"];
        _tableView.backgroundColor = UIColor.whiteColor;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
}
@end

