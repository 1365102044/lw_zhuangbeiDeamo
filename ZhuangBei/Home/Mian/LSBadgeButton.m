//
//  LSBadgeButton.m
//  TabBar
//
//  Created by Airy on 16/4/12.
//  Copyright © 2016年 Airy. All rights reserved.
//

#import "LSBadgeButton.h"

@implementation LSBadgeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        self.layer.masksToBounds = YES;
        
        self.titleLabel.font = [UIFont systemFontOfSize:7];
        UIImage *image = [UIImage imageNamed:@"main_badge"];
        [self setBackgroundImage:image
                        forState:UIControlStateNormal];
        
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 1, 0, 0);
        
        CGFloat wh = 16;
        CGFloat x = [UIScreen mainScreen].bounds.size.width / 4 / 2 + (image.size.width / 4) + 3;
        
        self.frame = CGRectMake(x, 2, wh, wh);
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    if (badgeValue.length > 0) {
        
        NSUInteger value = badgeValue.integerValue;
        
        self.hidden = value == 0;
        
        NSString *text = value > 99 ? @"99+" : badgeValue;
        
        [self setTitle:text forState:UIControlStateNormal];
    }
}

@end
