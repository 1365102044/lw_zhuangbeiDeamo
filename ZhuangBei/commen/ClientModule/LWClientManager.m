//
//  LWClientManager.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/11.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWClientManager.h"

#import "AppConfig.h"
#import "LWClientHeader.h"
#import "ChatRoomViewController.h"
#import "MessageGroupViewController.h"
#import "zDengluController.h"
#import "MainNavController.h"

@implementation LWUserinforIMModel
-(NSString *)avatarID
{
    if ([_avatar isNotBlank] && [_avatar containsString:@"attID="]) {
        NSArray *ids = [_avatar componentsSeparatedByString:@"attID="];
        return ids.lastObject;
    }
    return nil;
}

@end

static NSString * const VOIP_SERVER_URL = @"testrtc.bdmgxq.cn:10086";
static NSString * const IM_SERVER_URL = @"testrtc.bdmgxq.cn:19903";
static NSString * const CHATROOM_SERVER_URL = @"testrtc.bdmgxq.cn:19906";
static NSString * const LIVE_VDN_SERVER_URL = @"testrtc.bdmgxq.cn:19928";
static NSString * const LIVE_SRC_SERVER_URL = @"testrtc.bdmgxq.cn:19931";
static NSString * const LIVE_PROXY_SERVER_URL = @"testrtc.bdmgxq.cn:19932";
static NSString *const sendmsg_oto_url =  @"app/appfriendmessage/save";
static NSString *const sendmsg_group_url  = @"app/appgroupmessage/save";

@interface LWClientManager()
#warning ---------------lw---------------
//<XHLoginManagerDelegate,XHChatManagerDelegate, XHGroupManagerDelegate>
//@property (nonatomic, strong) XHCustomConfig *config;
// 系统未读消息数量
@property (nonatomic, assign) NSInteger  unreadSysMsgNum;
//该用户的群组<groupid:groupname>
@property (nonatomic, strong) NSMutableDictionary * allGroupDatas;

@end

@implementation LWClientManager

+ (instancetype)share
{
    static LWClientManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LWClientManager alloc] init];
        #warning ---------------lw---------------
//        manager.config = [[XHCustomConfig alloc] init];
//        [[XHClient sharedClient].groupManager addDelegate:manager];
//        [[XHClient sharedClient].chatManager addDelegate:manager];
//        [[XHClient sharedClient].loginManager addDelegate:manager];
    });
    return manager;
}

- (void)installConfigure
{
    [self requestUnReadSystemMsgNumber];
    #warning ---------------lw---------------
//    self.config.serverType =  SERVER_TYPE_CUSTOM;;
//    self.config.imServerURL = IM_SERVER_URL;
//    self.config.chatRoomServerURL = CHATROOM_SERVER_URL;
//    self.config.liveSrcServerURL = LIVE_SRC_SERVER_URL;
//    self.config.liveVdnServerURL = LIVE_VDN_SERVER_URL;
//    self.config.voipServerURL = VOIP_SERVER_URL;
//    zUserModel * model = [zUserInfo shareInstance].userInfo;
//    if (model) {
//        [self.config sdkInitForFree:LWDATA(model.userId)];
//    }
//    [self userLogin];
}

//配置userID
- (void)configureUserId
{
    [self requestUnReadSystemMsgNumber];
    
    zUserModel * model = [zUserInfo shareInstance].userInfo;
    #warning ---------------lw---------------
//    [self.config sdkInitForFree:LWDATA(model.userId)];
    [self userLogin];
}

//退出SDK
- (void)userLogout
{
    #warning ---------------lw---------------
//    [[XHClient sharedClient].loginManager logout];
}

//登录SDK
- (void)userLogin
{
    #warning ---------------lw---------------
//    [self userLogout];
//
//    zUserModel * model = [zUserInfo shareInstance].userInfo;
//    if (model.userId) {
//        [[XHClient sharedClient].loginManager loginFree:^(NSError *error) {
//            LWLog(@"——————%@————XHLoginManager登录error：%@",model.userId,error);
//        }];
//    }
}


#pragma mark ----------- XHGroupManagerDelegate -----------
//群组成员数目变化
- (void)group:(NSString*)groupID didMembersNumberUpdeted:(NSInteger)membersNumber {
}

// 自己被移除当前群组
- (void)groupUserKicked:(NSString*)groupID {
    POST_NOTI(DELE_USER_GROPU_CHAT_NOTI_KEY, @{@"groupID":groupID});
}

