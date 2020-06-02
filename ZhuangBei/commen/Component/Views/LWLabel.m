//
//  LWLabel.m
//  ZhuangBei
//
//  Created by LWQ on 2020/4/30.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWLabel.h"

@implementation LWLabel

+ (instancetype)lw_lable:(NSString *)text font:(CGFloat)font textColor:(UIColor *)textcolor
{
    LWLabel *lable = [LWLabel lw_lable:text font:font textColor:textcolor backColor:UIColor.whiteColor];
    return lable;
}

+ (instancetype)lw_lable:(NSString *)text font:(CGFloat)font textColor:(UIColor *)textcolor backColor:(UIColor *)backcolor
{
    LWLabel *lable = [[LWLabel alloc] init];
    lable.font = kFont(font);
    lable.text = text;
    lable.textColor = textcolor;
    lable.backgroundColor = backcolor;
    return lable;
}

@end
