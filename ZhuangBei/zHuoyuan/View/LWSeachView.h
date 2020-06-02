//
//  LWSeachView.h
//  ZhuangBei
//
//  Created by LWQ on 2020/4/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^callBlock)(NSInteger tag, NSString * str);

@interface LWSeachView : UIView<UITextFieldDelegate>

@property (nonatomic, strong) UITextField * tf;
@property (nonatomic, copy) callBlock block;
+ (instancetype)seachview:(callBlock)block;

@end

NS_ASSUME_NONNULL_END
