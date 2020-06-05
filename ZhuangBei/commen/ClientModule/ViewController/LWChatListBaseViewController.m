//
//  LWChatListViewController.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/14.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWChatListBaseViewController.h"
#import "IQKeyboardManager.h"
#import "LWEmojiManager.h"
#import "LWPhotoPicker.h"
#import "KNPhotoBrowser.h"
#import "UIImageView+WebCache.h"
#import "LWJiaoLiuModel.h"

NSString *const getlist_group_url  = @"app/appgroupmessage/getGroupMsgList";

NSString *const getlist_oto_url =  @"app/appfriendmessage/getFriendMsgList";


@interface LWChatListBaseViewController ()<IFChatViewDelegate, UITableViewDataSource,UITableViewDelegate, UITextViewDelegate,UIScrollViewDelegate,ChatKeyBoardDelegate, ChatKeyBoardDataSource>
@property (nonatomic, strong) NSMutableArray<ShowMsgElem *> *totalDatasArray;
@property (nonatomic, strong) NSString *m_Group_ID;
@property (nonatomic, assign) LWChatRoomType  roomType;
@property (nonatomic, strong) dispatch_group_t dispatch_group;
@property (nonatomic, assign) NSInteger  successNum;
/** 聊天键盘 */
@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;
@property (nonatomic, strong) LWPhotoPicker * photopicker;
//好友信息
@property (nonatomic, strong) friendItemModel * friendInforModel;
//当前页数
@property (nonatomic, assign) NSInteger  currentPage;

@end

@implementation LWChatListBaseViewController

