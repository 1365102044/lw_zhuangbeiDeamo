//
//  zUserModel.h
//  ZhuangBei
//
//  Created by aa on 2020/5/1.
//  Copyright © 2020 aa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface zUserModel : NSObject <NSCoding>

@property(assign,nonatomic)NSInteger deptId;

@property(assign,nonatomic)NSInteger postCode;

@property(assign,nonatomic)NSInteger creditCode;

@property(assign,nonatomic)NSInteger imagesId;

@property(assign,nonatomic)NSInteger deptName;

@property(assign,nonatomic)NSInteger idCard;

@property(assign,nonatomic)NSInteger address;

@property(assign,nonatomic)NSInteger levelCode;

@property(assign,nonatomic)NSInteger levelNickName;

@property(assign,nonatomic)NSInteger refereeId;

@property(assign,nonatomic)NSInteger verificationCode;

@property(assign,nonatomic)NSInteger isDisables;

@property(assign,nonatomic)NSInteger salt;

@property(assign,nonatomic)NSInteger email;

@property(assign,nonatomic)NSInteger sex;

@property(assign,nonatomic)NSInteger companyLocation;

@property(assign,nonatomic)NSInteger postName;

@property(assign,nonatomic)NSInteger nickName;//真实姓名

@property(strong,nonatomic)NSArray  * roleIdList;//不知道啥数组

@property(strong,nonatomic)NSString  * username;//用户账号

@property(strong,nonatomic)NSString  * userPassWord;//用户密码

@property(strong,nonatomic)NSString  * remmberPassword;//记住用户密码

@property(assign,nonatomic)NSInteger avatar;

@property(assign,nonatomic)NSInteger status;

@property(assign,nonatomic)NSInteger shiFouGly;

@property(assign,nonatomic)NSInteger mobile;

@property(assign,nonatomic)NSInteger companyType;

@property(assign,nonatomic)NSInteger companyShortName;

@property(assign,nonatomic)NSInteger sign;

@property(assign,nonatomic)NSInteger createTime;

@property(assign,nonatomic)NSInteger rankCode;

@property(strong,nonatomic)NSString  * token;//登录token

@property(strong,nonatomic)NSString  * invatationCode;//邀请码

@property(strong,nonatomic)NSString  * levelName;

@property(strong,nonatomic)NSString  * companyName;

@property(strong,nonatomic)NSString  * userId;//用户id

@end

NS_ASSUME_NONNULL_END
