//
//  LWGroupMemberListViewController.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/19.
//  Copyright © 2020 aa. All rights reserved.
//

#import "baseViewController.h"


@interface LWGroupMemberListCell : UITableViewCell
@property (nonatomic, strong) UIImageView * icon;
@property (nonatomic, strong) UILabel * nameL;
@end


@interface LWGroupMemberListViewController : baseViewController
@property (nonatomic, strong) NSString * roomName;
@property (nonatomic, strong) NSString * roomId;

@end


