//
//  zNetWorkManger.h
//  ZhuangBei
//
//  Created by aa on 2020/4/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 请求成功的Block
typedef void(^HttpRequestSuccess)(id responseObject);

/// 请求失败的Block
typedef void(^HttpRequestFailed)(NSError *error);

@interface zNetWorkManger : NSObject

+(void)GETworkWithUrl:(NSString*)url WithParamer:(id)param Success:(HttpRequestSuccess)loadSuccess Failure:(HttpRequestFailed)loadFailure;

+(void)POSTworkWithUrl:(NSString*)url WithParamer:(id)param Success:(HttpRequestSuccess)loadSuccess Failure:(HttpRequestFailed)loadFailure;

@end

NS_ASSUME_NONNULL_END
