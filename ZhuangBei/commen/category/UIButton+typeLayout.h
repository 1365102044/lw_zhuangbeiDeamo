//
//  UIButton+typeLayout.h
//  longteng
//
//  Created by helong on 16/7/4.
//  Copyright © 2016年 helong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (typeLayout)

typedef NS_ENUM(NSUInteger,HLButtonEdgeInsetsStyle)
{
    HLButtonEdgeInsetsStyleTop,//image在上，label在下
    HLButtonEdgeInsetsStyleLeft,//image在左,label在右
    HLButtonEdgeInsetsStyleBottom,//image在下，label在上
    HLButtonEdgeInsetsStyleRight//image在右,label在左
};

/**
 *  设置button内部的image和title的布局样式(必须放在约束之后，不然获取不到image的大小)
 *
 *  @param style 布局样式
 *  @param space 间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(HLButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space;

@end
