//
//  LWAddFriendModel.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/15.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWAddFriendModel.h"

@implementation LWAddFriendModel
// 声明自定义类参数类型
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"groupdescription":@[@"description"],
             @"customId":@"id",
             @"nickName":@[@"nickName",@"nickname"],
    };
}
@end
