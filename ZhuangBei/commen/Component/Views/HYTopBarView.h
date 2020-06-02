//
//  HYTopBarView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/28.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^callBackBlock)(NSInteger index);
typedef NS_ENUM(NSUInteger, TopBarLineStyle) {
    TopBarLineStyleWithBtnWidth,
    TopBarLineStyleWithTextWidth,
    TopBarLineStyleWithCountFixWidth,
};
@interface HYTopBarView : UIView
+ (instancetype)creatTopBarWithDataArr:(NSArray *)dataArr selectColor:(UIColor *)selectColor lineStyle:(TopBarLineStyle)lineStyle callBack:(callBackBlock)callBackBlock;

+ (instancetype)creatTopBarWithDataArr:(NSArray *)dataArr selectColor:(UIColor *)selectColor callBack:(callBackBlock)callBackBlock;

- (void)selectIndex:(NSInteger)index;

//@property (nonatomic, assign) CGFloat lineTopSpace;
// 下划线样式
@property (nonatomic, assign) TopBarLineStyle  lineStyle;
/**
 修改btn内容

 @param title 字符串
 @param index 下标
 */
- (void)changeBtnTitle:(NSString *)title index:(NSInteger)index;


@property (nonatomic, assign) BOOL isNotCanClickBool;

@end