//群组解散
- (void)groupDidDeleted:(NSString*)groupID{
    POST_NOTI(DELE_GROPU_CHAT_NOTI_KEY, @{@"groupID":groupID});

}

//接收群组消息
- (void)groupMessagesDidReceive:(NSString *)aMessage fromID:(NSString *)fromID groupID:(NSString *)groupID{
    
    if ([fromID integerValue] == 0) {
        if ([fromID isEqualToString:@"system"]) {
            [self requestUnReadSystemMsgNumber];
        }
        return;
    }
    POST_NOTI(NEW_MSG_GROPU_NOTI_KEY, (@{@"msg":aMessage,@"fromid":fromID,@"groupID":groupID}));
    
    //    如果当前控制器是正是当前群组时，本地不再添加未读数
    UIViewController *currentVC = [LWClientManager topController];
    if ([currentVC isKindOfClass: [MessageGroupViewController class]]) {
        MessageGroupViewController *chatvc = (MessageGroupViewController *)currentVC;
        if ([chatvc.roomId integerValue] != [groupID integerValue]) {
            NSString *groupname = self.allGroupDatas[[NSNumber numberWithInteger:[groupID integerValue]]];
            //type: 1:group; 2:oto
            [self addNewUnReadMsgWithRoomName:LWDATA(groupname) roomId:LWDATA(groupID) chatType:1 extend:nil];
        }
    }else{
        NSString *groupname = self.allGroupDatas[[NSNumber numberWithInteger:[groupID integerValue]]];
        //type: 1:group; 2:oto
        [self addNewUnReadMsgWithRoomName:LWDATA(groupname) roomId:LWDATA(groupID) chatType:1 extend:nil];
    }
}


#pragma mark ----------- XHChatManagerDelegate -------------

- (void)chatMessageDidReceived:(NSString *)message fromID:(NSString *)uid;
{
    if ([uid integerValue] == 0) {
        if ([uid isEqualToString:@"system"]) {
            [self requestUnReadSystemMsgNumber];
        }
        return;
    }
    POST_NOTI(NEW_MSG_CHAT_NOTI_KEY, (@{@"msg":message,@"fromid":uid}));
    
//    如果当前控制器是正是对方时，本地不再添加未读数
    UIViewController *currentVC = [LWClientManager topController];
    if ([currentVC isKindOfClass: [ChatRoomViewController class]]) {
        ChatRoomViewController *chatvc = (ChatRoomViewController *)currentVC;
        if ([chatvc.roomId integerValue] != [uid integerValue]) {
            NSString *friendname = self.allGroupDatas[[NSNumber numberWithInteger:[uid integerValue]]];
            //type: 1:group; 2:oto
            [self addNewUnReadMsgWithRoomName:[LWDATA(friendname) isNotBlank] ? friendname:@"临时消息" roomId:LWDATA(uid) chatType:2 extend:nil];
        }
    }else{
        NSString *friendname = self.allGroupDatas[[NSNumber numberWithInteger:[uid integerValue]]];
        //type: 1:group; 2:oto
        [self addNewUnReadMsgWithRoomName:[LWDATA(friendname) isNotBlank] ? friendname:@"临时消息" roomId:LWDATA(uid) chatType:2 extend:nil];
    }
}

#pragma mark -------------------XHLoginManagerDelegate--------------
#warning ---------------lw---------------
///**
// 连接状态发生变化
//
// @param state 状态
// */
//- (void)connectionStateDidChange:(XHSDKConnectionState)state;
//{
//    [[zHud shareInstance] showMessage:state == 1 ? @"已断开连接":@"重新连接成功"];
//}
//
///**
// 账户从其他设备登录
// */
//- (void)userAccountDidLoginFromOtherDevice;
//{
//    [[zHud shareInstance] showMessage:@"该用户已从其他设备登录"];
//    [self needRelogin];
//}
//
///**
// 关闭啦，需要重新登录
// */
//- (void)userAccountDidLogout;
//{
//    [[zHud shareInstance] showMessage:@"关闭啦，需要重新登录"];
//}


