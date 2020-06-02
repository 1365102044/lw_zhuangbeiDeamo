//
//  JShareApp.h
//  guoziyunparent
//
//  Created by LIU JIA on 2019/8/14.
//  Copyright © 2019 xuxianwang. All rights reserved.
//  分享封装

#import <Foundation/Foundation.h>
#import <JSHAREService.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    /** 未安装客户端 */
    JShareAppErrorNotInstall,
} JShareAppError;

/** 分享成功回调， info用来传回调信息 */
typedef void(^ShareHandle)(id info);

@interface JShareApp : NSObject

/** 分享网页 */
+ (void)shareWebURLWithPlatform:(JSHAREPlatform)platform title:(NSString *)title text:(NSString *)text url:(NSString *)url icon:(NSString *)iconUrl success:(ShareHandle _Nullable)successHandle fail:(ShareHandle _Nullable)failHandle;

/** 分享图片 */
+ (void)shareImageWithPlatform:(JSHAREPlatform)platform imageUrl:(NSString *)url OrImage:(UIImage*)image success:(ShareHandle)successHandle fail:(ShareHandle)failHandle;

@end

NS_ASSUME_NONNULL_END
