//
//  MessageGroupViewController.h
//  IMDemo
//
//  Created by  Admin on 2018/1/5.
//  Copyright © 2018年  Admin. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "LWChatListBaseViewController.h"

@interface MessageGroupViewController : LWChatListBaseViewController

@property NSString *USER_TYPE;
//@property NSString *m_Group_Name;

@property (nonatomic, copy) NSString *creatorID; //创建群者id

@end
