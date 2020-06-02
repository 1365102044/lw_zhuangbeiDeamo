//
//  AppDelegate.m
//  ZhuangBei
//
//  Created by aa on 2020/4/21.
//  Copyright © 2020 aa. All rights reserved.
//

#import "AppDelegate.h"
//#import "MainTabBarController.h"
#import "MainNavController.h"
#import "zDengluController.h"
#import "LWClientManager.h"
#import "IQKeyboardManager.h"
#import "LSTabBarController.h"
#import "JSHAREService.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.window = [[UIWindow alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
    JSHARELaunchConfig *config = [[JSHARELaunchConfig alloc] init];
    config.appKey = JGAPPK;
    config.WeChatAppId = weXinAppId;
    config.WeChatAppSecret = weiXinSecret;
    config.QQAppId = qqAppId;
    config.QQAppKey = qqAppKey;
    [JSHAREService setupWithConfig:config];
    
    NSString *version= [UIDevice currentDevice].systemVersion;
    if(version.doubleValue >=13.0) {
        // 针对13.0 以上的iOS系统进行处理
    }
    if (@available(iOS 13.0, *)) {
                
    } else
    {
//        NSHTTPCookie * cookie = [cookiesTool cookieWithName:kLoginUserInfo];
        NSString * token =  [zUserInfo shareInstance].userInfo.token;
        if (token.length>0) {
            //登录状态 进入首页
            LSTabBarController * rootVC  = [[LSTabBarController alloc]init];
            MainNavController * rootNav = [[MainNavController alloc]initWithRootViewController:rootVC];
            rootNav.navigationBar.hidden = YES;
            self.window.rootViewController = rootNav;
            [self.window makeKeyAndVisible];
            
        }else
        {
            //未登录登录状态 登录
            zDengluController * rootVC  = [[zDengluController alloc]init];
            MainNavController * rootNav = [[MainNavController alloc]initWithRootViewController:rootVC];
            rootNav.navigationBar.hidden = YES;
            self.window.rootViewController = rootNav;
            [self.window makeKeyAndVisible];
        }
    }
    
    
//    配置
    [[LWClientManager share] installConfigure];
    
    [IQKeyboardManager sharedManager].enable = YES;
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)){
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    if (@available(iOS 13.0, *)) {
        return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
    } else {
        // Fallback on earlier versions
        return nil;
    }
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)){
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
