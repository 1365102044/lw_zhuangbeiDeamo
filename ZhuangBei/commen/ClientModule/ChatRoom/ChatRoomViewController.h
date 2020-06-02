//
//  ChatRoomViewController.h
//  IMDemo
//
//  Created by  Admin on 2017/12/25.
//  Copyright © 2017年  Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#import "LWChatListBaseViewController.h"

@interface ChatRoomViewController : LWChatListBaseViewController

@property NSString *mRoomId;

@property NSString *mCreaterId;

@property (nonatomic, copy) NSString *targetID; //C2C接收消息者的uid

@property NSString *USER_TYPE;


@end