/// 向后台发送群聊消息
/// @param msg 消息
/// @param groupId 群里id
/// @param success 成功
/// @param failure 失败
- (void)sendGroupMsg:(NSString *)msg groupId:(NSString *)groupId success:(RequestSuccess)success failure:(RequestFailure)failure
{
    NSString *userid = [zUserInfo shareInstance].userInfo.userId;
    if (!userid) {
        [[zHud shareInstance] showMessage:@"未获取到userId"];
        return;
    }
    NSString *nowtime = [self currentdateInterval];
    [ServiceManager requestPostWithUrl:sendmsg_group_url body:[self getGroupParamString:@{@"content":LWDATA(msg),@"groupId":LWDATA(groupId),@"userId":LWDATA(userid),@"sendTime":LWDATA(nowtime)}] success:^(id  _Nonnull response) {
        success(response);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}


/// 向后台发送一对一聊天消息
/// @param msg 消息内容
/// @param roomId  id
/// @param success
/// @param failure
- (void)sendMsgOneToOne:(NSString *)msg roomId:(NSString *)roomId success:(RequestSuccess)success failure:(RequestFailure)failure
{
    NSString *userid = [zUserInfo shareInstance].userInfo.userId;
    if (!userid) {
        [[zHud shareInstance] showMessage:@"未获取到userId"];
        return;
    }
//    NSString *nowtime = [self currentdateInterval];
    [ServiceManager requestPostWithUrl:sendmsg_oto_url body:[self gettotoParamString:@{@"content":LWDATA(msg),@"toUserId":LWDATA(roomId)}] success:^(id  _Nonnull response) {
        success(response);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}


/// 获取当前时间戳
- (NSString *)currentdateInterval
{
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)([datenow timeIntervalSince1970]*1000)];
    return timeSp;
}


/// 处理群里消息的参数格式
/// @param param 参数字典 ,\"mainProduct\":\"\"
- (NSString *)getGroupParamString:(NSDictionary *)param
{
    NSString *string = [NSString stringWithFormat:@"{\"groupId\":\"%@\",\"content\":\"%@\",\"sendTime\":%.0f,\"userId\":%.0f}",param[@"groupId"],param[@"content"],[param[@"sendTime"] floatValue],[param[@"userId"] floatValue]];
    return string;
}

/// 处理i一对一里消息的参数格式
/// @param param 参数字典 ,\"mainProduct\":\"\"
- (NSString *)gettotoParamString:(NSDictionary *)param
{
    NSString *string = [NSString stringWithFormat:@"{\"toUserId\":\"%@\",\"content\":\"%@\"}",param[@"toUserId"],param[@"content"]];
    return string;
}


/// 上传图片
/// @param pic image
- (void)requestUploadPicFile:(UIImage *)pic success:(RequestSuccess)success failure:(RequestFailure)failure
{
    [ServiceManager postImageWithUrl:@"app/appfujian/upload" img:pic dataKey:@"file" name:@"file" success:success failed:failure];
}


#pragma mark --------------------- 聊天室记录本地化 ---------------------

/// 保存聊天记录
/// @param roomName 聊天室名字
/// @param roomId 聊天室id
/// @param type 聊天类型 // 1:group; 2:oto
/// @param extend 扩展字段
+ (void)saveLocalChatRecordWithRoomName:(NSString *)roomName roomId:(NSString *)roomId chatType:(NSInteger)type extend:(id)extend
{
    NSMutableArray *chatrecord = [LWClientManager getLocalChatRecordModelList];
    __block BOOL ishave = NO;
    [chatrecord enumerateObjectsUsingBlock:^(LWLocalChatRecordModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.roomId integerValue] == [roomId integerValue]) {
            ishave = YES;
            *stop = YES;
        }
    }];
    if (!ishave && [LWClientManager.share.userinforIM.customId integerValue] != [roomId integerValue]) {
        LWLocalChatRecordModel *model = [LWLocalChatRecordModel new];
        model.roomId = roomId;
        model.roomName = roomName;
        model.chatType = type;
        NSData *modeldata = [NSKeyedArchiver archivedDataWithRootObject:model];
        NSMutableArray *recoddata = [[NSMutableArray alloc] initWithArray:[SYSTEM_USERDEFAULTS objectForKey:LOCAL_CHATRECORD_LIST_KEY]];
        [recoddata addObject:modeldata];
        [SYSTEM_USERDEFAULTS setObject:recoddata forKey:LOCAL_CHATRECORD_LIST_KEY];
        [SYSTEM_USERDEFAULTS synchronize];
        POST_NOTI(@"refreshChatRecordList", nil);
    }
}

