//
//  LWSystemListModel.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/14.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWSystemListModel.h"

@implementation userModel

@end

@implementation LWSystemListModel
// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"toUser":userModel.class,
    };
}
@end
