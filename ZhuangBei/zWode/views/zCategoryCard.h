//
//  zCategoryCard.h
//  ZhuangBei
//  分类选项
//  Created by aa on 2020/4/27.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^categoryItemTapBack)(NSInteger type);

@interface zCategoryCard : UIView

@property(copy,nonatomic)categoryItemTapBack categoryTapBack;

@end

NS_ASSUME_NONNULL_END
