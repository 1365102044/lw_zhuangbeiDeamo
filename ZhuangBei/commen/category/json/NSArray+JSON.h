//
//  NSArray+JSON.h
//  guoziyunparent
//
//  Created by LIU JIA on 2019/8/1.
//  Copyright © 2019 xuxianwang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (JSON)

/** 数组转 JSON 字符串 */
- (NSString *)jsonString;

@end

NS_ASSUME_NONNULL_END
