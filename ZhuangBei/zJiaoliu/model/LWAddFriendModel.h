//
//  LWAddFriendModel.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/15.
//  Copyright © 2020 aa. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LWAddFriendModel : BaseModel

@property (nonatomic, strong) NSString * userId;
@property (nonatomic, strong) NSString * nickName;
@property (nonatomic, strong) NSString * email;
@property (nonatomic, strong) NSString * mobile;
@property (nonatomic, strong) NSString * sign;
@property (nonatomic, strong) NSString * imagesId;
@property (nonatomic, strong) NSString * portrait;
@property (nonatomic, strong) NSString * chatNickName;
@property (nonatomic, strong) NSString * userDm;


@property (nonatomic, strong) NSString * groupName;
@property (nonatomic, strong) NSString * userName;
@property (nonatomic, strong) NSString * groupdescription;
@property (nonatomic, strong) NSString * appBackgroundImage;
@property (nonatomic, strong) NSString * buildTime;
@property (nonatomic, strong) NSString * avatar;

//1 friend; 2 group
@property (nonatomic, assign) NSInteger  cellType;
@end

NS_ASSUME_NONNULL_END
