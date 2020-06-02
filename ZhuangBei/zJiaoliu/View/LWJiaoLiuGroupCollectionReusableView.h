//
//  LWJiaoLiuGroupCollectionReusableView.h
//  ZhuangBei
//
//  Created by LWQ on 2020/4/27.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWJiaoLiuGroupCollectionReusableView : UICollectionReusableView
@property (nonatomic, strong) UILabel * titleL;

@end

@interface LWJiaoLiuGroupCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UILabel * nameL;
@property (nonatomic, strong) UIImageView * bgImageView;


@end

NS_ASSUME_NONNULL_END
