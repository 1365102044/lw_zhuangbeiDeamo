//
//  sliderNavMenu.h
//  guoziyunparent
//  可滑动的分类选择器
//  Created by aa on 2019/7/5.
//  Copyright © 2019 xuxianwang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum: NSUInteger {
    //左对齐
    menuAligenLeft,
    //居中
    menuAligenCenter,
} sliderMenuType;

@protocol sliderNavMenuDelegate <NSObject>

@optional

-(void)sliderNavMenuSelectIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_BEGIN

@interface sliderNavMenu : UIView

@property(assign,nonatomic)CGFloat padding;

@property(assign,nonatomic)BOOL fullCenter;//从最左侧开始居中
@property(assign,nonatomic)sliderMenuType sliderType;//居中或者左对齐
@property(assign,nonatomic)BOOL havesliderBar;//有下划线
@property(nonatomic,strong)UIColor * normalFontColor;//正常标题颜色

@property(nonatomic,strong)UIColor * selectFontColor;//选中标题颜色
@property(assign,nonatomic)CGFloat fontSize;//标题字体大小
@property(strong,nonatomic)UIFont * normalFont;//正常标题字体
@property(strong,nonatomic)UIFont * selectFont;//选中标题字体
@property(weak,nonatomic)id<sliderNavMenuDelegate> delegate;
@property(strong,nonatomic)UIColor * selectItemBackGroundColor;//选中背景色
@property(assign,nonatomic)NSInteger selectIndex;
@property(assign,nonatomic)BOOL sliderAnimation;
/** 指示条宽度*/
@property(nonatomic, assign)CGFloat sliderWidth;
/** 指示条是否圆角*/
@property(nonatomic, assign)CGFloat sliderRoundCorner;

-(void)setSourceArray:(NSArray *)sourceArray;

@end

NS_ASSUME_NONNULL_END
