//
//  LWThreeLevelTableView.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/11.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWHuoYuanDaTingModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface LWThreeLevelTableView : UITableView<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray<LWHuoYuanThreeLevelModel *> * listDatas;
@property (nonatomic, assign) NSInteger  lastEditingIndex;
//父控制器
@property (nonatomic, strong) UIViewController * sourceVc;
//结束cell的编辑状态
- (void)endTableViewCellEdit;

@end

NS_ASSUME_NONNULL_END
