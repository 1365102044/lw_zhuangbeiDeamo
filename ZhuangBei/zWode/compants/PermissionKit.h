//
//  PermissionKit.h
//  guoziyunparent
//
//  Created by LIU JIA on 2019/8/26.
//  Copyright © 2019 xuxianwang. All rights reserved.
//  权限检测封装

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PermissionCheckHandle)(BOOL enable);

@interface PermissionKit : NSObject

/** 网络权限检测*/
+ (void)checkNetworkPermission:(PermissionCheckHandle)handle;

/** 检测相机权限，弹出提示 */
+ (void)checkCameraPermission:(PermissionCheckHandle)handle;

/** 检测相册权限，弹出提示 */
+ (void)checkAlbumPermission:(PermissionCheckHandle)handle;

@end

NS_ASSUME_NONNULL_END
