//
//  UIView+Extension.m
//  Project
//
//  Created by 郑键 on 17/1/11.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

/**
 *  添加单击事件
 *
 *  @param target 对象
 *  @param selector 事件
 */
- (void)ex_addTapAction:(id)target selector:(SEL)selector
{
    UITapGestureRecognizer *tapGestureRecognizer        = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    tapGestureRecognizer.numberOfTapsRequired           = 1;
    self.userInteractionEnabled                         = YES;
    [self addGestureRecognizer:tapGestureRecognizer];
}

/**
 *  添加长按事件
 *
 *  @param target 对象
 *  @param selector 事件
 */
- (void)ex_addLongPressAction:(id)target selector:(SEL)selector
{
    UILongPressGestureRecognizer *recognizer            = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:selector];
    self.userInteractionEnabled                         = YES;
    [self addGestureRecognizer:recognizer];
}

/**
 *  获取View所在控制器
 *
 *  @return view所在控制器
 */
- (UIViewController *)ex_viewController
{
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder                      = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

/**
 *  设置圆角
 *
 *  @param cornerRadius 圆角角度
 */
- (void)ex_setCornerRadius:(CGFloat)cornerRadius
{
    UIBezierPath *maskPath                              = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                                                byRoundingCorners:UIRectCornerAllCorners
                                                                                      cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer                             = [[CAShapeLayer alloc]init];
    maskLayer.frame                                     = self.bounds;
    maskLayer.path                                      = maskPath.CGPath;
    self.layer.mask                                     = maskLayer;
}

/**
 *  添加高斯模糊
 *
 *  @param style 高斯模糊种类
 */
- (void)ex_setBlurEffect:(UIBlurEffectStyle)style
{
    UIBlurEffect *blur                      = [UIBlurEffect effectWithStyle:style];
    UIVisualEffectView *effectview          = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.frame                        = self.bounds;
    [self insertSubview:effectview atIndex:0];
}

/**
 *  添加阴影
 *
 *  @param color 阴影颜色
 */
- (void)ex_addShadowWithColor:(UIColor *)color
{
    self.layer.shadowColor          = [UIColor blackColor].CGColor;
    self.layer.masksToBounds        = NO;
    self.layer.contentsScale        = [UIScreen mainScreen].scale;
    self.layer.shadowOpacity        = 0.06f;
    self.layer.shadowRadius         = 3.0f;
    self.layer.shadowOffset         = CGSizeMake(0,0);
    self.layer.shouldRasterize      = YES;
    self.layer.rasterizationScale   = [UIScreen mainScreen].scale;
}

/**
 *  单阴影
 */
- (void)ex_addSingleShadowWithColor
{
    self.layer.shadowColor = RGBA(51, 59, 69, 0.3).CGColor;
    self.layer.shadowOffset = CGSizeMake(-5, 5);
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowRadius = 10;
}

#pragma mark - properties--setter&getter

- (void)setEx_x:(CGFloat)ex_x
{
    CGRect frame                                        = self.frame;
    frame.origin.x                                      = ex_x;
    self.frame                                          = frame;
}

- (CGFloat)ex_x
{
    return self.frame.origin.x;
}

- (void)setEx_y:(CGFloat)ex_y
{
    CGRect frame                                        = self.frame;
    frame.origin.y                                      = ex_y;
    self.frame                                          = frame;
}

- (CGFloat)ex_y
{
    return self.frame.origin.y;
}

- (void)setEx_width:(CGFloat)ex_width
{
    CGRect frame                                        = self.frame;
    frame.size.width                                    = ex_width;
    self.frame                                          = frame;
}

- (CGFloat)ex_width
{
    return self.frame.size.width;
}

- (void)setEx_height:(CGFloat)ex_height
{
    CGRect frame                                        = self.frame;
    frame.size.height                                   = ex_height;
    self.frame                                          = frame;
}

- (CGFloat)ex_height
{
    return self.frame.size.height;
}

- (void)setEx_size:(CGSize)ex_size
{
    CGRect frame                                        = self.frame;
    frame.size                                          = ex_size;
    self.frame                                          = frame;
}

- (CGSize)ex_size
{
    return self.frame.size;
}

- (void)setEx_origin:(CGPoint)ex_origin
{
    CGRect frame                                        = self.frame;
    frame.origin                                        = ex_origin;
    self.frame                                          = frame;
}

- (CGPoint)ex_origin
{
    return self.frame.origin;
}


-(void)setEx_centerX:(CGFloat)ex_centerX
{
    CGPoint center                                      = self.center;
    center.x                                            = ex_centerX;
    self.center                                         = center;
}

-(CGFloat)ex_centerX
{
    return self.center.x;
}

-(void)setEx_centerY:(CGFloat)ex_centerY
{
    CGPoint center                                      = self.center;
    center.y                                            = ex_centerY;
    self.center                                         = center;
}

-(CGFloat)ex_centerY
{
    return self.center.y;
}


-(void) setBoundWidth:(float) width cornerRadius:(float) radius
{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = width;
    self.layer.borderColor = [[UIColor clearColor]CGColor];
}

-(void) setBoundWidth:(float) width cornerRadius:(float) radius boardColor:(UIColor *)color
{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = width;
    self.layer.borderColor = [color CGColor];
}
/**
 指定位置切角
 rectCorner:枚举 eg:UIRectCornerTopLeft
 radius: 切角度数，
 */
- (void)setRoundCornerWithCorner:(UIRectCorner)rectCorner cornerRadius:(float)radius
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}



- (void)drawBorder{
    self.layer.borderColor = [UIColor colorWithWhite:0.7 alpha:0.5].CGColor;
    self.layer.borderWidth = 0.5;
}

- (void)drawBorderWithColor:(UIColor *)color{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = 0.5;
}

- (void)drawBorderWithCornerRadius:(CGFloat)radius{
    self.layer.cornerRadius = radius;
}

- (void)drawBorderWithColor:(UIColor *)color radius:(CGFloat)radius{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = radius;
}

- (void)drawBorderWithColor:(UIColor *)color borderWidth:(CGFloat)width radius:(CGFloat)radius{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
    self.layer.cornerRadius = radius;
}

- (void)addShadow{
    self.layer.shadowColor = [UIColor redColor].CGColor;
    //    if (view == _SGUserView) {
    //        view.layer.shadowOffset = CGSizeMake(0, 0);
    //        view.layer.shadowOpacity = 0.7f;
    //        view.layer.shadowRadius = 0.5f;
    //        return;
    //    }
    self.layer.shadowOffset = CGSizeMake(10, 1);
    self.layer.shadowOpacity = 2;
    self.layer.shadowRadius = 2;
}
@end
