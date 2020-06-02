//
//  LWLabel.h
//  ZhuangBei
//
//  Created by LWQ on 2020/4/30.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWBaseLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LWLabel : LWBaseLabel

+ (instancetype)lw_lable:(NSString *)text font:(CGFloat)font textColor:(UIColor *)textcolor;

+ (instancetype)lw_lable:(NSString *)text font:(CGFloat)font textColor:(UIColor *)textcolor backColor:(UIColor *)backcolor;

@end

NS_ASSUME_NONNULL_END
