//
//  UIImageView+LWImageView.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/6.
//  Copyright © 2020 aa. All rights reserved.
//

#import "UIImageView+LWImageView.h"
#import "zInterfacedConst.h"


@implementation UIImageView (LWImageView)

/// 通过imageId加载图片
/// @param imageId 图片id
/// @param placeholderImage 站位图
- (void)z_imageWithImageId:(NSString *)imageId placeholderImage:(NSString *)placeholderImage
{
    if (!imageId) {
        return;
    }
    if (placeholderImage) {
        [self sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@app/appfujian/download?attID=%@",kApiPrefix,imageId]] placeholderImage:IMAGENAME(placeholderImage)];
    }else{
        [self sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@app/appfujian/download?attID=%@",kApiPrefix,imageId]]];
    }
}

/// 通过imageId加载图片   使用内部默认使用展位图
/// @param imageId 图片id
- (void)z_imageWithImageId:(NSString *)imageId
{
    [self z_imageWithImageId:imageId placeholderImage:@"testicon"];
}

@end

