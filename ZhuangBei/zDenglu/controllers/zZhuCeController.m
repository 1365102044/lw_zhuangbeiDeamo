//
//  zZhuCeController.m
//  ZhuangBei
//
//  Created by aa on 2020/4/25.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zZhuCeController.h"
#import "zhuCeCard.h"
#import "zQuestionController.h"
#import <AFNetworking.h>
#import "zXieYiController.h"

@interface zZhuCeController ()

@property(strong,nonatomic)zhuCeCard * zhuceView;

@property(strong,nonatomic)NSDictionary * userDic;

@end

@implementation zZhuCeController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(zhuCeCard*)zhuceView
{
    if (!_zhuceView) {
        __weak typeof(self)weakSelf = self;
        _zhuceView = [[zhuCeCard alloc]init];
        _zhuceView.getMessageCodeTapBack = ^(NSString * _Nonnull phoneNum) {
            NSString *url = [NSString stringWithFormat:@"%@%@?phone=%@",kApiPrefix,kSendVerificationCode,phoneNum];
//            @{@"phone":phoneNum}
            [weakSelf postDataWithUrl:url WithParam:nil];
        };
        _zhuceView.zhuceBack = ^(NSMutableDictionary * _Nonnull userDic) {
//            NSLog(@"注册信息:%@",userDic);
            weakSelf.userDic = userDic;
            NSString *url = [NSString stringWithFormat:@"%@%@",kApiPrefix,kRegister];
            [weakSelf postDataWithUrl:url WithParam:userDic];
        };
        _zhuceView.backLogin = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        
        _zhuceView.xieyiBack = ^(NSInteger type) {
            zXieYiController * xyVC = [[zXieYiController alloc]init];
            xyVC.type = type;
            xyVC.title = @"注册协议";
            [weakSelf.navigationController pushViewController:xyVC animated:YES];
        };
    }
    return _zhuceView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [self.view addSubview:self.zhuceView];
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.zhuceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuide);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

-(void)sendPassRegister:(NSInteger)type
{
    NSString * url = [NSString stringWithFormat:@"%@%@?isSure=%ld",kApiPrefix,kRegister,(long)type];
    [self postDataWithUrl:url WithParam:self.userDic];
}

-(void)RequsetFileWithUrl:(NSString*)url WithError:(NSError*)err
{
    if ([url containsString:kSendVerificationCode]) {
        [[zHud shareInstance]showMessage:@"获取验证码失败"];
        return;
    }
    if ([url containsString:kRegister]) {
        [[zHud shareInstance]showMessage:@"注册失败,请检查网络"];
        return;
    }
}

-(void)RequsetSuccessWithData:(id)data AndUrl:(NSString*)url
{
    if ([url containsString:kSendVerificationCode]) {
        NSDictionary * dic = data;
        NSString * code = dic[@"code"];
        NSString * msg = dic[@"msg"];
        NSLog(@"验证码成功%@",dic);
        if ([code integerValue]==500) {
            [[zHud shareInstance]showMessage:msg];
        }else
        {
            [[zHud shareInstance]showMessage:@"获取验证码成功"];
        }
        
    }
    if ([url containsString:kRegister]) {
        NSDictionary * dic = data;
        NSLog(@"注册成功%@",dic);
        NSString * type = dic[@"data"][@"type"];
        NSString * msg =dic[@"msg"];
        if ([type integerValue] == 0) {
            //注册成功 进入首页
            [[zHud shareInstance]showMessage:@"注册成功"];
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        if ([type integerValue] == 1) {
            //注册失败
            [[zHud shareInstance]showMessage:msg];
            return;
        }
        if ([type integerValue] == 2) {
            //需要答题
            
            [LEEAlert alert].config
            .LeeTitle(@"温馨提示")
            .LeeContent(msg)
            .LeeCancelAction(@"取消", ^{
                // 点击事件Block
                [[zHud shareInstance]showMessage:@"注册失败"];
            })
            .LeeAction(@"确认", ^{
                // 点击事件Block
            zQuestionController * quesionVC = [[zQuestionController alloc]init];
                quesionVC.userDic = self.userDic;
                quesionVC.title = @"测试答题";
            [self.navigationController pushViewController:quesionVC animated:YES];
            })
            .LeeShow();
            return;
        }
        if ([type integerValue] == 3) {
            //需要确定邀请人是否为xxx
//            [[zHud shareInstance]showMessage:@"注册成功,需确定邀请人"];
            [LEEAlert alert].config
            .LeeTitle(@"温馨提示")
            .LeeContent(msg)
            .LeeCancelAction(@"取消", ^{
                [[zHud shareInstance] showMessage:@"请重新输入邀请码"];
            })
            .LeeAction(@"确认", ^{
                // 点击事件Block
                [self sendPassRegister:1];
//                [self.navigationController popViewControllerAnimated:YES];
            })
            .LeeShow();
            return;
        }
        return;
    }
}


@end
