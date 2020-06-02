//
//  zCompanyDetailController.h
//  ZhuangBei
//  公司详情
//  Created by aa on 2020/5/8.
//  Copyright © 2020 aa. All rights reserved.
//

#import "baseViewController.h"
#import "zGoodsContentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface zCompanyDetailController : baseViewController

@property(strong,nonatomic)zGoodsContentModel * goosModel;

@property(assign,nonatomic)NSInteger type;

@end

NS_ASSUME_NONNULL_END
