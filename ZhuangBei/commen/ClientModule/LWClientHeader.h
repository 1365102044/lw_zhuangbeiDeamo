
//
//  LWClientHeader.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/12.
//  Copyright © 2020 aa. All rights reserved.
//

#ifndef LWClientHeader_h
#define LWClientHeader_h

#import "UIView+ILGKit.h"
#import "IMUserInfo.h"
#import "AppConfig.h"
#import "UIView+ILGKit.h"
#import "LWClientManager.h"
#import "ShowMsgElem.h"
#import "IFChatCell.h"
//#import "XHClient.h"
#import "LWTool.h"
#import "ChatKeyBoard.h"

//#import "XHCustomConfig.h"
//#import "XHLoginManager.h"
//#import "XHGroupManager.h"


//接收到新的一对一消息
static NSString *const NEW_MSG_CHAT_NOTI_KEY = @"NEW_MSG_CHAT_NOTI_KEY";
//接收到新的群组消息
static NSString *const NEW_MSG_GROPU_NOTI_KEY = @"NEW_MSG_GROPU_NOTI_KEY";
// 删除群组
static NSString *const DELE_GROPU_CHAT_NOTI_KEY = @"DELE_GROPU_CHAT_NOTI_KEY";
//被踢出群组
static NSString *const DELE_USER_GROPU_CHAT_NOTI_KEY = @"DELE_USER_GROPU_CHAT_NOTI_KEY";

// 保存本地聊天记录
static NSString *const LOCAL_CHATRECORD_LIST_KEY = @"LOCAL_CHATRECORD_LIST_KEY";

//未读消息key
static NSString *const LOCAL_UNRADER_MSG_LIST_KEY = @"LOCAL_UNRADER_MSG_LIST_KEY";


// 本来的未读消息数量变化，同时UI
static NSString *const LOCAL_UNREAD_MSG_LIST_CHANGE_NOTI_KEY = @"LOCAL_UNREAD_MSG_LIST_CHANGE_NOTI_KEY";

//用户的名称，IM
static NSString *const USER_ACCOUNT_IM_NICKNAME = @"USER_ACCOUNT_IM_NICKNAME";
//用户的头像 IM
static NSString *const USER_ACCOUNT_IM_AVATAR = @"USER_ACCOUNT_IM_AVATAR";

#endif /* LWClientHeader_h */
