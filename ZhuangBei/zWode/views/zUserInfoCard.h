//
//  zUserInfoCard.h
//  ZhuangBei
//  用户信息
//  Created by aa on 2020/4/27.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zUserCenterModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^userInfoTapBack)(NSInteger type);

@interface zUserInfoCard : UIView

@property(strong,nonatomic)NSString * myNumbers;

@property(strong,nonatomic)NSString * mygoodsNumbers;

@property(strong,nonatomic)NSString * mybusinessNumbers;

@property(strong,nonatomic)zUserCenterModel * userCenterModel;

@property(copy,nonatomic)userInfoTapBack userCardTapBack;

@end

NS_ASSUME_NONNULL_END
