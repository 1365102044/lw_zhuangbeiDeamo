//
//  LWServiceModel.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/14.
//  Copyright © 2020 aa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//网络请求的参数传递方式
typedef NS_ENUM(NSUInteger, RequestParamType) {
    RequestParamTypeDict,       //字典方式
    RequestParamTypeString,     //字符串拼接方式
    RequestParamTypeBody,           // body
};

/**
 请求成功的block
 @param response 响应体数据
 */

typedef void(^RequestSuccess)(id response);
/**
 请求失败的block
 */
typedef void(^RequestFailure)(NSError *error);

@interface LWServiceModel : NSObject

@property (nonatomic, strong) id param;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, assign) RequestParamType  paramType;
@property (nonatomic, copy) RequestSuccess success;
@property (nonatomic, copy) RequestFailure fail;
//@property (nonatomic, strong) id bodyparam;


/// 初始化快捷方式
/// @param url 请求失败的url
/// @param param 参数
/// @param paramType 请求类型
+ (instancetype)modelWithurl:(NSString *)url
                       param:(id)param
                   paramType:(RequestParamType)paramType
                     success:(RequestSuccess)success
                        fail:(RequestFailure)fail;

@end

NS_ASSUME_NONNULL_END
