//
//  MessageGroupViewController.m
//  IMDemo
//
//  Created by  Admin on 2018/1/5.
//  Copyright © 2018年  Admin. All rights reserved.
//

#import "MessageGroupViewController.h"
#import "ShowMsgElem.h"
#import "MessageGroupSettingViewController.h"
#import "InterfaceUrls.h"
#import "LWClientHeader.h"
#import "IFChatView.h"
#import "IFChatCell.h"
#import "LWTool.h"
#import "LWGroupMemberListViewController.h"

#define INTERVAL_KEYBOARD  2

@interface MessageGroupViewController ()

@end

@implementation MessageGroupViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *rightbtn = [UIButton new];
    [rightbtn setImage:IMAGENAME(@"addnewchat") forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    rightbtn.frame = CGRectMake(0, 0, 40, 40);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
}



#pragma mark - Event
- (void)rightButtonClicked:(UIButton *)button {
    LWGroupMemberListViewController *vc = [[LWGroupMemberListViewController alloc] init];
    vc.roomId = self.roomId;
    vc.roomName = self.roomName;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
