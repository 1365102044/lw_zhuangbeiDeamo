//
//  NSDictionary+NSNull.m
//  VISSApp
//
//  Created by fujunzhi on 15/9/11.
//  Copyright (c) 2015年 QunBao. All rights reserved.
//

#import "NSDictionary+NSNull.h"

@implementation NSDictionary (NSNull)

- (id) notNullObjectForKey:(id)key
{
    id obj = self[key];
    if ([obj isKindOfClass:[NSNull class]] || !obj)
    {
        return nil;
    }
    else if ([obj isKindOfClass:[NSString class]])
    {
        NSString *objStr = [obj uppercaseString];
        NSRange range = [objStr rangeOfString:@"NULL"];
        if (range.location != NSNotFound && objStr.length-range.length <= 2)
            return nil;
    }
    return obj;
}

+ (NSMutableDictionary *)nullDicToDic:(NSDictionary *)dic{
    
    NSMutableDictionary *resultDic = [@{} mutableCopy];
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return resultDic;
    }
    for (NSString *key in [dic allKeys]) {
        if ([(id)[dic objectForKey:key] isKindOfClass:[NSNull class]]) {
            [resultDic setValue:@"" forKey:key];
        }else{
            [resultDic setValue:[dic objectForKey:key] forKey:key];
        }
    }
    return resultDic;
}

@end
