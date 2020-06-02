//
//  cookiesTool.h
//  ZhuangBei
//
//  Created by aa on 2020/4/30.
//  Copyright © 2020 aa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface cookiesTool : NSObject

/**
 生成cookie

 @param name cookie的名字
 @param value cookie的值
 @param domain 域名
 */
+ (void)saveCookieWithName:(NSString *)name value:(NSString *)value domain:(NSString *)domain;


/**
 删除cookie

 @param name cookie的名字
 */
+ (void)deleteCookieWithName:(NSString *)name;


/**
 获取cookie

 @param name cookie的名字
 @return 对应的cookie，可能为空
 */
+ (NSHTTPCookie *)cookieWithName:(NSString *)name;


@end

NS_ASSUME_NONNULL_END