/// 获取本地聊天记录 private
+ (NSMutableArray *)getLocalChatRecordModelList
{
    NSArray *chatrecord = [SYSTEM_USERDEFAULTS objectForKey:LOCAL_CHATRECORD_LIST_KEY];
    NSMutableArray *tem = [[NSMutableArray alloc] initWithCapacity:chatrecord.count];
    for (NSData *data in chatrecord) {
        LWLocalChatRecordModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [tem addObject:model];
    }
    return tem;
}

/// 获取本地聊天记录 public
+ (NSArray *)getLocalChatRecord
{
    NSArray *tem = [LWClientManager.share MergeUnreadMsgListToLocalChatRecord];
    
    return tem;
}

/// 删除本地聊天记录
+ (void)removeLocalChatRecord
{
    [LWClientManager.share deleteAllUnReadMsgNum];
    [LWClientManager.share.allGroupDatas removeAllObjects];
    [SYSTEM_USERDEFAULTS removeObjectForKey:LOCAL_CHATRECORD_LIST_KEY];
    [SYSTEM_USERDEFAULTS synchronize];
}


/// 把未读消息数据合并到本地消息l记录中
- (NSArray *)MergeUnreadMsgListToLocalChatRecord
{
    NSMutableArray *unreadmsg = [self getLocalUnReadMsg];
    NSMutableDictionary *dict = [NSMutableDictionary new];
    for (LWLocalChatRecordModel *model in unreadmsg) {
        [dict setValue:model forKey:model.roomId];
    }
    
    NSMutableArray *localchatrecord = [LWClientManager getLocalChatRecordModelList];
    [localchatrecord enumerateObjectsUsingBlock:^(LWLocalChatRecordModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LWLocalChatRecordModel *model = [dict objectForKey:obj.roomId];
        if (model) {
            obj.unreadNum = model.unreadNum;
        }
    }];
    return localchatrecord;
}

#pragma mark ------------------- 获取系统消息的未读数 ---------------------

