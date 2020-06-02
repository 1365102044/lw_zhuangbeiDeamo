//
//  UIButton+typeLayout.m
//  longteng
//
//  Created by helong on 16/7/4.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "UIButton+typeLayout.h"

@implementation UIButton (typeLayout)

- (void)layoutButtonWithEdgeInsetsStyle:(HLButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space
{
    //1、得到imageView和titleLabel的宽、高
    CGFloat imageWidth = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0;
    CGFloat labelHeight = 0;
    if([UIDevice currentDevice].systemVersion.floatValue >=8.0)
    {
        //由于iOS8中titleLabel的size为0，分开设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    }
    else
    {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    //2、声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    //3、根据style和space设置
    switch (style) {
        case HLButtonEdgeInsetsStyleTop:
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, -imageHeight-space/2.0, 0);
            break;
        case HLButtonEdgeInsetsStyleLeft:
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, space/2.0);
            break;
        case HLButtonEdgeInsetsStyleBottom:
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, imageWidth);
            break;
        case HLButtonEdgeInsetsStyleRight:
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWidth - space/2.0, 0, imageWidth+space/2.0);
            break;
            
        default:
            break;
    }
    
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
    self.width = imageWidth + labelWidth + space;
}

@end
