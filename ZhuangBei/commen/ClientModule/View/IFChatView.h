//
//  IFChatView.h
//  IMDemo
//
//  Created by zhangtongle-Pro on 2018/4/2.
//  Copyright © 2018年  Admin. All rights reserved.
//

#import "IFBaseView.h"

@protocol IFChatViewDelegate <NSObject>
- (void)chatViewDidSendText:(NSString *)text;
@optional
@end

@interface IFChatView : IFBaseView
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *tableViewForMemberList;//暂时没有使用
@property (nonatomic, strong) UIButton *micButton;

@property (nonatomic, strong) UITextField *textField;
//检查是否有y发言权限
- (void)checkUserCanSendmsg:(BOOL)iscan msg:(NSString *)msg;

- (instancetype)initWithDelegate:(id<UITableViewDelegate, UITableViewDataSource, IFChatViewDelegate>)delegate;

@end
