//
//  historyCollectionCell.h
//  guoziyunparent
//
//  Created by aa on 2019/7/19.
//  Copyright © 2019 xuxianwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zListTypeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface zCityCollectionCell : UICollectionViewCell

@property(strong,nonatomic)NSString * souceString;

@property(strong,nonatomic)UIColor * backColor;//背景色

@property(strong,nonatomic)zListTypeModel * model;

@property (nonatomic, assign) BOOL  select;


@end

NS_ASSUME_NONNULL_END
