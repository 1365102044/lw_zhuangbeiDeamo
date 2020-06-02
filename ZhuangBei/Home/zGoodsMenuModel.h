//
//  zGoodsMenuModel.h
//  ZhuangBei
//
//  Created by aa on 2020/5/17.
//  Copyright © 2020 aa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface zGoodsMenuModel : NSObject

@property(copy,nonatomic)NSString * title;

@property(copy,nonatomic)NSString * lastNode;

@property(assign,nonatomic)NSInteger  typeId;

@property(strong,nonatomic)NSArray * children;

@property(assign,nonatomic)BOOL select;

@property(assign,nonatomic)NSInteger indexSection;

@end

NS_ASSUME_NONNULL_END
