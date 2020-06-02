//
//  zCityCollectionHeaderView.h
//  ZhuangBei
//
//  Created by aa on 2020/5/13.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^selectAllTapBack)(BOOL selectAll);

@interface zCityCollectionHeaderView : UICollectionReusableView

@property(assign,nonatomic)BOOL canEdit;
@property(assign,nonatomic)BOOL selectAll;
@property(copy,nonatomic)selectAllTapBack selectAllTap;

@end

NS_ASSUME_NONNULL_END
