//
//  zGoodsDetailCell.h
//  ZhuangBei
//
//  Created by aa on 2020/5/8.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface zGoodsDetailCell : UITableViewCell

+(zGoodsDetailCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath;

@property(strong,nonatomic)NSArray * typesArray;

@end

NS_ASSUME_NONNULL_END
