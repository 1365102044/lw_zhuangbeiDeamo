//
//  zDengluRequst.h
//  ZhuangBei
//
//  Created by aa on 2020/4/22.
//  Copyright © 2020 aa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 请求成功的block
 
 @param info     返回信息
 @param response 响应体数据
 */
typedef void(^PPRequestSuccess)(id response);
/**
 请求失败的block
 
 @param extInfo 扩展信息
 */
typedef void(^PPRequestFailure)(NSError *error);


@interface zDengluRequst : NSObject

#pragma mark - 登陆退出
/** 登录*/
+ (NSURLSessionTask *)getLoginWithParameters:(id)parameters success:(PPRequestSuccess)success failure:(PPRequestFailure)failure;
/** 退出*/
+ (NSURLSessionTask *)getExitWithParameters:(id)parameters success:(PPRequestSuccess)success failure:(PPRequestFailure)failure;


@end

NS_ASSUME_NONNULL_END
