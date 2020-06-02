//
//  zShouYeLeftMenu.h
//  ZhuangBei
//
//  Created by aa on 2020/5/5.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zGoodsMenuModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^menuTapBack)(NSInteger index);

typedef void(^menuSelectBack)(zGoodsMenuModel * goodsModel);

@interface zShouYeLeftMenu : UIView


@property(strong,nonatomic)NSArray * menuArray;

@property(copy,nonatomic)menuTapBack menutapBack;

@property(copy,nonatomic)menuSelectBack menuSelectBack;

@end

NS_ASSUME_NONNULL_END
