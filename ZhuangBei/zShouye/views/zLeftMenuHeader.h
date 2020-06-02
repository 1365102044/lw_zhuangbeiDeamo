//
//  zLeftMenuHeader.h
//  ZhuangBei
//
//  Created by aa on 2020/5/7.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zHuoYuanModel.h"
#import "zGoodsMenuModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^leftMenuHeaderTapBack)(zGoodsMenuModel * hymodel);

@interface zLeftMenuHeader : UIView

@property(strong,nonatomic)zGoodsMenuModel * hyModel;

@property(copy,nonatomic)leftMenuHeaderTapBack menuHeaerTapBack;

@end

NS_ASSUME_NONNULL_END
