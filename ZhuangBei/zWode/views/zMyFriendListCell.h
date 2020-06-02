//
//  zMyFriendListCell.h
//  ZhuangBei
//
//  Created by aa on 2020/5/19.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zFriendsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface zMyFriendListCell : UITableViewCell

+(zMyFriendListCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath;

@property(strong,nonatomic)zFriendsModel * model;

@end

NS_ASSUME_NONNULL_END
