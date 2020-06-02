//
//  LWAddFriendDeatilViewController.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/15.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWAddFriendDeatilViewController.h"
#import "IQTextView.h"
#import "LWUserGroupModel.h"

@interface LWAddFriendDeatilViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) IQTextView * tv;
@property (nonatomic, strong) UITableView * tableview;
@property (nonatomic, strong) UIView * alearview;
@property (nonatomic, strong) UIView * fenzubgview;
@property (nonatomic, strong) NSMutableArray<LWUserGroupModel *> * listDatas;
@property (nonatomic, strong) UILabel * fenzuL;
@property (nonatomic, assign) NSInteger  selectIndex;
@end

@implementation LWAddFriendDeatilViewController
//app/appfriendtype/list
//获取分组列表
-(void)requestGroupDatas
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
        LWUserGroupModel *model = self.listDatas.firstObject;
        self.fenzuL.text = model.typeName;
        [self.tableview reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

//添加
- (void)clickSure
{
    LWUserGroupModel *model = self.listDatas[_selectIndex];
          NSString *url = @"app/appfriendapply/save";
          NSDictionary *para = @{@"fromUserId":LWDATA([zUserInfo shareInstance].userInfo.userId),
                                 @"toUserId":LWDATA(self.friendModel.userDm),
                                 @"friendTypeId":LWDATA(model.customId),
                                 @"remark":LWDATA(_tv.text)
          };
    if (_systemModel) {
//        uid=688&applyId=379&group=695
        url = @"app/appfriend/agreeFriend";
        para = @{@"uid":LWDATA(_systemModel.from),@"applyId":LWDATA(_systemModel.customId),@"group":LWDATA(model.customId)};
        [self requestPostWithUrl:url para:para paraType:(LWRequestParamTypeString) success:^(id  _Nonnull response) {
            if ([response[@"code"] integerValue] == 0) {
                POST_NOTI(@"refrshSysteMsgmList", nil);
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError * _Nonnull error) {
            
        }];
    }else{
        
        if ([[zUserInfo  shareInstance].userInfo.userId integerValue] == [_friendModel.userDm integerValue]) {
            [zHud showMessage:@"不能添加自己为好友"];
            return;
        }
        
        [self requestPostWithUrl:url para:para paraType:(LWRequestParamTypeBody) success:^(id  _Nonnull response) {
            NSString *msg = response[@"msg"];
            [zHud showMessage:msg];
            if ([response[@"code"] intValue] == 0) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError * _Nonnull error) {
            
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加好友";
    
    [self confiUI];
    
    [self requestGroupDatas];
}

- (void)confiUI
{
    UILabel *tishiL = [LWLabel lw_lable:@"提示" font:17 textColor:BASECOLOR_TEXTCOLOR];
    NSString *friendname = [NSString stringWithFormat:@"是否要加【%@】为好友？",[LWDATA(_friendModel.userName) isNotBlank]?LWDATA(_friendModel.userName):LWDATA(_friendModel.mobile)];
    if (_systemModel) {
        friendname = [NSString stringWithFormat:@"是否要加【%@】为好友？",_systemModel.toUser.username];
    }
    UILabel *tishidescL = [LWLabel lw_lable:friendname font:15 textColor:BASECOLOR_TEXTCOLOR];
    tishidescL.numberOfLines = 3;
    UILabel *fenzutitleL = [LWLabel lw_lable:@"请选择分组" font:15 textColor:BASECOLOR_TEXTCOLOR];
    UIView *fenzubgview = [UIView new];
    UILabel *fenzuL = [LWLabel lw_lable:@"默认" font:17 textColor:BASECOLOR_TEXTCOLOR];
    fenzuL.textAlignment = NSTextAlignmentCenter;
    _fenzuL = fenzuL;
    UIImageView *icon = [UIImageView new];
    icon.image = IMAGENAME(@"leftMenu_arrowDown");
    _fenzubgview = fenzubgview;
    UILabel *yanzhengL = [LWLabel lw_lable:@"请填写验证信息" font:15 textColor:BASECOLOR_TEXTCOLOR];
    _tv = [IQTextView new];
    _tv.placeholder = @"我是...";
    [fenzubgview addSubviews:@[fenzuL,icon]];
    _tv.font = kFont(15);
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(15);
        make.right.mas_equalTo(fenzubgview.mas_right).mas_offset(-10);
        make.centerY.mas_equalTo(fenzubgview.mas_centerY);
    }];
    [fenzuL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(fenzubgview.mas_left).mas_offset(1);
        make.right.mas_equalTo(icon.mas_right).mas_offset(-1);
        make.top.mas_equalTo(fenzubgview.mas_top).mas_offset(0);
        make.bottom.mas_equalTo(fenzubgview.mas_bottom).mas_offset(0);
    }];
    [self.view addSubviews:@[tishiL,tishidescL,fenzutitleL,fenzubgview,yanzhengL,_tv]];
    [tishiL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
        make.top.mas_equalTo(self.view.mas_top).mas_offset(20);
    }];
    [tishidescL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tishiL.mas_left).mas_offset(0);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-20);
        make.top.mas_equalTo(tishiL.mas_bottom).mas_offset(15);
    }];
    [fenzutitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tishidescL.mas_left).mas_offset(0);
        make.right.mas_equalTo(tishidescL.mas_right).mas_offset(-0);
        make.top.mas_equalTo(tishidescL.mas_bottom).mas_offset(15);
    }];
    [fenzubgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tishidescL.mas_left).mas_offset(0);
        make.right.mas_equalTo(tishidescL.mas_right).mas_offset(-0);
        make.top.mas_equalTo(fenzutitleL.mas_bottom).mas_offset(10);
        make.height.mas_offset(40);
    }];
    [yanzhengL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tishidescL.mas_left).mas_offset(0);
        make.right.mas_equalTo(tishidescL.mas_right).mas_offset(-0);
        make.top.mas_equalTo(fenzubgview.mas_bottom).mas_offset(15);
    }];
    [_tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tishidescL.mas_left).mas_offset(0);
        make.right.mas_equalTo(tishidescL.mas_right).mas_offset(-0);
        make.top.mas_equalTo(yanzhengL.mas_bottom).mas_offset(10);
        make.height.mas_offset(150);
    }];
    
    [_tv setBoundWidth:0.5 cornerRadius:4 boardColor:BASECOLOR_BOARD];
    [fenzubgview setBoundWidth:0.5 cornerRadius:4 boardColor:BASECOLOR_BOARD];
    
    UIButton *surebtn = [LWButton lw_button:@"添加" font:15 textColor:UIColor.whiteColor backColor:BASECOLOR_BLUECOLOR target:self acction:@selector(clickSure)];
    [self.view addSubview:surebtn];
    [surebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tishidescL.mas_left).mas_offset(0);
        make.right.mas_equalTo(tishidescL.mas_right).mas_offset(-0);
        make.top.mas_equalTo(_tv.mas_bottom).mas_offset(40);
        make.height.mas_offset(40);
    }];
    [surebtn setBoundWidth:0 cornerRadius:20 boardColor:BASECOLOR_BLUECOLOR];
    [fenzubgview ex_addTapAction:self selector:@selector(showalearview)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    LWUserGroupModel *model = self.listDatas[indexPath.row];
    cell.textLabel.text = model.typeName;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listDatas.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self dimissAlearview];
    LWUserGroupModel *model = self.listDatas[indexPath.row];
    self.fenzuL.text = model.typeName;
    _selectIndex = indexPath.row;
}

- (void)dimissAlearview
{
    [self.alearview removeFromSuperview];
    [self.tableview removeFromSuperview];
    self.alearview = nil;
    self.tableview = nil;
}

- (void)showalearview
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubviews:@[self.alearview,self.tableview]];
    
    CGRect rect = [self.fenzubgview convertRect:self.fenzubgview.bounds toView:window];
    [self.alearview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(window);
    }];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(window.mas_centerX);
        make.top.mas_equalTo(window.mas_top).mas_offset(rect.origin.y+40);
        make.width.mas_offset(250);
        make.height.mas_greaterThanOrEqualTo(200);
    }];
}

- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] init];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.rowHeight = 40;
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableview.tableFooterView = [UIView new];
    }
    return _tableview;
}

- (UIView *)alearview
{
    if (!_alearview) {
        _alearview = [[UIView alloc] init];
        _alearview.alpha = 0.3;
        _alearview.backgroundColor = UIColor.blackColor;
        [_alearview ex_addTapAction:self selector:@selector(dimissAlearview)];
    }
    return _alearview;
}

- (NSMutableArray *)listDatas
{
    if (!_listDatas) {
        _listDatas = [[NSMutableArray alloc] init];
    }
    return _listDatas;
}

@end
