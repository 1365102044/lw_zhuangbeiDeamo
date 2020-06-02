//
//  loginCard.h
//  ZhuangBei
//
//  Created by aa on 2020/4/25.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^loginCardEventBack)(NSInteger btnTag);

typedef void(^loginTapBack)(NSString*phone,NSString*passWord,BOOL remmber);

@interface zLoginCard : UIView

@property(copy,nonatomic)loginCardEventBack eventBack;

@property(copy,nonatomic)loginTapBack logInBack;

@end

NS_ASSUME_NONNULL_END
