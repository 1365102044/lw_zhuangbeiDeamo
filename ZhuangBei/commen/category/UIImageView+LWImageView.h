//
//  UIImageView+LWImageView.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/6.
//  Copyright © 2020 aa. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (LWImageView)

/// 通过imageId加载图片
/// @param imageId 图片id
/// @param placeholderImage 站位图
- (void)z_imageWithImageId:(NSString *)imageId placeholderImage:(NSString *)placeholderImage;

/// 通过imageId加载图片   使用内部默认使用展位图
/// @param imageId 图片id
- (void)z_imageWithImageId:(NSString *)imageId;

@end

NS_ASSUME_NONNULL_END
