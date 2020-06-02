
//
//  LWUserGroupManagerViewController.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/15.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWUserGroupManagerViewController.h"
#import "LWUserGroupManagerTableViewCell.h"
#import "LWUserGroupModel.h"
#import "LWTool.h"
#import "LWAlearCustomManagerView.h"

@interface LWUserGroupManagerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableview;
@property (nonatomic, strong) NSMutableArray<LWUserGroupModel *> * listDatas;
@property (nonatomic, strong) UIView * seactionView;
@property (nonatomic, strong) LWAddNewUserGroupView *addNewView;
@property (nonatomic, strong) LWAlearCustomManagerView * alearmanager;

@end

@implementation LWUserGroupManagerViewController
//http://test.110zhuangbei.com:8105/app/app/appfriendtype/save 新增  {"typeName":"咳咳","isDefault":2}
// http://test.110zhuangbei.com:8105/app/app/appfriendtype/update 修改   {"id":624,"typeName":"呵呵","isDefault":2}
//http://test.110zhuangbei.com:8105/app/app/appfriendtype/delete
//http://test.110zhuangbei.com:8105/app/app/appfriendtype/list

-(void)requestDatas
{
    NSString *url = @"app/appfriendtype/list";
    NSDictionary *para = @{};
    [self requestPostWithUrl:url Parameters:para success:^(id  _Nonnull response) {
        NSDictionary *page = response[@"page"];
        self.currPage = [page[@"currPage"] intValue];
        self.totalPage = [page[@"totalPage"] intValue];
        NSArray *list = page[@"list"];
        if (self.currPage == 1) {
            [self.listDatas removeAllObjects];
        }
        for (NSDictionary *dict in list) {
            LWUserGroupModel *model = [LWUserGroupModel modelWithDictionary:dict];
            [self.listDatas addObject:model];
        }
        [self.tableview reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

//新增
- (void)requestAddNewGroup:(NSString *)name isDefault:(BOOL)isDefault
{
    if (![name isNotBlank]) {
        [[zHud shareInstance] showMessage:@"名称不能为空!"];
        return;
    }
    NSString *url = @"app/appfriendtype/save";
    NSDictionary *para = @{@"typeName":LWDATA(name),@"isDefault":isDefault?@"1":@"2"};
    [ServiceManager requestPostWithUrl:url body:[LWTool dictoryToString:para] success:^(id  _Nonnull response) {
        NSInteger code =[response[@"code"] integerValue];
        if (code == 0) {
            [self requestDatas];
            POST_NOTI(@"refreshUserGroupListData", nil);
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

//删除
- (void)requestDelete:(NSString *)groupid
{
    NSString *url = @"app/appfriendtype/delete";
    [ServiceManager requestPostWithUrl:url body:[NSString stringWithFormat:@"[%@]",LWDATA(groupid)] success:^(id  _Nonnull response) {
        NSInteger code =[response[@"code"] integerValue];
        if (code == 0) {
            [self requestDatas];
            POST_NOTI(@"refreshUserGroupListData", nil);
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

//编辑
- (void)requestEditInfor:(NSString *)groupid groupname:(NSString *)groupname isDefault:(BOOL)isDefault
{
    if (![groupname isNotBlank]) {
        [[zHud shareInstance] showMessage:@"名称不能为空!"];
        return;
    }
    NSString *url = @"app/appfriendtype/update";
    NSDictionary *para = @{@"id":LWDATA(groupid),@"typeName":LWDATA(groupname),@"isDefault":isDefault?@"1":@"2"};
    [ServiceManager requestPostWithUrl:url body:[LWTool dictoryToString:para] success:^(id  _Nonnull response) {
        NSInteger code =[response[@"code"] integerValue];
        if (code == 0) {
            [self requestDatas];
            POST_NOTI(@"refreshUserGroupListData", nil);
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}


// 增加新的分组
- (void)addNewGroup
{
    WEAKSELF(self)
    _alearmanager = [LWAlearCustomManagerView showAddNewUserGroupView:^(NSString * text,BOOL isselect) {
        [weakself requestAddNewGroup:text isDefault: isselect];
    }];
}

- (void)clickCellBtn:(UIButton *)sender
{
    NSInteger index = sender.tag;
    LWUserGroupModel *model = self.listDatas[index];
    if ([sender.titleLabel.text isEqualToString:@"删除"]) {
        [self requestDelete:model.customId];
    }else if([sender.titleLabel.text isEqualToString:@"修改"]){
        WEAKSELF(self)
        _alearmanager = [LWAlearCustomManagerView showAddNewUserGroupView:^(NSString * text,BOOL isselect) {
            [weakself requestEditInfor:model.customId groupname:text isDefault:isselect];
        }];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分组管理";
    
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self requestDatas];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.seactionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWUserGroupManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWUserGroupManagerTableViewCell" forIndexPath:indexPath];
    LWUserGroupModel *model = self.listDatas[indexPath.row];
    cell.groupnameL.text = model.typeName;
    cell.deleteBtn.tag = cell.editBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(clickCellBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.editBtn addTarget:self action:@selector(clickCellBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listDatas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80;
}

- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableview.rowHeight = 100;
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [UIView new];
        [_tableview registerClass:[LWUserGroupManagerTableViewCell class] forCellReuseIdentifier:@"LWUserGroupManagerTableViewCell"];
    }
    return _tableview;
}

- (NSMutableArray *)listDatas
{
    if (!_listDatas) {
        _listDatas = [[NSMutableArray alloc] init];
    }
    return _listDatas;
}

- (UIView *)seactionView
{
    if (!_seactionView) {
        _seactionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
        _seactionView.backgroundColor = UIColor.whiteColor;
        UIImageView *icon = [UIImageView new];
        icon.image = IMAGENAME(@"addnewusergropu");
        
        UILabel *lable = [LWLabel lw_lable:@"添加分组" font:18 textColor:BASECOLOR_TEXTCOLOR];
        [_seactionView addSubviews:@[icon,lable]];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_offset(40);
            make.left.mas_equalTo(_seactionView.mas_left).mas_offset(20);
            make.centerY.mas_equalTo(_seactionView.mas_centerY);
        }];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(icon.mas_right).mas_offset(10);
            make.right.mas_equalTo(_seactionView.mas_right).mas_offset(-10);
            make.centerY.mas_equalTo(_seactionView.mas_centerY);
        }];
        [_seactionView ex_addTapAction:self selector:@selector(addNewGroup)];
    }
    return _seactionView;
}

@end
