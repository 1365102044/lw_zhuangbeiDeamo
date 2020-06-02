//
//  LWHuoYuanThreeLevelListTableViewCell.h
//  ZhuangBei
//
//  Created by LWQ on 2020/4/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWHuoYuanDaTingModel.h"

typedef void(^changeEditStatusBlock)(BOOL editing);
typedef void(^clickItemsBlock)(gysListModel * model);
@interface LWHuoYuanThreeLevelListTableViewCell : UITableViewCell<UIScrollViewDelegate>

@property (nonatomic, strong) LWHuoYuanThreeLevelModel * model;
@property (nonatomic, copy) clickItemsBlock clickItemsBlock;
@property (nonatomic, copy) changeEditStatusBlock editBlock;

// -1 没有
@property (nonatomic, assign) BOOL isEditing;

@end

