//
//  LWHuoYuanDaTingModel.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/6.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWHuoYuanDaTingModel.h"

@implementation LWHuoYuanDaTingModel

@end

@implementation LWHuoYuanThreeLevelModel

// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"gysList":gysListModel.class};
}

@end


@implementation gysListModel


@end
