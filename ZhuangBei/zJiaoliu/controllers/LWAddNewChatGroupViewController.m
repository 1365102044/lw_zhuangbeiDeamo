//
//  LWAddNewChatGroupViewController.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/18.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWAddNewChatGroupViewController.h"
#import "LWAddNewGroupModel.h"

@interface LWAddNewChatGroupViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITextField * tf;
@property (nonatomic, strong) UITableView * tableview;
@property (nonatomic, strong) UIView * alearview;
@property (nonatomic, strong) NSMutableArray<LWAddNewGroupModel *> * listDatas;
@property (nonatomic, strong) UIView * fenzubgview;
@property (nonatomic, strong) UILabel * fenzuL;
@property (nonatomic, assign) NSInteger  selectIndex;
@end

@implementation LWAddNewChatGroupViewController

- (void)requestDatas
{
    [self requestPostWithUrl:@"app/imgroupclassify/list" para:@{@"limit":@"999"} paraType:(LWRequestParamTypeString) success:^(id  _Nonnull response) {
        NSArray *list = response[@"page"][@"list"];
        for (NSDictionary *dict in list) {
            [self.listDatas addObject:[LWAddNewGroupModel modelWithDictionary:dict]];
        }
        LWAddNewGroupModel *model = self.listDatas.firstObject;
        self.fenzuL.text = model.name;
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}

- (void)clickSure
{
    if (![_tf.text isNotBlank]) {
        [zHud showMessage:@"请输入群聊名称"];
        return;
    }
    LWAddNewGroupModel *model = self.listDatas[_selectIndex];
    [self requestPostWithUrl:@"app/appgroup/save" para:@{@"groupName":LWDATA(_tf.text),@"classifyId":LWDATA(model.customId)} paraType:(LWRequestParamTypeString) success:^(id  _Nonnull response) {
        if ([response[@"code"] intValue] == 0) {
            [zHud showMessage:@"创建群聊成功!"];
            POST_NOTI(@"refreshJiaoLiuListDataKey", nil);
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [zHud showMessage:response[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self confiUI];
    
    [self requestDatas];
}

- (void)confiUI
{
    UILabel *titleL = [LWLabel lw_lable:@"请在下方输入群组名称" font:20 textColor:BASECOLOR_TEXTCOLOR];
    UITextField *tf = [UITextField new];
    tf.placeholder = @"填写名称...";
    tf.font = kFont(15);
    titleL.textAlignment = NSTextAlignmentCenter;
    _tf = tf;
    UIView *fenzubgview = [UIView new];
    _fenzubgview = fenzubgview;
    UILabel *fenzuL = [LWLabel lw_lable:@"默认" font:17 textColor:BASECOLOR_TEXTCOLOR];
    _fenzuL = fenzuL;
    fenzuL.textAlignment = NSTextAlignmentCenter;
    UIImageView *icon = [UIImageView new];
    icon.image = IMAGENAME(@"leftMenu_arrowDown");
    [fenzubgview addSubviews:@[fenzuL,icon]];
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
    UIView *line = [UIView new];
    line.backgroundColor = BASECOLOR_BOARD;
    [self.view addSubviews:@[titleL,fenzubgview,tf,line]];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-20);
        make.top.mas_equalTo(self.view.mas_top).mas_offset(30);
    }];
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(titleL);
        make.top.mas_equalTo(titleL.mas_bottom).mas_offset(25);
        make.height.mas_offset(40);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(titleL);
        make.top.mas_equalTo(tf.mas_bottom).mas_offset(0);
        make.height.mas_offset(1);
    }];
    [fenzubgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleL.mas_left).mas_offset(0);
        make.right.mas_equalTo(titleL.mas_right).mas_offset(-0);
        make.top.mas_equalTo(tf.mas_bottom).mas_offset(20);
        make.height.mas_offset(40);
    }];
    UIButton *surebtn = [LWButton lw_button:@"添加" font:15 textColor:UIColor.whiteColor backColor:BASECOLOR_BLUECOLOR target:self acction:@selector(clickSure)];
    [self.view addSubview:surebtn];
    [surebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleL.mas_left).mas_offset(0);
        make.right.mas_equalTo(titleL.mas_right).mas_offset(-0);
        make.top.mas_equalTo(fenzubgview.mas_bottom).mas_offset(60);
        make.height.mas_offset(40);
    }];
    [surebtn setBoundWidth:0 cornerRadius:20 boardColor:BASECOLOR_BLUECOLOR];
    [fenzubgview ex_addTapAction:self selector:@selector(showalearview)];
    [fenzubgview setBoundWidth:1 cornerRadius:0 boardColor:BASECOLOR_BOARD];
    
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
//        make.width.mas_offset(250);
        make.left.right.mas_equalTo(self.fenzubgview);
        make.height.mas_greaterThanOrEqualTo(200);
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    LWAddNewGroupModel *model = self.listDatas[indexPath.row];
    cell.textLabel.text = model.name;
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
    LWAddNewGroupModel *model = self.listDatas[indexPath.row];
    self.fenzuL.text = model.name;
    _selectIndex = indexPath.row;
}

- (void)dimissAlearview
{
    [self.alearview removeFromSuperview];
    [self.tableview removeFromSuperview];
    self.alearview = nil;
    self.tableview = nil;
}

- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] init];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.rowHeight = 40;
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
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