// 获取该用户的所有群组信息，用于群组未读消息的 反查群组名称
- (void)requestAllGroupInforDatas
{
    [ServiceManager requestPostWithUrl:@"app/appfriendtype/getFriendTypeAndFriendList" Parameters:@{} success:^(id  _Nonnull response) {
        NSDictionary *data = response[@"data"];
        NSDictionary *mine = data[@"mine"];
        NSString *username = mine[@"username"];
        NSString *avatar = mine[@"avatar"];
        if (username) {
            [SYSTEM_USERDEFAULTS setObject:username forKey:USER_ACCOUNT_IM_NICKNAME];
        }
        if (avatar) {
            [SYSTEM_USERDEFAULTS setObject:username forKey:USER_ACCOUNT_IM_AVATAR];
        }
        [SYSTEM_USERDEFAULTS synchronize];
        
        self.userinforIM = [LWUserinforIMModel modelWithDictionary:mine];
        NSArray *friend = data[@"friend"];
        NSArray *group = data[@"group"];
        [self.allGroupDatas removeAllObjects];
        for (NSDictionary *dict in group) {
            [self.allGroupDatas setObject:LWDATA(dict[@"groupname"]) forKey:LWDATA(dict[@"id"])];
        }
        for (NSDictionary *dict in friend) {
            for (NSDictionary *item in dict[@"list"]) {
                [self.allGroupDatas setObject:LWDATA(item[@"username"]) forKey:LWDATA(item[@"id"])];
            }
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

/// 获取系统消息未读数
- (void)requestUnReadSystemMsgNumber
{
    [self requestAllGroupInforDatas];
    
    [ServiceManager requestPostWithUrl:@"app/appfriendapply/countList" paraString:@{} success:^(id  _Nonnull response) {
        if ([response[@"code"] integerValue] == 0) {
            NSInteger countMun = [response[@"countMun"] integerValue];
            self.unreadSysMsgNum = countMun;
            POST_NOTI(LOCAL_UNREAD_MSG_LIST_CHANGE_NOTI_KEY, nil);
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

/// 已读系统消息
/// @param type 已读消息类型* type类型：* 0：管理员收到入群申请* 1：收到好友请求
- (void)requestReadSystemMsg:(NSString *)type
{
    if(self.unreadSysMsgNum <= 0) return;
    
    [ServiceManager requestPostWithUrl:@"/app/appfriendapply/read" paraString:@{@"type":LWDATA(type)} success:^(id  _Nonnull response) {
        [self requestUnReadSystemMsgNumber];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}


/// 添加新的未读消息
/// @param roomName 聊天室名称
/// @param roomId 聊天室id
/// @param type 聊天类型 1:group; 2:oto
/// @param extend 扩展字段
- (void)addNewUnReadMsgWithRoomName:(NSString *)roomName roomId:(NSString *)roomId chatType:(NSInteger)type extend:(id)extend
{
    [LWClientManager saveLocalChatRecordWithRoomName:roomName roomId:roomId chatType:type extend:extend];
    
    NSMutableArray *unreadmsg = [self getLocalUnReadMsg];
    __block BOOL ishave = NO;
    [unreadmsg enumerateObjectsUsingBlock:^(LWLocalChatRecordModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.roomId intValue] == [roomId intValue]) {
            ishave = YES;
            obj.unreadNum ++;
            *stop = YES;
        }
    }];
    if (!ishave && [self.userinforIM.customId  integerValue] != [roomId integerValue]) {
        LWLocalChatRecordModel *model = [LWLocalChatRecordModel new];
        model.roomId = roomId;
        model.roomName = roomName;
        model.chatType = type;
        model.unreadNum = 1;
        NSData *modeldata = [NSKeyedArchiver archivedDataWithRootObject:model];
        NSMutableArray *recoddata = [[NSMutableArray alloc] initWithArray:[SYSTEM_USERDEFAULTS objectForKey:LOCAL_UNRADER_MSG_LIST_KEY]];
        [recoddata addObject:modeldata];
        [SYSTEM_USERDEFAULTS setObject:recoddata forKey:LOCAL_UNRADER_MSG_LIST_KEY];
        [SYSTEM_USERDEFAULTS synchronize];
    }else{
        NSMutableArray *recoddata = [[NSMutableArray alloc] initWithCapacity:unreadmsg.count];
        for (LWLocalChatRecordModel *model in unreadmsg) {
            NSData *modeldata = [NSKeyedArchiver archivedDataWithRootObject:model];
            [recoddata addObject:modeldata];
        }
        [SYSTEM_USERDEFAULTS setObject:recoddata forKey:LOCAL_UNRADER_MSG_LIST_KEY];
        [SYSTEM_USERDEFAULTS synchronize];
    }
    POST_NOTI(LOCAL_UNREAD_MSG_LIST_CHANGE_NOTI_KEY, nil);
}

/// 获取本地未读消息
- (NSMutableArray *)getLocalUnReadMsg
{
    NSArray *unreadmsg = [SYSTEM_USERDEFAULTS objectForKey:LOCAL_UNRADER_MSG_LIST_KEY];
    NSMutableArray *tem = [[NSMutableArray alloc] initWithCapacity:unreadmsg.count];
    for (NSData *data in unreadmsg) {
        LWLocalChatRecordModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [tem addObject:model];
    }
    return tem;
}


/// 删除该条聊天室的未读消息
/// @param roomId 聊天室的id
- (void)deleteUnReadMsgWithroomId:(NSString *)roomId
{
    NSMutableArray *unreadmsg = [self getLocalUnReadMsg];
    [unreadmsg enumerateObjectsUsingBlock:^(LWLocalChatRecordModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.roomId integerValue] ==  [roomId integerValue]) {
            [unreadmsg removeObject:obj];
            *stop = YES;
        }
    }];
    NSMutableArray *unreaddata = [[NSMutableArray alloc] initWithCapacity:unreadmsg.count];
    for (LWLocalChatRecordModel *model in unreadmsg) {
        NSData *modeldata = [NSKeyedArchiver archivedDataWithRootObject:model];
        [unreaddata addObject:modeldata];
    }
    [SYSTEM_USERDEFAULTS setObject:unreaddata forKey:LOCAL_UNRADER_MSG_LIST_KEY];
    [SYSTEM_USERDEFAULTS synchronize];
    
    //    清空本地聊天记录的未读数
    NSMutableArray *localchatreacrod = [LWClientManager getLocalChatRecordModelList];
    [localchatreacrod enumerateObjectsUsingBlock:^(LWLocalChatRecordModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.roomId integerValue] ==  [roomId integerValue]) {
            obj.unreadNum = 0;
            *stop = YES;
        }
    }];
    NSMutableArray *recoddata = [[NSMutableArray alloc] initWithCapacity:localchatreacrod.count];
    for (LWLocalChatRecordModel *model in localchatreacrod) {
        NSData *modeldata = [NSKeyedArchiver archivedDataWithRootObject:model];
        [recoddata addObject:modeldata];
    }
    [SYSTEM_USERDEFAULTS setObject:recoddata forKey:LOCAL_CHATRECORD_LIST_KEY];
    [SYSTEM_USERDEFAULTS synchronize];
    
    
    POST_NOTI(LOCAL_UNREAD_MSG_LIST_CHANGE_NOTI_KEY, nil);
}


/// 清空本地缓存的未读消息数据
- (void)deleteAllUnReadMsgNum
{
    [SYSTEM_USERDEFAULTS removeObjectForKey:LOCAL_UNRADER_MSG_LIST_KEY];
    [SYSTEM_USERDEFAULTS synchronize];
}

/// 获取本地的未读消息数量 private
-(NSInteger)unreadMsgNum
{
    NSMutableArray *unreadmsg = [self getLocalUnReadMsg];
    __block NSInteger num = 0;
    [unreadmsg enumerateObjectsUsingBlock:^(LWLocalChatRecordModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        num = num + obj.unreadNum;
    }];
    return num;
}

- (NSMutableDictionary *)allGroupDatas
{
    if (!_allGroupDatas) {
        _allGroupDatas = [[NSMutableDictionary alloc] init];
    }
    return _allGroupDatas;
}


+ (UIViewController *)topController {
    
    UIViewController *topC = [self topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (topC.presentedViewController) {
        topC = [self topViewController:topC.presentedViewController];
    }
    return topC;
}

+ (UIViewController *)topViewController:(UIViewController *)controller {
    if ([controller isKindOfClass:[UINavigationController class]]) {
        return [self topViewController:[(UINavigationController *)controller topViewController]];
    } else if ([controller isKindOfClass:[UITabBarController class]]) {
        return [self topViewController:[(UITabBarController *)controller selectedViewController]];
    } else {
        return controller;
    }
}


/// 账号被挤掉
- (void)needRelogin
{
    [[zUserInfo shareInstance]deleate];
//    [[zHud shareInstance]showMessage:@"登录信息超时,请重新登录"];
    //登录超时重新登录
    zDengluController * rootVC  = [[zDengluController alloc]init];
    MainNavController * rootNav = [[MainNavController alloc]initWithRootViewController:rootVC];
    rootNav.navigationBar.hidden = YES;
    UIApplication *app = [UIApplication sharedApplication];
    [app keyWindow].rootViewController = rootNav;
}

@end


/*
 群聊上传接口：app/appgroupmessage/save
 一对一聊天接口：app/appfriendmessage/save
 系统的未读数量： app/app/appfriendapply/countList
 
 /app/app/appfriendapply/read
 * 【系统消息】读取后，消息数量清零
 * type类型：
 * 0：管理员收到入群申请
 * 1：收到好友请求
 
 */


/*
 群组消息：
 {
 "avatar": "/app/app/appfujian/download?attID=3379",
 "content": "还",
 "id": "696",
 "isGroup": true,
 "mid": {
 "content": "还",
 "groupId": "63",
 "id": "3379",
 "sendTime": "2020-05-23 10:19",
 "userId": "696"
 },
 "msgCount": 0,
 "username": "北京真格lw2000-销售部-总经理"
 }
 */


/* oto
 上传图片
 app/appfujian/upload
 param:file data
 response:
 {
 "code": 0,
 "msg": "success",
 "data": {
 "id": 6474,
 "name": "IMG_20200130_183050.jpg",
 "format": "multipart/form-data",
 "realName": "1590371128550.jpg",
 "remark": null,
 "fullName": "download/attachment/1590371128550.jpg",
 "size": 6877751,
 "type": null,
 "groupId": null,
 "userId": 688,
 "userName": null,
 "src": "/app/app/appfujian/download?attID=6474",
 "updateDate": 1590371128570,
 "activeState": 0,
 "ossDownloadSrc": null
 }
 }
 
 发送图片
 {
 "toUserId": "696",
 "content": "img[\/app\/app\/appfujian\/download?attID=6474]"
 }
 */
