//
//  zCompanyDetailCell.h
//  ZhuangBei
//
//  Created by aa on 2020/5/8.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zGoodsContentModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface zCompanyDetailCell : UITableViewCell

+(zCompanyDetailCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath;

@property(strong,nonatomic)NSArray * typesArray;

@property(strong,nonatomic)zGoodsContentModel * goosModel;



@end

NS_ASSUME_NONNULL_END
