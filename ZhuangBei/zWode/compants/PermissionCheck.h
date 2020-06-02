//
//  PermissionCheck.h
//  guoziyunparent
//
//  Created by LIU JIA on 2019/8/26.
//  Copyright © 2019 xuxianwang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 是权限是否开启回调 */
typedef void(^PermissionCheckHandle)(BOOL isOpen);
/** 可在此回调做自定义提示 */
typedef void(^PermissionCustomAlertHandle)(void);

@interface PermissionCheck : NSObject

/** 定位权限 */
//+ (void)openLocationServiceWithBlock:(ReturnBlock)returnBlock;

/** 推送权限 */
//+ (void)openMessageNotificationServiceWithBlock:(ReturnBlock)returnBlock;

/** 拍摄权限 */
+ (void)openCaptureDeviceServiceWithBlock:(PermissionCheckHandle)checkHandle alert:(PermissionCustomAlertHandle)alertHandle;

/** 相册权限 */
+ (void)openAlbumServiceWithBlock:(PermissionCheckHandle)checkHandle alert:(PermissionCustomAlertHandle)alertHandle;

/** 麦克风权限 */
//+ (void)openRecordServiceWithBlock:(ReturnBlock)returnBlock;

/** 蓝牙权限 */
//+ (void)openPeripheralServiceWithBolck:(ReturnBlock)returnBolck;

/** 联网权限，如果iOS版本小于9.0则返回YES，因为SDK不支持判断 */
+ (void)openEventServiceWithBolck:(PermissionCheckHandle)checkHandle;

/** 。。。 */

@end

NS_ASSUME_NONNULL_END
