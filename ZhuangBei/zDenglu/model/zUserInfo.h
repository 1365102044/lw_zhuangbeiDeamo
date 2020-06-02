//
//  zUserInfo.h
//  ZhuangBei
//
//  Created by aa on 2020/4/28.
//  Copyright © 2020 aa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "zUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface zUserInfo : NSObject

+(zUserInfo*)shareInstance;

@property(copy,nonatomic)NSString * remmberAccount;//记住密码 1 是 2否

@property(copy,nonatomic)NSString * userAccount;

@property(copy,nonatomic)NSString * userPassWord;


@property(strong,nonatomic)zUserModel * userInfo;//用户信息

-(void)saveUserInfo;
-(void)deleate;
@end

NS_ASSUME_NONNULL_END
