//
//  ActionSheetView.h
//  guoziyunparent
//
//  Created by aa on 2019/7/25.
//  Copyright © 2019 xuxianwang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ActionSheetView;

@protocol ActionSheetDelegate <NSObject>

- (void)actionSheetView:(ActionSheetView *)actionSheetView clickButtonAtIndex:(NSInteger )buttonIndex;

@end

@interface ActionSheetView : UIView

/** 按钮，用于控制样式*/
@property(strong, nonatomic)NSMutableArray<UIButton *> *btns;

// 支持代理
@property (nonatomic,weak) id <ActionSheetDelegate> delegate;

// 支持block
@property (nonatomic,copy) void (^ClickIndex) (NSInteger index);


/**
 根据数组进行文字显示,返回index
 @param titleArr 传入显示的数组
 @param show 是否显示取消按钮
 @return return value description
 */
- (instancetype)initWithTitleArray:(NSArray *)titleArr
                     andShowCancel:(BOOL )show;

- (void)show;
@end

NS_ASSUME_NONNULL_END
