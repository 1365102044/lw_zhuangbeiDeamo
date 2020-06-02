//
//  LWSwitchBarView.h
//  ZhuangBei
//
//  Created by LWQ on 2020/4/27.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^clickBlock)(UIButton *btn);

@interface LWSwitchBarView : UIView

// 当前选择的标签
@property (nonatomic, assign) NSInteger  currentIndex;

/// 初始化静态方法
/// @param items 显示的item数组
/// @param callBlock 点击事件回调（UIButton）
+ (instancetype)switchBarView:(NSArray *)items clickBlock:(clickBlock)callBlock;

//主动设置当前的index
@property (nonatomic, assign) NSInteger  selectIndex;

@end

NS_ASSUME_NONNULL_END
