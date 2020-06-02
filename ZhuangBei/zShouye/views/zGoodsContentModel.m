//
//  zGoodsContentModel.m
//  ZhuangBei
//
//  Created by aa on 2020/5/18.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zGoodsContentModel.h"

@implementation zGoodsContentModel

+(NSDictionary*)mj_replacedKeyFromPropertyName{
    return @{
        @"goodsid":@"id",
    };
}

@end
