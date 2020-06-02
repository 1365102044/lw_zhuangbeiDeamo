//
//  LWButton.h
//  ZhuangBei
//
//  Created by LWQ on 2020/4/30.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWButton : UIButton

+ (instancetype)lw_button:(NSString *)title font:(CGFloat)font textColor:(UIColor *)textcolor backColor:(UIColor *)backcolor target:(id)target acction:(SEL)acction;

@end

NS_ASSUME_NONNULL_END
