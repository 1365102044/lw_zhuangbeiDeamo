//
//  PermissionKit.m
//  guoziyunparent
//
//  Created by LIU JIA on 2019/8/26.
//  Copyright © 2019 xuxianwang. All rights reserved.
//

#import "PermissionKit.h"
#import "PermissionCheck.h"
#import "CustomAlertView.h"

@implementation PermissionKit

+ (void)checkNetworkPermission:(PermissionCheckHandle)handle {
    [PermissionCheck openEventServiceWithBolck:^(BOOL isOpen) {
        if (handle) {
            handle(isOpen);
        }
    }];
}

+ (void)checkCameraPermission:(PermissionCheckHandle)handle {
    [PermissionCheck openCaptureDeviceServiceWithBlock:^(BOOL isOpen) {
        if (handle) {
            handle(isOpen);
        }
    } alert:^{
        // 提示
        CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"请在iPhone的“设置-隐私”选项中，允许国字云家长访问你的摄像头和麦克风" descr:@"" buttonNames:@[@"确定"]];
        [alert show];
    }];
}

+ (void)checkAlbumPermission:(PermissionCheckHandle)handle {
    [PermissionCheck openAlbumServiceWithBlock:^(BOOL isOpen) {
        if (handle) {
            handle(isOpen);
        }
    } alert:^{
        // 提示
        CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"请在iPhone的“设置-隐私”选项中，允许国字云家长访问你的相册" descr:@"" buttonNames:@[@"确定"]];
        [alert show];
    }];
}

@end
