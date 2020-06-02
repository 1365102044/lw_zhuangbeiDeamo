//
//  PermissionCheck.m
//  guoziyunparent
//
//  Created by LIU JIA on 2019/8/26.
//  Copyright © 2019 xuxianwang. All rights reserved.
//

#import "PermissionCheck.h"
#import <CoreLocation/CoreLocation.h>
#import <UserNotifications/UserNotifications.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreTelephony/CTCellularData.h>

@implementation PermissionCheck


//+ (void)openLocationServiceWithBlock:(ReturnBlock)returnBlock  {
//    BOOL isOPen = NO;
//    if ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
//        isOPen = YES;
//    }
//    if (returnBlock) {
//        returnBlock(isOPen);
//    }
//}

//+ (void)openMessageNotificationServiceWithBlock:(ReturnBlock)returnBlock
//{
//    BOOL isOpen = NO;
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
//    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
//    if (setting.types != UIUserNotificationTypeNone) {
//        isOpen = YES;
//    }
//#else
//    UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
//    if (type != UIRemoteNotificationTypeNone) {
//        isOpen = YES;
//    }
//#endif
//    if (returnBlock) {
//        returnBlock(isOpen);
//    }
//}

+ (void)openCaptureDeviceServiceWithBlock:(PermissionCheckHandle)checkHandle alert:(PermissionCustomAlertHandle)alertHandle
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (checkHandle) {
                checkHandle(granted);
            }
        }];
    } else if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        if (checkHandle) {
            checkHandle(NO);
        }
        if (alertHandle) {
            alertHandle();
        }
    } else {
        checkHandle(YES);
    }
#endif
}

+ (void)openAlbumServiceWithBlock:(PermissionCheckHandle)checkHandle alert:(PermissionCustomAlertHandle)alertHandle
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    if (authStatus == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                if (checkHandle) {
                    checkHandle(YES);
                }
            } else {
                if (checkHandle) {
                    checkHandle(NO);
                }
            }
        }];
    } else if (authStatus == PHAuthorizationStatusRestricted || authStatus == PHAuthorizationStatusDenied) {
        if (checkHandle) {
            checkHandle(NO);
        }
        if (alertHandle) {
            alertHandle();
        }
    } else {
        if (checkHandle) {
            checkHandle(YES);
        }
    }
#endif
}

//+ (void)openRecordServiceWithBlock:(ReturnBlock)returnBlock
//{
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
//    AVAudioSessionRecordPermission permissionStatus = [[AVAudioSession sharedInstance] recordPermission];
//    if (permissionStatus == AVAudioSessionRecordPermissionUndetermined) {
//        [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
//            if (returnBlock) {
//                returnBlock(granted);
//            }
//        }];
//    } else if (permissionStatus == AVAudioSessionRecordPermissionDenied) {
//        returnBlock(NO);
//    } else {
//        returnBlock(YES);
//    }
//#endif
//}

//+ (void)openPeripheralServiceWithBolck:(ReturnBlock)returnBolck
//{
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
//    CBPeripheralManagerAuthorizationStatus cbAuthStatus = [CBPeripheralManager authorizationStatus];
//    if (cbAuthStatus == CBPeripheralManagerAuthorizationStatusNotDetermined) {
//        if (returnBolck) {
//            returnBolck(NO);
//        }
//    } else if (cbAuthStatus == CBPeripheralManagerAuthorizationStatusRestricted || cbAuthStatus == CBPeripheralManagerAuthorizationStatusDenied) {
//        if (returnBolck) {
//            returnBolck(NO);
//        }
//    } else {
//        if (returnBolck) {
//            returnBolck(YES);
//        }
//    }
//#endif
//}

+ (void)openEventServiceWithBolck:(PermissionCheckHandle)checkHandle
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
    if (checkHandle) {
        checkHandle(YES);
    }
#endif
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
    CTCellularData *cellularData = [[CTCellularData alloc]init];
    cellularData.cellularDataRestrictionDidUpdateNotifier =  ^(CTCellularDataRestrictedState state){
        //获取联网状态
        switch (state) {
            case kCTCellularDataRestricted:
                if (checkHandle) {
                    checkHandle(NO);
                }
                break;
            case kCTCellularDataNotRestricted:
                NSLog(@"Not Restricted /不受限制的");
                if (checkHandle) {
                    checkHandle(YES);
                }
                break;
            case kCTCellularDataRestrictedStateUnknown:
                NSLog(@"Unknown/不明网路");
                if (checkHandle) {
                    checkHandle(YES);
                }
                break;
            default:
                if (checkHandle) {
                    checkHandle(YES);
                }
                break;
        };
    };
#endif
}

@end
