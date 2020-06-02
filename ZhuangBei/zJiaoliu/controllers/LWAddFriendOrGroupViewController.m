//
//  LWAddFriendOrGroupViewController.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/15.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWAddFriendOrGroupViewController.h"
#import "LWSwitchBarView.h"
#import "LWAddFriendTableViewCell.h"
#import "LWAddFriendModel.h"
#import "LWAddFriendDeatilViewController.h"
#import "LWAddGroupDeatilViewController.h"

@interface LWAddFriendOrGroupViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) LWSwitchBarView * switchBarView;
@property (nonatomic, strong) UIScrollView * mainScrollView;
@property (nonatomic, strong) UIView * searchView;
@property (nonatomic, strong) UITextField *tf;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign) NSInteger  selectIndex;
@property (nonatomic, strong) NSMutableArray<LWAddFriendModel *> * listDatas;

@end

@implementation LWAddFriendOrGroupViewController
//http://test.110zhuangbei.com:8105/app/sys/user/findUserByUserNameList
//app/appgroup/findGroupByGroupNameList
- (void)requestDatas
{
    [self.tf endEditing:YES];
    
    if (![self.tf.text isNotBlank]) {
        [[zHud shareInstance] showMessage:(_selectIndex == 0)?@"好友姓名不能为空":@"群组名称不能为空"];
        return;
    }
    NSDictionary *param = @{@"nickName":LWDATA(self.tf.text),@"limit":@"200",@"page":@(self.currPage)};
    NSString *url = @"app/appqyuser/findUserByUserNameList";
    if (_selectIndex == 1) {
        param = @{@"groupName":LWDATA(self.tf.text),@"limit":@"200",@"page":@(self.currPage)};
        url = @"app/appgroup/findGroupByGroupNameList";
//        [self requestPostWithUrl:@"app/appgroup/findGroupByGroupNameList" para:param paraType:(LWRequestParamTypeDict) success:^(id  _Nonnull response) {
//            [self handlerDatas:response];
//        } failure:^(NSError * _Nonnull error) {
//
//        }];
    }else{
    }
    [self requestPostWithUrl:url paraString:param success:^(id  _Nonnull response) {
        [self handlerDatas:response];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)handlerDatas:(id)response
{
    NSDictionary *page = response[@"page"];
    if ([page isKindOfClass:[NSNull class]]) {
        return;
    }
    self.currPage = [page[@"currPage"] intValue];
    self.totalPage = [page[@"totalPage"] intValue];
    NSArray *list = page[@"list"];
    if (self.currPage == 1) {
        [self.listDatas removeAllObjects];
    }
    for (NSDictionary *dict in list) {
        LWAddFriendModel *model = [LWAddFriendModel modelWithDictionary:dict];
        model.cellType = self.selectIndex + 1;
        [self.listDatas addObject:model];
    }
    if (self.listDatas.count == 0) {
        [self.view bringSubviewToFront:self.nothingView];
        self.nothingView.alpha = 1;
    }else{
        [self.view sendSubviewToBack:self.nothingView];
        self.nothingView.alpha = 0;
    }
    [self.tableView reloadData];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.nothingView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.left.mas_equalTo(self.view).mas_offset(0);
        make.top.mas_equalTo(self.searchView.mas_bottom).mas_offset(10);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加好友/群组";
    
    [self confiUI];
}

- (void)confiUI
{
    WEAKSELF(self)
    self.switchBarView = [LWSwitchBarView switchBarView:@[@"找人",@"找群",] clickBlock:^(UIButton * _Nonnull btn) {
        weakself.tf.text = nil;
        weakself.currPage = 1;
        weakself.totalPage = 1;
        [weakself.listDatas removeAllObjects];
        [weakself.tableView reloadData];
        weakself.selectIndex = btn.tag;
    }];
    [self.view addSubview:self.switchBarView];
    [self.switchBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).mas_offset(20);
        make.height.mas_offset(36);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_offset(200);
    }];
    
    [self.view addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(self.view).mas_offset(0);
        make.top.mas_equalTo(self.switchBarView.mas_bottom).mas_offset(20);
        make.height.mas_offset(50);
    }];
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.left.mas_equalTo(self.view).mas_offset(0);
        make.top.mas_equalTo(self.searchView.mas_bottom).mas_offset(10);
    }];
}

- (UIView *)searchView
{
    if (!_searchView) {
        _searchView = [[UIView alloc] init];
        _tf = [[UITextField alloc] init];
        _tf.placeholder = @"请输入用户的名称或手机号";
        UIButton *confiBtn = [UIButton new];
        [confiBtn setTitle:@"查找" forState:UIControlStateNormal];
        [confiBtn setBackgroundColor:BASECOLOR_BLUECOLOR];
        [confiBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [confiBtn addTarget:self action:@selector(requestDatas) forControlEvents:UIControlEventTouchUpInside];
        
        [_searchView addSubviews:@[_tf,confiBtn]];
        [_tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_searchView.mas_left).mas_offset(20);
            make.right.mas_equalTo(confiBtn.mas_left).mas_offset(-20);
            make.centerY.mas_equalTo(_searchView.mas_centerY);
            make.height.mas_offset(40);
        }];
        [confiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(75);
            make.height.mas_offset(30);
            make.centerY.mas_equalTo(_tf.mas_centerY);
            make.right.mas_equalTo(_searchView.mas_right).mas_offset(-20);
        }];
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
        _tf.leftView = paddingView;
        _tf.leftViewMode = UITextFieldViewModeAlways;
        _tf.backgroundColor = BASECOLOR_BLACKGROUD;
        [_tf setBoundWidth:0 cornerRadius:20];
        [confiBtn setBoundWidth:0 cornerRadius:15];
    }
    return _searchView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWAddFriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWAddFriendTableViewCell" forIndexPath:indexPath];
    cell.model = self.listDatas[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listDatas.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWAddFriendModel *model = self.listDatas[indexPath.row];
    if (model.cellType == 1) {
        LWAddFriendDeatilViewController *vc = [LWAddFriendDeatilViewController new];
        vc.friendModel = self.listDatas[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        LWAddGroupDeatilViewController *vc = [LWAddGroupDeatilViewController new];
        vc.listModel = self.listDatas[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 130;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [_tableView registerClass:[LWAddFriendTableViewCell class] forCellReuseIdentifier:@"LWAddFriendTableViewCell"];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSMutableArray *)listDatas
{
    if (!_listDatas) {
        _listDatas = [[NSMutableArray alloc] init];
    }
    return _listDatas;
}

@end
