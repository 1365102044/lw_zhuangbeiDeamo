//
//  LWHuoYuanDeatilViewController.h
//  ZhuangBei
//
//  Created by LWQ on 2020/4/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import "baseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LWHuoYuanDeatilViewController : baseViewController
//装备型号id  非必需
@property (nonatomic, strong) NSString * modelId;
//供应商id
@property (nonatomic, strong) NSString * gongYingShangDm;
//装备id
@property (nonatomic, strong) NSString * zhuangBeiDm;
//装备类型 id
@property (nonatomic, strong) NSString * zhuangBeiLx;
//装备名称
@property (nonatomic, strong) NSString * zhuangBeiName;
@end

NS_ASSUME_NONNULL_END
