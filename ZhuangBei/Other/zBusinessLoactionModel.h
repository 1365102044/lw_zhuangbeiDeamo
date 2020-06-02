//
//  zBusinessLoactionModel.h
//  ZhuangBei
//
//  Created by aa on 2020/5/23.
//  Copyright © 2020 aa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface zBusinessLoactionModel : NSObject

@property(assign,nonatomic)NSInteger cityid;
@property(copy,nonatomic)NSString * title;
@property(assign,nonatomic)NSInteger pid;
@property(assign,nonatomic)BOOL select;

@end

NS_ASSUME_NONNULL_END
