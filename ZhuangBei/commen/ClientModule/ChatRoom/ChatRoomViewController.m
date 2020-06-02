//
//  ChatRoomViewController.m
//  IMDemo
//
//  Created by  Admin on 2017/12/25.
//  Copyright © 2017年  Admin. All rights reserved.
//

#import "ChatRoomViewController.h"
#import "LWClientHeader.h"

#import "IMUserInfo.h"

#import "IFChatView.h"

#define INTERVAL_KEYBOARD  20

@interface ChatRoomViewController ()

@end

@implementation ChatRoomViewController
// app/appfriendmessage/save
//app/appfriendmessage/getFriendMsgList


- (void)viewDidLoad {
    [super viewDidLoad];
    

}

#pragma mark - Event

- (void)rightButtonClicked:(UIButton *)button {
    if ([self.mCreaterId isEqualToString:[IMUserInfo shareInstance].userID]) {
        #warning ---------------lw---------------
//        [[XHClient sharedClient].roomManager deleteChatroom:self.mRoomId completion:^(NSError *error) {
//            if (error) {
//                [UIView ilg_makeToast:[NSString stringWithFormat:@"删除聊天室失败:%@", error.localizedDescription]];
//
//            } else {
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"IFChatroomListRefreshNotif" object:nil];
//
//                [self.navigationController popViewControllerAnimated:YES];
//            }
//        }];
    }
}

- (void)kick:(NSString *)userID {
    __weak typeof(self) weakSelf = self;
    #warning ---------------lw---------------
//    [[XHClient sharedClient].roomManager removeMember:userID fromChatroom:self.mRoomId completion:^(NSError *error) {
//        if (error) {
//            [weakSelf.view ilg_makeToast:error.localizedDescription position:ILGToastPositionCenter];
//        } else {
//            [weakSelf.view ilg_makeToast:@"移除成功" position:ILGToastPositionCenter];
//        }
//    }];
}

- (void)mute:(NSString *)userID {
    __weak typeof(self) weakSelf = self;
    #warning ---------------lw---------------
//    [[XHClient sharedClient].roomManager muteMember:userID muteSeconds:60 fromChatroom:self.mRoomId completion:^(NSError *error) {
//        if (error) {
//            [weakSelf.view ilg_makeToast:error.localizedDescription position:ILGToastPositionCenter];
//        } else {
//            [weakSelf.view ilg_makeToast:@"禁言成功" position:ILGToastPositionCenter];
//        }
//    }];
}



- (void)chatMessageDidReceive:(NSNotification *)notif {
    NSDictionary *dic = notif.object;
    NSString *msg = dic[@"message"];
    NSString *uid = dic[@"uid"];
    
    [self showTrace:msg userID:uid isMySelf:NO];
}



#pragma mark XHChatroomManagerDelegate



- (NSArray *)actionTitleArr:(NSString *)targetID {
    if ([targetID isEqualToString:[IMUserInfo shareInstance].userID]) { //自己
        return @[];
    } else if ([[IMUserInfo shareInstance].userID isEqualToString:self.mCreaterId]) { //不是自己，而且自己是拥有者
        return @[@"踢出房间", @"禁止发言", @"私信"];
    } else { //自己是普通成员
        return @[@"私信"];
    }
}
- (NSArray *)actionEventArr:(NSString *)targetID {
    if ([targetID isEqualToString:[IMUserInfo shareInstance].userID]) { //自己
        return @[];
    } else if ([[IMUserInfo shareInstance].userID isEqualToString:self.mCreaterId]) { //不是自己，而且自己是拥有者
        return @[@"kick:", @"mute:", @"privateMsg:"];
    } else { //自己是普通成员
        return @[@"privateMsg:"];
    }
}



#pragma mark - other
- (void)showManagerDialog:(NSString *)userID
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                                                                             message:@""
                                                                      preferredStyle:UIAlertControllerStyleAlert ];
    
    UIAlertAction *home1Action = [UIAlertAction actionWithTitle:@"剔出房间" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:home1Action];
    UIAlertAction *home2Action = [UIAlertAction actionWithTitle:@"禁止发言" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:home2Action];
    UIAlertAction *home3Action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:home3Action];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)showTrace:(NSString *)msg userID:(NSString *)userID isMySelf:(BOOL)isMySelf
{
    dispatch_async(dispatch_get_main_queue(), ^{
        ShowMsgElem *newMsgElem = [self convertMsgToModel:msg userID:userID];
        [self.showDatasArray addObject:newMsgElem];
        [self.chatTableView reloadData];
        [self scrollTableToFoot:NO];
    });
}

- (ShowMsgElem *)convertMsgToModel:(NSString *)msg userID:(NSString *)userID {
    ShowMsgElem *newMsgElem = [[ShowMsgElem alloc] init];
    newMsgElem.userID = userID;
    //    newMsgElem.text = msg;
    //    newMsgElem.isMySelf = [userID isEqualToString:UserId];
    newMsgElem.rowHeight = [IFChatCell caculateTextHeightWithMaxWidth:self.chatTableView.width - [IFChatCell reserveWithForCell] text:msg];
    return newMsgElem;
}

@end