//检查群组权限
- (void)requestGroupCanSendmsg
{
    [self requestPostWithUrl:@"app/appgroupuser/findOneByGroupIdAndUserId" paraString:@{@"groupId":LWDATA(self.roomId)} success:^(id  _Nonnull response) {
        NSInteger code = [response[@"code"] integerValue];
        NSString *msg = response[@"mag"];
        if (code != 1) {
            self.chatKeyBoard.placeHolder = msg;
            self.chatKeyBoard.userInteractionEnabled = NO;
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

// 获取列表的聊天记录
- (void)requestRecordListDatas
{
    NSDictionary *param = [NSDictionary new];
    NSString *url = getlist_group_url;
    if (_roomType == LWChatRoomTypeOneTOne) {
        url = getlist_oto_url;
        param = @{@"toUserId":LWDATA(self.roomId),@"limit":@"20",@"page":@(self.currentPage)};
    }else{
        param = @{@"groupId":LWDATA(self.m_Group_ID),@"limit":@"20",@"page":@(self.currentPage)};
    }
    [self requestPostWithUrl:url paraString:param success:^(id  _Nonnull response) {
        NSArray *data = response[@"data"];
        NSMutableArray *temarr = [NSMutableArray array];
        for (NSDictionary *dict in data) {
            [temarr addObject:[ShowMsgElem modelWithDictionary:dict]];
        }
        [self.totalDatasArray insertObjects:temarr atIndex:0];
        
//        if (self.totalDatasArray.count > 100) {
//            [self.showDatasArray addObjectsFromArray: [self.totalDatasArray subarrayWithRange:NSMakeRange(self.totalDatasArray.count - 100, 100)]];
//        }else{
//        }
//        [self.showDatasArray removeAllObjects];
        self.showDatasArray = [self.totalDatasArray mutableCopy];

        [self.chatTableView reloadData];
        if (self.currentPage == 1) {
            [self scrollTableToFoot:NO];
        }
        if (data.count > 0) {
            self.currentPage++;
            [self.chatTableView scrollToRow:data.count-1 inSection:0 atScrollPosition:(UITableViewScrollPositionNone) animated:NO];
        }
        [self.chatTableView.mj_header endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        [self.chatTableView.mj_header endRefreshing];
    }];
}

//向后台发消息
- (void)requsetSendMsgService:(NSString *)text
{
    //    dispatch_group_enter(self.dispatch_group);
    if (_roomType == LWChatRoomTypeGroup) {
        [[LWClientManager share] sendGroupMsg:text groupId:self.m_Group_ID success:^(id  _Nonnull response) {
            if ([response[@"code"] intValue] == 0) {
                self.successNum++;
                [self sendMsgSuccess:text];
            }else{
                [[zHud shareInstance] showMessage:@"消息发送失败"];
            }
            //            dispatch_group_leave(self.dispatch_group);
        } failure:^(NSError * _Nonnull error) {
            [[zHud shareInstance] showMessage:@"消息发送失败"];
            //            dispatch_group_leave(self.dispatch_group);
        }];
    }else if(_roomType == LWChatRoomTypeOneTOne){
        [[LWClientManager share] sendMsgOneToOne:text roomId:self.roomId success:^(id  _Nonnull response) {
            if ([response[@"code"] intValue] == 0) {
                self.successNum++;
                [self sendMsgSuccess:text];
            }else{
                [[zHud shareInstance] showMessage:@"消息发送失败"];
            }
            //            dispatch_group_leave(self.dispatch_group);
        } failure:^(NSError * _Nonnull error) {
            [[zHud shareInstance] showMessage:@"消息发送失败"];
            //            dispatch_group_leave(self.dispatch_group);
        }];
    }
}

//向SDK发消息
- (void)requestSDKSendMsg:(NSString *)text
{
    #warning ---------------lw---------------
//    //    dispatch_group_enter(self.dispatch_group);
//    if (_roomType == LWChatRoomTypeGroup) {
//        [[XHClient sharedClient].groupManager sendMessage:text toGroup:self.m_Group_ID atUsers:nil completion:^(NSError *error) {
//            if (error) {
//                LWLog(@"**************消息发送失败error:%@",error);
//                [UIView ilg_makeToast:error.localizedDescription];
//            }else{
//                self.successNum++;
//            }
//            //            dispatch_group_leave(self.dispatch_group);
//        }];
//    }else if (_roomType == LWChatRoomTypeOneTOne){
//        [[XHClient sharedClient].chatManager sendMessage:text toID:[NSString stringWithFormat:@"%@",self.roomId] completion:^(NSError *error) {
//            if (error) {
//                LWLog(@"**************消息发送失败error:%@",error);
//                [UIView ilg_makeToast:error.localizedDescription];
//            } else {
//                self.successNum++;
//            }
//            //            dispatch_group_leave(self.dispatch_group);
//        }];
//    }
}


//- (void)chatViewDidSendText:(NSString *)text {
//
//    self.dispatch_group = dispatch_group_create();
//
//    [self requsetSendMsgService:text];
//
//    [self requestSDKSendMsg:text];
//
//    dispatch_group_notify(self.dispatch_group, dispatch_get_main_queue(), ^{
//        [self.view endEditing:YES];
//        if (self.successNum == 2) {
//            ShowMsgElem * newMsgElem = [[ShowMsgElem alloc] init];
//            newMsgElem.userID = [IMUserInfo shareInstance].userID;
//            newMsgElem.content = text;
//            newMsgElem.username = [LWDATA([zUserInfo shareInstance].userInfo.username) isEqualToString:@""]?@"未知昵称":[zUserInfo shareInstance].userInfo.username;
//            newMsgElem.time = [[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
//
//            [self showTrace:newMsgElem];
//        }else{
//            [[zHud shareInstance] showMessage:@"消息发送失败"];
//        }
//        self.successNum = 0;
//    });
//}

// 发送成功
- (void)sendMsgSuccess:(NSString *)text
{
    ShowMsgElem * newMsgElem = [[ShowMsgElem alloc] init];
    newMsgElem.userID = [IMUserInfo shareInstance].userID;
    newMsgElem.content = text;
    NSString *username = [SYSTEM_USERDEFAULTS objectForKey:USER_ACCOUNT_IM_NICKNAME];
    newMsgElem.username = [username isNotBlank] ? username : [zUserInfo shareInstance].userInfo.username;
    newMsgElem.time = [[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    newMsgElem.uavatar = LWClientManager.share.userinforIM.avatar;
    [self showTrace:newMsgElem];
}

// 发送成功后，刷新当前页面
- (void)showTrace:(ShowMsgElem *)msgModel
{
    if (!msgModel) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([msgModel.userID isEqualToString:[IMUserInfo shareInstance].userID]) {
            msgModel.mine = 1;
        }
        if(msgModel.msgType == LWMsgTypeImage){
            msgModel.rowHeight = 200+ 10+20 + 25+ 15 + 15+10+15;
        }else{
            msgModel.rowHeight = [IFChatCell caculateTextHeightWithMaxWidth:self.chatTableView.width - [IFChatCell reserveWithForCell] text:msgModel.content];
        }
        [self.totalDatasArray addObject:msgModel];
        [self.showDatasArray addObject:msgModel];
        [self.chatTableView reloadData];
        [self scrollTableToFoot:NO];
        
        [LWClientManager saveLocalChatRecordWithRoomName:self.roomName roomId:self.roomId chatType:self.roomType==1?1:2 extend:nil];
    });
}

//获取好友的信息
- (void)requestFriendInfor
{
    [ServiceManager requestPostWithUrl:@"app/appqyuser/findOne" paraString:@{@"userId":self.roomId} success:^(id  _Nonnull response) {
        if ([response[@"code"] integerValue] == 0) {
            NSDictionary *list = response[@"list"];
            self.friendInforModel = [friendItemModel modelWithDictionary:list];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark ----------- XHGroupManagerDelegate 通知-----------

- (void)receiveNewChatGroupMsg:(NSNotification *)noti
{
    NSDictionary *msgdic = noti.object;
    if (self.roomType != LWChatRoomTypeGroup) return;
    if([self.roomId integerValue] != [msgdic[@"groupID"] integerValue]) return;
    NSDictionary *dict = [LWTool stringToDictory:msgdic[@"msg"]];
    ShowMsgElem *model = [ShowMsgElem modelWithDictionary:dict[@"mid"]];
    model.username = LWDATA(dict[@"username"]);
    model.uavatar = LWDATA(dict[@"avatar"]);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showTrace:model];
    });
}

- (void)deleUserGroupChat:(NSNotification *)noti
{
    if (self.roomType != LWChatRoomTypeGroup) return;
    NSString *groupID = noti.object[@"groupID"];
    if ([self isCurrentViewController] && [groupID isEqualToString:self.roomId]) {
        [UIView ilg_makeToast:@"您已被管理员剔除"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)deleGroupChat:(NSNotification *)noti
{
    if (self.roomType != LWChatRoomTypeGroup) return;
    NSString *groupID = noti.object[@"groupID"];
    if ([self isCurrentViewController] && [groupID isEqualToString:self.roomId]) {
        [UIView ilg_makeToast:@"此群已被删除"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark ----------- XHChatManagerDelegate 通知-------------
- (void)receiveNewChatMsg:(NSNotification *)noti
{
    NSDictionary *msgdic = noti.object;
    if (self.roomType != LWChatRoomTypeOneTOne) return;
    if([self.roomId integerValue] != [msgdic[@"fromid"] integerValue]) return;
    NSDictionary *dict = [LWTool stringToDictory:msgdic[@"msg"]];
    ShowMsgElem *model = [ShowMsgElem modelWithDictionary:dict];
    model.uavatar = [NSString stringWithFormat:@"/app/app/appfujian/download?attID=%@",dict[@"mid"][@"id"]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showTrace:model];
    });
}


/// 创建聊天室，群聊、单聊
/// @param roomId 房间ID
/// @param roomName 房间名字
/// @param roomType 聊天类型
/// @param extend 扩展字段
+ (instancetype)chatRoomViewControllerWithRoomId:(NSString *)roomId roomName:(NSString *)roomName roomType:(LWChatRoomType )roomType extend:(id)extend;
{
    LWChatListBaseViewController *vc = [[self alloc] init];
    vc.roomName = roomName;
    vc.roomId = roomId;
    vc.roomType = roomType;
    //    if ([extend isKindOfClass:[LWJiaoLiuModel class]]) {
    //        vc.friendInforModel = extend;
    //    }
    return vc;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.currentPage = 1;
    
    [self createUI];
    self.showDatasArray = [NSMutableArray array];
    self.totalDatasArray = [NSMutableArray array];
    self.m_Group_ID = self.roomId;
    
    //    消息监听
    ADD_NOTI(receiveNewChatMsg:, NEW_MSG_CHAT_NOTI_KEY);
    ADD_NOTI(receiveNewChatGroupMsg:, NEW_MSG_GROPU_NOTI_KEY);
    ADD_NOTI(deleGroupChat:, DELE_GROPU_CHAT_NOTI_KEY);
    ADD_NOTI(deleUserGroupChat:, DELE_USER_GROPU_CHAT_NOTI_KEY);

    if (_roomType == LWChatRoomTypeGroup) {
        [self requestGroupCanSendmsg];
    }else if (_roomType == LWChatRoomTypeOneTOne){
    }
    
    self.title = self.roomName;
    [self.totalDatasArray removeAllObjects];
    [self requestRecordListDatas];
    
    //    删除本地的未读消息
    [[LWClientManager share] deleteUnReadMsgWithroomId:self.roomId];
    POST_NOTI(@"refreshChatRecordList", nil);
    
    [self requestFriendInfor];
}

#pragma mark - UI
- (void)createUI {
    
    [self.view addSubview:self.chatTableView];
    self.chatKeyBoard = [ChatKeyBoard keyBoardWithParentViewBounds:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATOR_HEIGHT- LL_TabbarSafeBottomMargin)];
    self.chatKeyBoard.delegate = self;
    self.chatKeyBoard.dataSource = self;
    self.chatKeyBoard.associateTableView = self.chatTableView;
    [self.view addSubview:self.chatKeyBoard];
    self.chatKeyBoard.placeHolder = @"来聊吧...";
    
    self.chatKeyBoard.allowVoice = NO;
//    self.chatKeyBoard.allowMore = NO;
}


- (void)scrollTableToFoot:(BOOL)animated
{
    NSInteger s = [self.chatTableView numberOfSections];  //有多少组
    if (s<1) return;  //无数据时不执行 要不会crash
    NSInteger r = [self.chatTableView numberOfRowsInSection:s-1]; //最后一组有多少行
    if (r<1) return;
    NSIndexPath *ip = [NSIndexPath indexPathForRow:r-1 inSection:s-1];  //取最后一行数据
    [self.chatTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:animated]; //滚动到最后一行
}


#pragma mark TableView

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.showDatasArray.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    ShowMsgElem * getNewShowMsgElem =  [self.showDatasArray objectAtIndex:row];
    
    IFChatCell *cell;
    IFChatCellStyle cellStyle = getNewShowMsgElem.mine == 1 ? IFChatCellStyleRight:IFChatCellStyleLeft;
    
    if (getNewShowMsgElem.msgType == LWMsgTypeText) {
        NSString *tableSampleIdentifier = getNewShowMsgElem.mine == 1 ? @"TableSampleIdentifierRight":@"TableSampleIdentifierLeft";
        
        cell = [tableView dequeueReusableCellWithIdentifier:
                tableSampleIdentifier];
        if (cell == nil) {
            cell = [[IFChatCell alloc]
                    initWithStyle:cellStyle
                    reuseIdentifier:tableSampleIdentifier];
        }
        
        NSMutableAttributedString *attributedMessage = [[NSMutableAttributedString alloc] initWithString:getNewShowMsgElem.content attributes:@{ NSFontAttributeName: kFont(15), NSForegroundColorAttributeName: UIColor.whiteColor }];
        [LWEmojiManager.share replaceEmojiForAttributedString:attributedMessage font:kFont(15)];
        cell.contentLabel.adjustsFontSizeToFitWidth = true;
        cell.contentLabel.attributedText = attributedMessage;
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"IFChatImageCell"];
        if (!cell) {
            cell = [[IFChatImageCell alloc] initWithStyle:cellStyle reuseIdentifier:@"IFChatImageCell"];
        }
        [cell.contextImageView sd_setImageWithURL:[NSURL URLWithString:getNewShowMsgElem.imagePath] placeholderImage:[UIImage imageNamed:@"testicon"]];
        cell.clickImgeBlock = ^{
            [self showPic:getNewShowMsgElem.imagePath imageView:cell.contextImageView];
        };
    }
    NSString *avatar;
//    if (getNewShowMsgElem.mine == 1) {
//    }else{
//        avatar = getNewShowMsgElem.toAvatar;
//    }
    avatar = getNewShowMsgElem.uavatar;
    [cell.iconIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",kApiPrefix_PIC,avatar]] placeholderImage:[UIImage imageNamed:@"voip_header"]];
    cell.titleLabel.text = getNewShowMsgElem.username;
    cell.subTitleLabel.text = getNewShowMsgElem.mainProduct;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShowMsgElem *getNewShowMsgElem = [self.showDatasArray objectAtIndex:indexPath.row];
    if (getNewShowMsgElem.rowHeight == 0) {
        if (getNewShowMsgElem.msgType == LWMsgTypeText) {
            getNewShowMsgElem.rowHeight = [IFChatCell caculateTextHeightWithMaxWidth:self.chatTableView.width - [IFChatCell reserveWithForCell] text:getNewShowMsgElem.content];
        }else{
            getNewShowMsgElem.rowHeight = 200+ 10+20 + 25+ 15 + 15+10+15;
        }
    }
    return getNewShowMsgElem.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShowMsgElem *newMsgElem = self.showDatasArray[indexPath.row];
    NSLog(@"choose ID %@", newMsgElem.userID);
    
    
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGPoint offset = scrollView.contentOffset;
//    if (offset.y <= 0) {
//        [self getNeetShowDatas];
//    }
//}
//
////加载更多数据
//- (void)getNeetShowDatas
//{
//    if (self.totalDatasArray.count > self.showDatasArray.count) {
//        if (self.totalDatasArray.count - self.showDatasArray.count > 50) {
//            NSMutableArray *tem = [[NSMutableArray alloc] initWithArray:[self.totalDatasArray subarrayWithRange:NSMakeRange(self.totalDatasArray.count - self.showDatasArray.count - 50, 50)]];
//            [self.showDatasArray insertObjects:tem atIndex:0];
//        }else{
//            self.showDatasArray = [self.totalDatasArray mutableCopy];
//        }
//        [self.chatTableView reloadData];
//    }
//}

//图片预览
- (void)showPic:(NSString *)picPath imageView:(UIImageView *)imageview
{
    KNPhotoItems *items = [[KNPhotoItems alloc] init];
    items.url = picPath;
    items.sourceView = imageview;
    
    KNPhotoBrowser *photoBrower = [[KNPhotoBrowser alloc] init];
    photoBrower.itemsArr = @[items];
    photoBrower.currentIndex = 0;
    //    photoBrower.isNeedPageControl = true;
    //    photoBrower.isNeedPageNumView = true;
    //    photoBrower.isNeedRightTopBtn = true;
    //    photoBrower.isNeedPictureLongPress = true;
    [photoBrower present];
    //    photoBrower.delegate = self;
    //    _photoBrowser = photoBrower;
}

#pragma mark - other
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.chatKeyBoard keyboardDown];
}

- (void)chatKeyBoardSendText:(NSString *)text;
{
    if(![text isNotBlank]) return;
    [self requsetSendMsgService:text];
    
    NSString *msgjson = [self MsgToJsonString:text];
    [self requestSDKSendMsg:msgjson];
}

/// 处理向SDK发送的消息格式
/// @param text 输入的消息
- (NSString *)MsgToJsonString:(NSString *)text
{
    NSString *res;
    if (self.roomType == LWChatRoomTypeOneTOne) {
        NSDictionary *dict = @{
            @"id":LWDATA(self.roomId),
            @"username":LWDATA(_friendInforModel.chatNickName),
            @"avatar": [NSString stringWithFormat:@"/app/app/appfujian/download?attID=%@",LWDATA(self.friendInforModel.portrait)],
            @"content":LWDATA(text),
            @"sign":LWDATA(_friendInforModel.sign),
            @"mainProduct":LWDATA(_friendInforModel.mainProducts),
            @"msgCount":@"0",
            @"mid":@{
                    @"id":LWDATA(LWClientManager.share.userinforIM.avatarID),
                    @"userId":LWDATA(LWClientManager.share.userinforIM.customId),
                    @"groupId":LWDATA(self.roomId),
                    @"content":LWDATA(text),
                    @"sendTime":LWDATA([[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm:ss"]),
                    @"isDel":@"",
                    @"isRead":@"",
                    @"isBack":@""
            },
        };
        res = [LWTool dictoryToString:dict];
        LWLog(@"***************发送的单聊消息：%@\n",res);
    }else if (self.roomType == LWChatRoomTypeGroup){
        NSDictionary *dict = @{@"avatar":LWDATA(LWClientManager.share.userinforIM.avatar),
                               @"content":text,
                               @"id":LWDATA(IMUserInfo.shareInstance.userID),
                               @"isGroup":@"false",
                               @"mainProduct":LWDATA(LWClientManager.share.userinforIM.mainProducts),
                               @"mid":@{@"content":LWDATA(text),
                                        @"groupId":LWDATA(self.roomId),
                                        @"id":LWDATA(LWClientManager.share.userinforIM.avatarID),
                                        @"sendTime":LWDATA([[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm:ss"]),
                                        @"userId":LWDATA(IMUserInfo.shareInstance.userID),
                               },
                               @"msgCount":@"0",
                               @"username":LWDATA(LWClientManager.share.userinforIM.username)
        };
        res = [LWTool dictoryToString:dict];
        LWLog(@"***************发送群组消息：%@\n",res);
    }
    return  res;
}

#pragma mark -- ChatKeyBoardDataSource
- (NSArray<MoreItem *> *)chatKeyBoardMorePanelItems
{
    MoreItem *item1 = [MoreItem moreItemWithPicName:@"sharemore_vioe" highLightPicName:nil itemName:@"相册"];
    MoreItem *item2 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"相机"];
    //    MoreItem *item3 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"连接"];
    return @[item1, item2,];
}

- (NSArray<ChatToolBarItem *> *)chatKeyBoardToolbarItems
{
    ChatToolBarItem *item1 = [ChatToolBarItem barItemWithKind:kBarItemFace normal:@"face" high:@"face_HL" select:@"keyboard"];
    
    ChatToolBarItem *item2 = [ChatToolBarItem barItemWithKind:kBarItemVoice normal:@"voice" high:@"voice_HL" select:@"keyboard"];
    
    ChatToolBarItem *item3 = [ChatToolBarItem barItemWithKind:kBarItemMore normal:@"more_ios" high:@"more_ios_HL" select:nil];
    
    ChatToolBarItem *item4 = [ChatToolBarItem barItemWithKind:kBarItemSwitchBar normal:@"switchDown" high:nil select:nil];
    
    return @[item1, item2, item3, item4];
}

- (NSArray<FaceThemeModel *> *)chatKeyBoardFacePanelSubjectItems
{
    return [LWEmojiManager share].emojiMutableArray;
}

- (void)updatePicwithpic:(UIImage *)pic
{
    [LWClientManager.share requestUploadPicFile:pic success:^(id response) {
        if ([response[@"code"] integerValue] == 0) {
            NSDictionary *data = response[@"data"];
            NSString *msgtext = [NSString stringWithFormat:@"img[%@]",data[@"src"]];
            [self chatKeyBoardSendText:msgtext];
        }
    } failure:^(NSError *error) {
        
    }];
}

/**
 *  更多功能
 */
- (void)chatKeyBoard:(ChatKeyBoard *)chatKeyBoard didSelectMorePanelItemIndex:(NSInteger)index;
{
    WEAKSELF(self)
    if (index == 0) {
        [self.photopicker photoPickerWithPhotoLibrary:NO photoBlock:^(UIImage * _Nonnull image) {
            [weakself updatePicwithpic:image];
        }];
    }else if(index == 1){
        
        [self.photopicker photoPickerWithCamera:NO photoBlock:^(UIImage * _Nonnull image) {
            [weakself updatePicwithpic:image];
        }];
    }
}

- (UITableView *)chatTableView
{
    if (!_chatTableView) {
        
        _chatTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATOR_HEIGHT-49-LL_TabbarSafeBottomMargin) style:UITableViewStylePlain];
        _chatTableView.delegate = self;
        _chatTableView.dataSource = self;
        _chatTableView.backgroundColor = UIColor.whiteColor;
        //    tableView.separatorInset = UIEdgeInsetsMake(0, 14, 0, 18);
        //    tableView.separatorColor = [UIColor darkGrayColor];
        _chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _chatTableView.tableFooterView = [UIView new];
        _chatTableView.layer.masksToBounds = YES;
        _chatTableView.layer.cornerRadius = 8;
        _chatTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _chatTableView.rowHeight = UITableViewAutomaticDimension;
        _chatTableView.estimatedRowHeight = 30;
        _chatTableView.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestRecordListDatas)];
    }
    return _chatTableView;
}

- (LWPhotoPicker *)photopicker
{
    if (!_photopicker) {
        _photopicker = [[LWPhotoPicker alloc] init];
        _photopicker.viewController = self;
    }
    return _photopicker;
}


- (BOOL)isCurrentViewController
{
    UIViewController *vc = self.navigationController.childViewControllers.lastObject;
    if (vc && [vc isKindOfClass:[LWChatListBaseViewController class]]) {
        return YES;
    }
    return NO;
}

- (void)dealloc
{
    LWLog(@"\n***************************dealloc:%@****************************\n",self);
    REMOVIE_NOTI(NEW_MSG_CHAT_NOTI_KEY);
    REMOVIE_NOTI(NEW_MSG_GROPU_NOTI_KEY);
    REMOVIE_NOTI(DELE_GROPU_CHAT_NOTI_KEY);
    REMOVIE_NOTI(DELE_USER_GROPU_CHAT_NOTI_KEY);
}

@end
