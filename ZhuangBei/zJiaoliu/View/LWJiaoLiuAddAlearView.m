//
//  LWJiaoLiuAddAlearView.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/15.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWJiaoLiuAddAlearView.h"


@interface LWJiaoLiuAddAlearView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView * bgview;
@property (nonatomic, strong) UIView * mainView;

@property (nonatomic, strong) UITableView * tableview;
@property (nonatomic, strong) NSArray * datas;

@end

@implementation LWJiaoLiuAddAlearView

- (void)dimiss
{
    [_bgview removeFromSuperview];
    [_mainView removeAllSubviews];
    [_mainView removeFromSuperview];
    _tableview = nil;
    _bgview = nil;
    _mainView = nil;
}

- (void)showView
{
//    if (!_bgview||!_mainView||!_tableview) {
        [self createUI];
//    }else{
//        _bgview.alpha = 0.3;
//        _mainView.alpha = 1;
//    }
    
}

- (void)createUI
{
    _bgview = [UIView new];
    _bgview.backgroundColor = UIColor.blackColor;
    _bgview.alpha = 0.3;
    [_bgview ex_addTapAction:self selector:@selector(dimiss)];
    
    _mainView = [UIView new];
    _mainView.backgroundColor = UIColor.whiteColor;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    window.backgroundColor = UIColor.redColor;
    [window addSubview:_bgview];
    [window addSubview:_mainView];
    
    [_bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(window);
    }];
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(200);
        make.height.mas_offset(55*3);
        make.right.mas_equalTo(window.mas_right).mas_offset(-0);
        make.top.mas_equalTo(window.mas_top).mas_offset(NAVIGATOR_HEIGHT);
    }];
    
    self.datas = @[@{@"icon":@"addnewchat",@"name":@"创建群聊"},
                   @{@"icon":@"addnewicon",@"name":@"添加好友/群"},
                   @{@"icon":@"friendmanager",@"name":@"好友分组管理"},];
    _tableview = [[UITableView alloc] init];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.rowHeight = 55;
    [_mainView addSubview:_tableview];
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(_mainView);
    }];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
        cell.imageView.image = IMAGENAME(self.datas[indexPath.row][@"icon"]);
        cell.textLabel.text = self.datas[indexPath.row][@"name"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self dimiss];
    if (self.block) {
        self.block(indexPath.row);
    }
}

@end
