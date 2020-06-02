//
//  LWChatListViewController.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/14.
//  Copyright © 2020 aa. All rights reserved.
//

#import "IFBaseVC.h"
#import "LWClientHeader.h"


typedef NS_ENUM(NSUInteger, LWChatRoomType) {
    LWChatRoomTypeOneTOne,  //一对一
    LWChatRoomTypeGroup,    //群组
};

@interface LWChatListBaseViewController : IFBaseVC

@property (nonatomic, strong) UITableView *chatTableView;
@property (nonatomic, strong) NSString *roomName;
@property (nonatomic, strong) NSString * roomId;
@property (nonatomic, strong) NSMutableArray<ShowMsgElem *> *showDatasArray;

- (void)scrollTableToFoot:(BOOL)animated;

/// 创建聊天室，群聊、单聊
/// @param roomId 房间ID
/// @param roomName 房间名字
/// @param roomType 聊天类型
/// @param extend 扩展字段
+ (instancetype)chatRoomViewControllerWithRoomId:(NSString *)roomId roomName:(NSString *)roomName roomType:(LWChatRoomType)roomType extend:(id)extend;

@end

