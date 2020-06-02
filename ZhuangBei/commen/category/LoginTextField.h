//
//  LoginTextField.h
//  ZhuangBei
//
//  Created by aa on 2020/4/22.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextField+maxLength.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginTextField : UITextField

@property(strong, nonatomic)UIImage *icon;

@property(copy, nonatomic)NSString *myPlaceHolder;

@property(strong,nonatomic)UIButton * show;

@end

NS_ASSUME_NONNULL_END
