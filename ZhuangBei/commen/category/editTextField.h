//
//  editTextField.h
//  ZhuangBei
//
//  Created by aa on 2020/5/3.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^textFildTapBack)(void);
typedef void(^eyesButtonTapBack)(NSInteger show);

NS_ASSUME_NONNULL_BEGIN

@interface editTextField : UITextField

@property(assign,nonatomic)BOOL  canShow;//是否有隐藏显示按钮

@property(assign,nonatomic)BOOL  Show;//当前是显示还是隐藏

@property(assign,nonatomic)BOOL canTap;//是否可以点击，返回点击事件

@property(strong, nonatomic)UIImage *icon;

@property(copy, nonatomic)NSString *myPlaceHolder;

@property(copy,nonatomic)textFildTapBack tapBack;

@property(copy,nonatomic)eyesButtonTapBack eyesTapBack;

@end

NS_ASSUME_NONNULL_END
