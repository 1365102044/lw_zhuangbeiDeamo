//
//  zBusinessLoactionModel.m
//  ZhuangBei
//
//  Created by aa on 2020/5/23.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zBusinessLoactionModel.h"

@implementation zBusinessLoactionModel

+(NSDictionary*)mj_replacedKeyFromPropertyName{
    return @{
        @"cityid":@"id",
    };
}

@end
