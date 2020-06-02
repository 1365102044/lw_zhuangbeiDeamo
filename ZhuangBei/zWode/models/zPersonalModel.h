//
//  zPersonalModel.h
//  ZhuangBei
//
//  Created by aa on 2020/5/3.
//  Copyright © 2020 aa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface zPersonalModel : NSObject

@property(strong,nonatomic)NSString * name;

@property(strong,nonatomic)NSString * content;

@property(strong,nonatomic)NSArray * city;

@property(assign,nonatomic)BOOL canShow;

@property(assign,nonatomic)NSInteger index;

@end

NS_ASSUME_NONNULL_END
