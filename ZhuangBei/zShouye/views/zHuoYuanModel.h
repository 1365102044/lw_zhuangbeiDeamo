//
//  zHuoYuanModel.h
//  ZhuangBei
//
//  Created by aa on 2020/5/7.
//  Copyright © 2020 aa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface zHuoYuanModel : NSObject

@property(copy,nonatomic)NSString * name;

@property(strong,nonatomic)NSArray * hyArray;

@property(assign,nonatomic)BOOL select;

@property(assign,nonatomic)NSInteger indexSection;

@end

NS_ASSUME_NONNULL_END
