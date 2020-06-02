//
//  LWTool.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/13.
//  Copyright © 2020 aa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWTool : NSObject


/// 字符串转字典
/// @param string 需要转换的字符串
+ (NSDictionary *)stringToDictory:(NSString *)string;


/// 字典转字符串
/// @param dic 字典
+ (NSString *)dictoryToString:(NSDictionary *)dic;


/// 字典转json字符串
/// @param dict 字典
+ (NSString *)dictoryToJsonString:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
