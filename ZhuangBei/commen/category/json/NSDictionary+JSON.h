//
//  NSDictionary+JSON.h
//  xxsdu
//
//  Created by LIU JIA on 2018/8/16.
//  Copyright © 2018年 LIU JIA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSON)
/** 转为JSON字符串 */
- (NSString*)jsonString;
/** 转为JSON NSData */
- (NSData*)jsonData;
@end
