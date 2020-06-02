//
//  zDengluController.m
//  ZhuangBei
//
//  Created by aa on 2020/4/22.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zDengluController.h"
#import "AppDelegate.h"
#import "zLoginCard.h"
#import "zZhuCeController.h"
#import "zZhaoHuiController.h"
#import "zQuestionController.h"
#import "zUserInfo.h"
//#import "MainTabBarController.h"
#import "LSTabBarController.h"
#import "MainNavController.h"

@interface zDengluController ()

@property(strong,nonatomic)zLoginCard * loginView;

@property(strong,nonatomic)NSDictionary * loginParam;

@end

@implementation zDengluController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(zLoginCard*)loginView
{
    if (!_loginView) {
        __weak typeof(self)weakSelf = self;
        _loginView = [[zLoginCard alloc]init];
        _loginView.eventBack = ^(NSInteger btnTag) {
            if (btnTag ==5) {
                //注册
                zZhuCeController * zhuceVC = [[zZhuCeController alloc]init];
                zhuceVC.title = @"用户注册";
                [weakSelf.navigationController pushViewController:zhuceVC animated:YES];
                return;
            }
        };
        _loginView.logInBack = ^(NSString * _Nonnull phone, NSString * _Nonnull passWord, BOOL remmber) {
            if (remmber) {
                //是否记住密码
                [zUserInfo shareInstance].userAccount = phone;
                [zUserInfo shareInstance].userPassWord = passWord;
                [[zUserInfo shareInstance]saveUserInfo];
            }else
            {
                [[zUserInfo shareInstance]deleate];
            }
          //登陆
            NSDictionary * loginParam =@{@"username":phone,@"password":passWord};
            weakSelf.loginParam = loginParam;
            NSString *url = [NSString stringWithFormat:@"%@%@",kApiPrefix,kLogin];
            
            [weakSelf postDataWithUrl:url WithParam:loginParam];
        };
    }
    return _loginView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.loginView];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

-(void)changeRootVC
{
    LSTabBarController * rootVC  = [[LSTabBarController alloc]init];
    MainNavController * rootNav = [[MainNavController alloc]initWithRootViewController:rootVC];
    rootNav.navigationBar.hidden = YES;
     UIApplication *app = [UIApplication sharedApplication];
    [app keyWindow].rootViewController = rootNav;
}


-(void)RequsetFileWithUrl:(NSString*)url WithError:(NSError*)err
{
    if ([url containsString:kLogin]) {
        [[zHud shareInstance]showMessage:@"登陆失败，无法连接服务器"];
//        [self changeRootVC];
    }
}

-(void)RequsetSuccessWithData:(id)data AndUrl:(NSString*)url
{
    if ([url containsString:kLogin]) {
        NSDictionary * dic = data;
        NSLog(@"登陆成功:%@",dic);
        NSString * code = dic[@"code"];
        NSDictionary * dataDic = dic[@"data"];
        NSString * msg = dic[@"msg"];
        if ([code integerValue] == 500) {
            [[zHud shareInstance]showMessage:msg];
        }else
        {
            [[zHud shareInstance]showMessage:@"登陆成功"];
            [zUserInfo shareInstance].userAccount = self.loginParam[@"username"];
            [zUserInfo shareInstance].userPassWord = self.loginParam[@"password"];
            
//            add by lw 2020年05月25日10:13:17 调整代码执行顺序，d保存个人信息后，需要即刻请求
            NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:url]];
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies];
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:kUserDefaultsCookie];
            
            zUserModel * model = [zUserModel mj_objectWithKeyValues:dataDic];
            [zUserInfo shareInstance].userInfo = model;
            [[zUserInfo shareInstance]saveUserInfo];
            
            [self changeRootVC];
        }
    }
}


@end
