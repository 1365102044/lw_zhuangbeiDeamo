//
//  LWServiceModel.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/14.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWServiceModel.h"

@implementation LWServiceModel

/// 初始化快捷方式
/// @param url 请求失败的url
/// @param param 参数
/// @param paramType 请求类型
+ (instancetype)modelWithurl:(NSString *)url
                       param:(id)param
                   paramType:(RequestParamType)paramType
                     success:(RequestSuccess)success
                        fail:(RequestFailure)fail;
{
    LWServiceModel *model = [LWServiceModel new];
    model.url = url;
    model.param = param;
    model.paramType = paramType;
    model.success = success;
    model.fail = fail;
    return model;
}

@end
