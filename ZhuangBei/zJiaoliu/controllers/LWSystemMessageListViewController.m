//
//  LWSystemMessageListViewController.m
//  ZhuangBei
//
//  Created by LWQ on 2020/4/30.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWSystemMessageListViewController.h"
#import "LWJiaoLiuContatcsListTableViewCell.h"
#import "HYTopBarView.h"
#import "LWSystemListModel.h"
#import "LWClientManager.h"
#import "LWAddFriendDeatilViewController.h"

@interface LWSystemMessageListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * friendVerifiTableView;
@property (nonatomic, strong) UITableView * groupTableView;
@property (nonatomic, strong) HYTopBarView * topBarView;
@property (nonatomic, strong) UIScrollView * mainScrollView;
@property (nonatomic, strong) NSMutableArray<LWSystemListModel *> * listdatas_verifi;
@property (nonatomic, strong) NSMutableArray<LWSystemListModel *> * listdatas_sys;
@property (nonatomic, assign) NSInteger  curretnPage_sys;
@property (nonatomic, assign) NSInteger  totalPage_sys;
@property (nonatomic, assign) NSInteger  totalCount;
@property (nonatomic, assign) NSInteger  tabbarIndex;
@end

@implementation LWSystemMessageListViewController
//同意加群申请
//fromUserName=18526061161&toGroupId=58&fromUserId=525&toGroupName=%E6%9D%A8%E5%81%A5%E9%A1%BE%E9%97%AE%E7%BE%A4&groupApplyId=63
- (void)requestAgreeGroup:(NSString *)fromUserName toGroupId:(NSString *)toGroupId fromUserId:( NSString *)fromUserId toGroupName:(NSString *)toGroupName groupApplyId:(NSString *)groupApplyId
{
    [self requestPostWithUrl:@"app/appgroup/agreeGroup"
                        para:@{@"fromUserName":LWDATA(fromUserName),
                               @"toGroupId":LWDATA(toGroupId),
                               @"fromUserId":LWDATA(fromUserId),
                               @"toGroupName":LWDATA(toGroupName),
                               @"groupApplyId":LWDATA(groupApplyId),
                        }
                    paraType:(LWRequestParamTypeString) success:^(id  _Nonnull response) {
        if ([response[@"code"] intValue] == 0) {
            self.curretnPage_sys = 1;
            [self requestSystemMsg];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

//拒绝申请
//uid=696&groupId=77&groupApplyId=66
- (void)refuseGroup:(NSString *)uid groupId:(NSString *)groupId groupApplyId:(NSString *)groupApplyId
{
    [self requestPostWithUrl:@"app/appgroup/refuseGroup" para:@{@"uid":LWDATA(uid),@"groupId":LWDATA(groupId),@"groupApplyId":LWDATA(groupApplyId)} paraType:(LWRequestParamTypeString) success:^(id  _Nonnull response) {
        if ([response[@"code"] intValue] == 0) {
            self.curretnPage_sys = 1;
            [self requestSystemMsg];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

//系统消息列表
- (void)requestSystemMsg
{
    //    有未读系统消息时调用
    if (LWClientManager.share.unreadSysMsgNum != 0) {
        [LWClientManager.share requestReadSystemMsg:@"0"];
    }
    [self requestPostWithUrl:@"app/appgroupapply/msgList" para:@{@"page":@(_curretnPage_sys)} paraType:(LWRequestParamTypeString) success:^(id  _Nonnull response) {
        
        [self.groupTableView.mj_header endRefreshing];
        [self.groupTableView.mj_footer endRefreshing];
        
        NSDictionary *data = response[@"page"];
        self.curretnPage_sys = [data[@"currPage"] integerValue];
        self.totalPage_sys = [data[@"totalPage"] integerValue];
        NSArray *list = data[@"list"];
        if (self.curretnPage_sys == 1) {
            [self.listdatas_sys removeAllObjects];
        }
        for (NSDictionary *dic in list) {
            [self.listdatas_sys addObject:[LWSystemListModel modelWithDictionary:dic]];
        }
        [self.groupTableView reloadData];
        if (self.listdatas_sys.count == 0) {
            [self.view bringSubviewToFront:self.nothingView];
            self.nothingView.alpha = 1;
        }else{
            [self.view sendSubviewToBack:self.nothingView];
            self.nothingView.alpha = 0;
        }
        
        if (self.totalPage_sys <= self.curretnPage_sys) {
            [self.groupTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.groupTableView.mj_footer resetNoMoreData];
        }
    } failure:^(NSError * _Nonnull error) {
        [self.groupTableView.mj_header endRefreshing];
        [self.groupTableView.mj_footer endRefreshing];
    }];
}

// tag:1 同意 2拒绝
- (void)requestCaoZuoFriendApplyWithTag:(NSInteger)tag userid:(NSString *)userid
{
    //    uid=688&applyId=379&group=695
    NSString *url = @"app/appfriend/agreeFriend";
    NSDictionary *para;
    if (tag == 2) {
        //id=379
        url = @"app/appfriend/refuseFriend";
        para = @{@"id":userid};
    }else{
        
    }
    [self requestPostWithUrl:url para:para paraType:(LWRequestParamTypeString) success:^(id  _Nonnull response) {
        [zHud showMessage:@"已拒绝申请"];
        [self requestDatas];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

//好友y验证列表
- (void)requestDatas
{
    [self requestPostWithUrl:@"app/appfriendapply/msgList" Parameters:@{@"page":@(self.currPage)} success:^(id  _Nonnull response) {
        NSDictionary *data = response[@"page"];
        self.currPage = [data[@"currPage"] integerValue];
        self.totalPage = [data[@"totalPage"] integerValue];
        NSArray *list = data[@"list"];
        
        if (self.currPage == 1) {
            [self.listdatas_verifi removeAllObjects];
        }
        for (NSDictionary *dic in list) {
            [self.listdatas_verifi addObject:[LWSystemListModel modelWithDictionary:dic]];
        }
        [self.friendVerifiTableView reloadData];
        if (self.listdatas_verifi.count == 0) {
            //            [[zHud shareInstance] showMessage:@"暂无数据"];
            [self.view bringSubviewToFront:self.nothingView];
            self.nothingView.alpha = 1;
        }else{
            [self.view sendSubviewToBack:self.nothingView];
            self.nothingView.alpha = 0;
        }
        [self.friendVerifiTableView.mj_header endRefreshing];
        [self.friendVerifiTableView.mj_footer endRefreshing];
        
        
        if (self.totalPage <= self.currPage) {
            [self.friendVerifiTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.friendVerifiTableView.mj_footer resetNoMoreData];
        }
    } failure:^(NSError * _Nonnull error) {
        [self.friendVerifiTableView.mj_header endRefreshing];
        [self.friendVerifiTableView.mj_footer endRefreshing];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _curretnPage_sys = 1;
    self.title = @"系统消息";
    [self confiUI];
    [self requestDatas];
    [LWClientManager.share requestReadSystemMsg:@"1"];
    ADD_NOTI(requestDatas, @"refrshSysteMsgmList");
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.nothingView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.left.mas_equalTo(self.view);
        make.top.mas_equalTo(_topBarView.mas_bottom).mas_offset(0);
    }];
}

- (void)confiUI
{
    WEAKSELF(self)
    _topBarView = [HYTopBarView creatTopBarWithDataArr:@[@"好友验证",@"群系统消息"] selectColor:BASECOLOR_TEXTCOLOR callBack:^(NSInteger index) {
        weakself.curretnPage_sys = weakself.currPage = 1;
        index == 0 ?[weakself requestDatas]:[weakself requestSystemMsg];
        weakself.tabbarIndex = index;
        [weakself.mainScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*index, 1) animated:YES];
    }];
    _topBarView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:_topBarView];
    [_topBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(0);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-0);
        make.top.mas_equalTo(self.view.top).mas_offset(10);
        make.height.mas_offset((45));
    }];
    
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.topBarView.mas_bottom).mas_offset(10);
    }];
}

#pragma mark ------UITableViewDelegate----------

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWJiaoLiuContatcsListTableViewCell * cell =  [tableView dequeueReusableCellWithIdentifier:@"LWJiaoLiuContatcsListTableViewCell" forIndexPath:indexPath];
    [cell setBottomLine:1];
    [cell updateForVerifiCell];
    LWSystemListModel *model ;
    if (tableView == _groupTableView) {
        model = self.listdatas_sys[indexPath.row];
        cell.descL.text = [NSString stringWithFormat:@"申请加入%@",model.toGroupName];
        cell.nameL.text = model.fromUserName;
        cell.timelL.text = model.applyTime;
    }else{
        model = self.listdatas_verifi[indexPath.row];
        cell.descL.text = model.content;
        cell.nameL.text = model.toUser.username;
        cell.timelL.text = model.time;
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if([model.from integerValue] == [model.uid integerValue]){
        cell.sendApplyStatusL.hidden =  NO;
        cell.leftBtn.hidden = cell.rightBtn.hidden = YES;
        cell.sendApplyStatusL.text = (model.status == 0)?@"等待验证":(model.status == 1)?@"申请已通过":@"申请被拒绝";
    }else{
        cell.leftBtn.hidden = model.status != 0;
        cell.rightBtn.enabled = model.status == 0;
        cell.sendApplyStatusL.hidden =  YES;
        if (model.status == 1) {
            [cell.rightBtn setTitle:@"已同意" forState:UIControlStateNormal];
        }else if (model.status == 2){
            [cell.rightBtn setTitle:@"已拒绝" forState:UIControlStateNormal];
        }else{
            [cell.leftBtn setTitle:@"同意" forState:UIControlStateNormal];
            [cell.rightBtn setTitle:@"拒绝" forState:UIControlStateNormal];
        }
    }
    WEAKSELF(self)
    cell.block = ^(NSInteger tag) {
        if (weakself.tabbarIndex == 1) {
            if (tag == 1) {
                [weakself requestAgreeGroup:model.fromUserName toGroupId:model.toGroupId fromUserId:model.fromUserId toGroupName:model.toGroupName groupApplyId:model.groupApplyId];
            }else
            {
                [weakself refuseGroup:model.fromUserId groupId:model.toGroupId groupApplyId:model.groupApplyId];
            }
        }else{
            if (tag == 1) {
                LWAddFriendDeatilViewController *addfrienddeatil = [LWAddFriendDeatilViewController new];
                addfrienddeatil.systemModel = model;
                [self.navigationController pushViewController:addfrienddeatil animated:YES];
            }else{
                [weakself requestCaoZuoFriendApplyWithTag:tag userid:model.customId];
            }
        }
    };
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.friendVerifiTableView) {
        return self.listdatas_verifi.count;
    }else{
        return self.listdatas_sys.count;
    }
}


- (UIScrollView *)mainScrollView
{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, self.view.height-60-10)];
        _mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2, 1000);
        //        _mainScrollView.backgroundColor = UIColor.redColor;
        NSArray *sub = @[self.friendVerifiTableView,self.groupTableView];
        [_mainScrollView addSubviews:sub];
        for (int i = 0; i< sub.count; i++) {
            [sub[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(_mainScrollView);
                make.width.mas_offset(SCREEN_WIDTH);
                make.height.mas_offset(self.view.height - 60 -NAVIGATOR_HEIGHT);
                make.left.mas_equalTo(_mainScrollView.mas_left).mas_offset(SCREEN_WIDTH*i);
            }];
        }
        _mainScrollView.scrollEnabled = NO;
    }
    return _mainScrollView;
}

