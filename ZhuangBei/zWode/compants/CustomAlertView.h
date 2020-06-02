//
//  CustomAlertView.h
//  xxsdu
//
//  Created by LIU JIA on 2019/1/30.
//  Copyright © 2019 LIU JIA. All rights reserved.
//  定制确认框

#import <UIKit/UIKit.h>
#import "CustomIOSAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomAlertView : CustomIOSAlertView
@property(strong, nonatomic, readonly)UITextField *tf;
/** 自定义初始化，响应可用基类自带的方式，Block 或者 Delegate */
- (instancetype)initWithTitle:(NSString*)title descr:( NSString* _Nullable )descr buttonNames:(NSArray*)buttonNames;
/** 自定义初始化，响应可用基类自带的方式，Block 或者 Delegate */
- (instancetype)initWithTitle:(NSString*)title descr:( NSString* _Nullable )descr buttonNames:(NSArray*)buttonNames icon:(NSString *)iconName;
/** 使用此方法时，将descr设置为 " \n " 占位*/
- (void)showTextField;
@end

NS_ASSUME_NONNULL_END
