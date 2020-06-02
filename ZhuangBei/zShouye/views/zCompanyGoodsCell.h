//
//  zCompanyGoodsCell.h
//  ZhuangBei
//
//  Created by aa on 2020/5/18.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zCompanyGoodsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface zCompanyGoodsCell : UITableViewCell

+(zCompanyGoodsCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath;

@property(strong,nonatomic)NSArray * typesArray;

@property(strong,nonatomic)zCompanyGoodsModel * goosModel;

@property(strong,nonatomic)NSDictionary * goosDic;

@end

NS_ASSUME_NONNULL_END
