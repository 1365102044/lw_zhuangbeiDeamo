//
//  zNetWorkManger.m
//  ZhuangBei
//
//  Created by aa on 2020/4/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zNetWorkManger.h"
#import <AFNetworking.h>
#import "zDengluController.h"
#import "MainNavController.h"

@implementation zNetWorkManger

+(void)GETworkWithUrl:(NSString*)url WithParamer:(id)param Success:(HttpRequestSuccess)loadSuccess Failure:(HttpRequestFailed)loadFailure
{
    [[zHud shareInstance]show];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置请求体数据为json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //设置响应体数据为json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    //请求体，参数（NSDictionary 类型）
    //    NSDictionary *parameters = param;
    [manager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[zHud shareInstance]hild];
        NSLog(@"%@",responseObject);
        loadSuccess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[zHud shareInstance]hild];
        NSInteger code = error.code;
        if (code == -1003) {
            [[zHud shareInstance]showMessage:@"请求超时"];
        }
        loadFailure(error);
    }];
}

+(void)POSTworkWithUrl:(NSString*)url WithParamer:(id)param Success:(HttpRequestSuccess)loadSuccess Failure:(HttpRequestFailed)loadFailure
{
//    [[zHud shareInstance]show];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置请求体数据为json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //设置响应体数据为json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"charset=UTF-8",@"octet-stream", nil];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    NSData *cookiesdata = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsCookie];
    if([cookiesdata length]) {
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
        NSHTTPCookie *cookie;
        for (cookie in cookies) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        }
    }
    
    NSString *requestUrl = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manager POST:requestUrl parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[zHud shareInstance]hild];
        NSLog(@"\n*************url:%@,\n para:%@ \n*********responseObject:%@",url,param,responseObject); 
        loadSuccess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {        
        LWLog(@"\n***********请求失败**url:%@,\n para:%@ \n*********error:%@********",url,param,error);
        NSInteger code = error.code;
        if (code == -1004 || code == -1001) {
            [[zHud shareInstance]showMessage:@"请求超时,无法连接服务器"];
        }else if (code == 3840) {
            
            [[zUserInfo shareInstance]deleate];
            
            NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:url]];
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies];
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:kUserDefaultsCookie];
            [[zHud shareInstance]showMessage:@"登录信息超时,请重新登录"];
            //登录超时重新登录
            zDengluController * rootVC  = [[zDengluController alloc]init];
            MainNavController * rootNav = [[MainNavController alloc]initWithRootViewController:rootVC];
            rootNav.navigationBar.hidden = YES;
             UIApplication *app = [UIApplication sharedApplication];
            [app keyWindow].rootViewController = rootNav;
        }else
        {
            [[zHud shareInstance]hild];
        }
        loadFailure(error);
    }];
}



@end
