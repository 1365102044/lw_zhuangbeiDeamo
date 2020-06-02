//
//  LWJiaoLiuModel.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/11.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWJiaoLiuModel.h"


@implementation friendItemModel

-(NSString *)avatarID
{
    if ([_avatar isNotBlank] && [_avatar containsString:@"attID="]) {
        NSArray *ids = [_avatar componentsSeparatedByString:@"attID="];
        return ids.lastObject;
    }
    return nil;
}

-(NSString *)username
{
    if(_username){
        return _username;
    }
    return @"佚名";
}
@end


@implementation friendListModel
// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"list":friendItemModel.class,
    };
}

@end


@implementation imGroupListModel
// 声明自定义类参数类型
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"groupName":@[@"groupname",@"groupName"],
             @"customId":@"id"};
}
@end

@implementation LWJiaoLiuModel
// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"group":imGroupListModel.class,
             @"friend":friendListModel.class,
             @"imGroupList":imGroupListModel.class,
    };
}

@end
