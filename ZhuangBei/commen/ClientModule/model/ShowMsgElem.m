//
//  ShowMsgElem.m
//  IMDemo
//
//  Created by  Admin on 2018/1/9.
//  Copyright © 2018年  Admin. All rights reserved.
//

#import "ShowMsgElem.h"

@implementation ShowMsgElem


// 声明自定义类参数类型

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper;
{
    return  @{@"isMySelf":@"mine",
              @"userID":@"uid",
              @"time":@[@"sendTime",@"time"],
              @"uavatar":@[@"avatar",@"uavatar"],
    };
}

-(NSString *)username
{
    if(_username){
        return _username;
    }
    return @"佚名";
}

- (LWMsgType)msgType
{
    
    return MessageIsImage(self.content)?LWMsgTypeImage:LWMsgTypeText;
}

- (NSString *)imagePath
{
    if (self.msgType == LWMsgTypeImage) {
        if (self.content.length <  6) {
            return nil;
        }
        NSString *tem1 = [self.content substringWithRange:NSMakeRange(4, self.content.length - 1 - 4)];
        return [NSString stringWithFormat:@"%@%@",kApiPrefix_PIC,tem1];
    }
    return nil;
}

@end
