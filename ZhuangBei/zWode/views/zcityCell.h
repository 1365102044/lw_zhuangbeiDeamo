//
//  zcityCell.h
//  ZhuangBei
//
//  Created by aa on 2020/5/3.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zPersonalModel.h"
#import "zUpLoadUserModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^changeUpModelBack)(zUpLoadUserModel * upModel,zPersonalModel* perModel);

@interface zcityCell : UITableViewCell

+(zcityCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath;

@property(copy,nonatomic)changeUpModelBack changeModelBack;

@property(strong,nonatomic)zPersonalModel * persoamModel;
@property(strong,nonatomic)zUpLoadUserModel * upModel;

@property(assign,nonatomic)BOOL canEdit;

@end

NS_ASSUME_NONNULL_END
