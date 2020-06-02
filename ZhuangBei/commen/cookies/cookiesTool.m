//
//  cookiesTool.m
//  ZhuangBei
//
//  Created by aa on 2020/4/30.
//  Copyright © 2020 aa. All rights reserved.
//

#import "cookiesTool.h"

@implementation cookiesTool


+ (void)saveCookieWithName:(NSString *)name value:(NSString *)value domain:(NSString *)domain{
    // 保存
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    // 给cookie取名
    [cookieProperties setObject:name  forKey:NSHTTPCookieName];
    // 设置值
    [cookieProperties setObject:value forKey:NSHTTPCookieValue];
    // 存放目录 通常@"/"
    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
    // 设置本地过期时间 一年后
    // 不设置关掉App就会清空
    [cookieProperties setValue:[NSDate dateWithTimeIntervalSinceNow:3600*24*30*12] forKey:NSHTTPCookieExpires];
    // 设置域名
    [cookieProperties setObject:[NSURL URLWithString:domain].host forKey:NSHTTPCookieDomain];
    // 生成cookie
    NSHTTPCookie *httpCookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    // 存入仓库
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:httpCookie];
}

+ (void)deleteCookieWithName:(NSString *)name {
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        NSLog(@"cookie%@", cookie);
        if ([cookie.name isEqualToString:name]) {
            [cookieJar deleteCookie:cookie];
        }
    }
}

+ (NSHTTPCookie *)cookieWithName:(NSString *)name {
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        NSLog(@"cookie%@", cookie);
        if ([cookie.name isEqualToString:name]) {
            return cookie;
        }
    }
    return nil;
}


@end
