//
//  LWButton.m
//  ZhuangBei
//
//  Created by LWQ on 2020/4/30.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWButton.h"

@implementation LWButton

+ (instancetype)lw_button:(NSString *)title font:(CGFloat)font textColor:(UIColor *)textcolor backColor:(UIColor *)backcolor target:(id)target acction:(SEL)acction
{
    LWButton *btn = [[LWButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:textcolor forState:UIControlStateNormal];
    btn.titleLabel.font = kFont(font);
    btn.backgroundColor = backcolor;
    [btn addTarget:target action:acction forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
@end
