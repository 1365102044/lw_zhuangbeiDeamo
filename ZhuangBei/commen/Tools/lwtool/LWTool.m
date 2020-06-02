//
//  LWTool.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/13.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWTool.h"

@implementation LWTool


/// 字符串转字典
/// @param string 需要转换的字符串
+ (NSDictionary *)stringToDictory:(NSString *)string
{
    NSError *err;
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
     
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    
    return dic;
}


/// 字典转字符串
/// @param dic 字典
+ (NSString *)dictoryToString:(NSDictionary *)dic
{
    NSError *parseError ;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&parseError];
     
    NSString * str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    while ([str containsString:@"\n"]) {
        str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    }
    while ([str containsString:@" "]) {
        str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    return str;
}


/// 字典转json字符串
/// @param dict 字典
+ (NSString *)dictoryToJsonString:(NSDictionary *)dict

{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}
@end
