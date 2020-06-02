//
//  zNoContentView.h
//  ZhuangBei
//  无网络页面
//  Created by aa on 2020/4/22.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^retryButtonTapBack)(void);

@interface zNoContentView : UIView

@property(copy,nonatomic)retryButtonTapBack retryTapBack;

@end

NS_ASSUME_NONNULL_END
