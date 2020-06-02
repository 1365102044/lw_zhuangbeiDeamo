//
//  UIImage+Extension.h
//  Project
//
//  Created by 郑键 on 17/1/11.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  绘制圆形图片
 *
 *  @return 返回圆角图片
 */
- (instancetype)ex_drawCircleImage;

/**
 *  改变图片颜色(纯色图片改变颜色使用)
 *
 *  @param color 希望修改的颜色
 *
 *  @return 修改颜色后的图片
 */
- (UIImage *)ex_imageWithColor:(UIColor *)color;

/**
 *  拍照上传出现图片旋转现象，为图片添加方向
 *
 *  @return 返回正常方向的图片
 */
- (UIImage *)ex_fixOrientation;

/**
 *  根据尺寸压缩图片
 *
 *  @param size 要压缩的尺寸
 *
 *  @return 压缩后的图片
 */
- (UIImage*)ex_originWithScaleToSize:(CGSize)size;

/**
 *  从图片中按指定的位置大小截取图片的一部分
 *
 *  @param image 要截取的图片
 *  @param rect 截取的范围
 *  @param scale 屏幕缩放因子范围1~3，UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale)配合使用，当图片按照固定尺寸重绘后，截取时，需要对应图片的缩放因子
 *  @return 截取后的图片
 */
- (UIImage *)ex_imageFromImage:(UIImage *)image
                        inRect:(CGRect)rect
                         scale:(CGFloat)scale;

/**
 *  将占位图片绘制在当前图片中央
 *
 *  @param image           image 居中的logo图片
 *  @param size            size 当前需要施画的范围
 *  @param backgroundColor backgroundColor 背景画布颜色
 *
 *  @return 绘制好的logo居中图片
 */
+ (UIImage *)ex_drawImage:(UIImage*)image
                     size:(CGSize)size
          backgroundColor:(UIColor *)backgroundColor;

/**
 *  指定图片拉伸区域
 *
 *  @param top          top
 *  @param bottom       bottom
 *  @param left         left
 *  @param right        right
 *  @return             返回指定拉伸区域的图片
 */
- (UIImage *)ex_resizableImageWithTop:(CGFloat)top
                               bottom:(CGFloat)bottom
                                 left:(CGFloat)left
                                right:(CGFloat)right;

#pragma mark - 二维码条码生成

/**
 *  二维码生成(Erica Sadun 原生代码生成)
 *
 *  @param string   内容字符串
 *  @param size 二维码大小
 *  @param color 二维码颜色
 *  @param backGroundColor 背景颜色
 *
 *  @return 返回一张图片
 */
+ (UIImage *)qrImageWithString:(NSString *)string
                          size:(CGSize)size
                         color:(UIColor *)color
               backGroundColor:(UIColor *)backGroundColor;

/**
 *  条形码生成(Third party)
 *
 *  @param code   内容字符串
 *  @param size  条形码大小
 *  @param color 条形码颜色
 *  @param backGroundColor 背景颜色
 *
 *  @return 返回一张图片
 */
+ (UIImage *)generateBarCode:(NSString *)code
                        size:(CGSize)size
                       color:(UIColor *)color
             backGroundColor:(UIColor *)backGroundColor;


/**
 *  高斯模糊 CoreImage
 */
+ (UIImage *)coreBlurImage:(UIImage *)image
           withBlurNumber:(CGFloat)blur;

/**
 *  vImage
 */
+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

/**
 获取视频帧图片
 
 @param videoURL        视频url
 @param time            时间
 @return                图片
 */
+ (UIImage*)ex_thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;



/** 纠正图片的方向 */
- (UIImage *)fixOrientation;

/** 按给定的方向旋转图片 */
- (UIImage*)rotate:(UIImageOrientation)orient;

/** 垂直翻转 */
- (UIImage *)flipVertical;

/** 水平翻转 */
- (UIImage *)flipHorizontal;

/** 将图片旋转degrees角度 */
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

/** 将图片旋转radians弧度 */
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;


/// 压缩图片到指定大小内的图片
/// @param image 图片
/// @param maxLength 上线大小
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;


@end
