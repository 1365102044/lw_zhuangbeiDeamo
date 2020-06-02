//
//  zSettingCellView.h
//  ZhuangBei
//
//  Created by aa on 2020/5/1.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^settingCellClickBack)(void);

@interface zSettingCellView : UIView

@property(copy,nonatomic)settingCellClickBack settingBack;

@property(strong,nonatomic)NSString * name;

@property(strong,nonatomic)NSString * content;

@property(assign,nonatomic)BOOL isPhoneNum;

@end

NS_ASSUME_NONNULL_END
