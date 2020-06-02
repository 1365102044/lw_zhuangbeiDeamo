//
//  HeaderManager.h
//  guoziyunparent
//
//  Created by LIU JIA on 2020/4/8.
//  Copyright © 2020 xuxianwang. All rights reserved.
//  更换用户头像

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 更换回调*/
typedef void (^HeaderManagerAction)(void);
typedef void(^HeaderManagerChange)(UIImage *image, NSString *ossUrl);

@interface HeaderManager : NSObject
/** 单例*/
+ (instancetype)inst;
/** 展示菜单*/
- (void)showMenuWithController:(UIViewController *)controller startUpload:(HeaderManagerAction)startHandle change:(HeaderManagerChange)changeHandle fail:(HeaderManagerAction)failHandle;
@end

NS_ASSUME_NONNULL_END
