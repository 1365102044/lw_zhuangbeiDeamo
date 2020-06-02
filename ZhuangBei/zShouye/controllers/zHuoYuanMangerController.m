//
//  zHuoYuanMangerController.m
//  ZhuangBei
//
//  Created by aa on 2020/5/7.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zHuoYuanMangerController.h"
#import "zHuoYuanScrollHeader.h"
@interface zHuoYuanMangerController ()

@property(strong,nonatomic)zHuoYuanScrollHeader * scrollHeader;

@property(strong,nonatomic)UIButton * button;

@end

@implementation zHuoYuanMangerController

-(zHuoYuanScrollHeader*)scrollHeader
{
    if (!_scrollHeader) {
        _scrollHeader = [[zHuoYuanScrollHeader alloc]init];
        _scrollHeader.bannerArray = @[@"1",@"2",@"3",@"4"];
    }
    return _scrollHeader;
}

-(UIButton*)button
{
    if (!_button) {
        _button = [[UIButton alloc]init];
        _button.titleLabel.font = kFont(16);
        [_button setBackgroundColor:[UIColor blackColor]];
        [_button setTitle:@"个人信息" forState:UIControlStateNormal];
        [_button setTitleColor: [kMainSingleton colorWithHexString:@"#FFFFFF" alpha:1] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(gotoLogInVC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollHeader];
    [self.view addSubview:self.button];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.scrollHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(SCREEN_WIDTH * 9/16);
    }];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.height.mas_equalTo(kWidthFlot(30));
        make.width.mas_equalTo(kWidthFlot(100));
    }];
}

-(void)gotoLogInVC
{
    zUserModel * model = [zUserInfo shareInstance].userInfo;
    NSDictionary * userInfo = [model mj_keyValues];
    
    NSString * userInfojson = [userInfo jsonString];
    
    NSString * content = [NSString stringWithFormat:@"您的信息\n%@",userInfojson];
    [LEEAlert alert].config
    .LeeTitle(@"温馨提示")
    .LeeContent(content)
    .LeeCancelAction(@"取消", ^{
        // 点击事件Block
    })
    .LeeAction(@"确认", ^{
        // 点击事件Block
    })
    .LeeShow();
    
//    zDengluController * dlVC = [[zDengluController alloc]init];
//    dlVC.title = @"登陆";
//    [self.navigationController pushViewController:dlVC animated:YES];
}


@end
