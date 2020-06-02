//
//  LWAddFriendDeatilViewController.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/15.
//  Copyright © 2020 aa. All rights reserved.
//

#import "baseViewController.h"
#import "LWAddFriendModel.h"
#import "LWSystemListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LWAddFriendDeatilViewController : baseViewController
@property (nonatomic, strong) LWAddFriendModel * friendModel;
//同意添加好友
@property (nonatomic, strong) LWSystemListModel * systemModel;

@end

NS_ASSUME_NONNULL_END