- (UITableView *)friendVerifiTableView
{
    if (!_friendVerifiTableView) {
        _friendVerifiTableView = [[UITableView alloc] init];
        _friendVerifiTableView.delegate = self;
        _friendVerifiTableView.dataSource = self;
        _friendVerifiTableView.rowHeight = 85;
        [_friendVerifiTableView registerClass:[LWJiaoLiuContatcsListTableViewCell class] forCellReuseIdentifier:@"LWJiaoLiuContatcsListTableViewCell"];
        _friendVerifiTableView.backgroundColor = UIColor.whiteColor;
        _friendVerifiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        WEAKSELF(self)
        _friendVerifiTableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            weakself.currPage = 1;
            [weakself requestDatas];
        }];
        _friendVerifiTableView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
            ++ weakself.currPage ;
            [weakself requestDatas];
        }];
    }
    return _friendVerifiTableView;
}

- (UITableView *)groupTableView
{
    if (!_groupTableView) {
        _groupTableView = [[UITableView alloc] init];
        _groupTableView.delegate = self;
        _groupTableView.dataSource = self;
        //        _groupTableView.estimatedRowHeight = 1;
        _groupTableView.rowHeight = 85;
        [_groupTableView registerClass:[LWJiaoLiuContatcsListTableViewCell class] forCellReuseIdentifier:@"LWJiaoLiuContatcsListTableViewCell"];
        _groupTableView.backgroundColor = UIColor.whiteColor;
        _groupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        WEAKSELF(self)
        _groupTableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            weakself.curretnPage_sys = 1;
            [weakself requestSystemMsg];
        }];
        _groupTableView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
            ++ weakself.curretnPage_sys ;
            [weakself requestSystemMsg];
        }];
    }
    return _groupTableView;
}
- (NSMutableArray *)listdatas_verifi
{
    if (!_listdatas_verifi) {
        _listdatas_verifi = [[NSMutableArray alloc] init];
    }
    return _listdatas_verifi;
}
- (NSMutableArray *)listdatas_sys
{
    if (!_listdatas_sys) {
        _listdatas_sys = [[NSMutableArray alloc] init];
    }
    return _listdatas_sys;
}
@end
