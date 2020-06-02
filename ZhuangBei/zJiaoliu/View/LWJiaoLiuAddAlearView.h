//
//  LWJiaoLiuAddAlearView.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/15.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^selectIndexBlock)(NSInteger index);
@interface LWJiaoLiuAddAlearView : UIView
@property (nonatomic, copy) selectIndexBlock block;
- (void)showView;
@end

NS_ASSUME_NONNULL_END
