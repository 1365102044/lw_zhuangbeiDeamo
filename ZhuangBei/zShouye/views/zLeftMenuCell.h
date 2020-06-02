//
//  zLeftMenuCell.h
//  ZhuangBei
//
//  Created by aa on 2020/5/5.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zGoodsMenuModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^menuSelectBack)(zGoodsMenuModel * goodsModel);

@interface zLeftMenuCell : UITableViewCell

+(zLeftMenuCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath;

@property(strong,nonatomic)zGoodsMenuModel * goodsModel;

@property(copy,nonatomic)menuSelectBack menuSelectBack;

@end

NS_ASSUME_NONNULL_END
