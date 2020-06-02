//
//  LSTabBar.m
//  TabBar
//
//  Created by Airy on 16/4/12.
//  Copyright © 2016年 Airy. All rights reserved.
//

#import "LSTabBar.h"
#import "LSTabBarButton.h"

#define LSColor_alpha(r, g, b, a)   [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define LSColor(r, g, b)            LSColor_alpha(r, g, b, 1.0)

#define LSBlackTextColor                    LSColor(81, 81, 81)
#define LSOrangeColor                       LSColor(255, 131, 71)

@interface LSTabBar ()

@property (nonatomic, assign) NSUInteger        count;
@property (nonatomic, strong) LSTabBarButton    *selectedBtn;

@end

@implementation LSTabBar

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[LSTabBarButton class]] && view.tag == selectedIndex) {
            [self btnClicked:(LSTabBarButton *)view];
        }
    }
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    LSTabBarButton *btn = [[LSTabBarButton alloc] init];
    [btn setTitle:item.title forState:UIControlStateNormal];
    [btn setTitleColor:LSBlackTextColor forState:UIControlStateNormal];
    [btn setTitleColor:kNavColor forState:UIControlStateSelected];
    [btn setImage:item.image forState:UIControlStateNormal];
    [btn setImage:item.selectedImage forState:UIControlStateSelected];
    [btn addTarget:self
                     action:@selector(btnClicked:)
           forControlEvents:UIControlEventTouchDown];
    btn.tag = _count;
    btn.item = item;
    [self addSubview:btn];
    
    if (_count == 0) {
        [self btnClicked:btn];
    }
    
    _count++;
}

- (void)btnClicked:(LSTabBarButton *)btn
{
    if (_selectedBtn != nil) {
        if (btn.tag == _selectedBtn.tag) return;
    }
    
    NSUInteger lastIndex = _selectedBtn.tag;
    
    _selectedBtn.selected = NO;
    btn.selected = YES;
    _selectedBtn = btn;
    
    if (self.tabBarClicked) {
        self.tabBarClicked(lastIndex, btn.tag);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    CGFloat buttonY = 0;
    CGFloat buttonW = width / _count;
    CGFloat buttonH = height;
    NSInteger index = 0;
    
    for (UIView *view in self.subviews) {
        
        if ([view isKindOfClass:[LSTabBarButton class]]) {
            CGFloat buttonX = index * buttonW;
            view.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            index++;
            
        } else if ([view isKindOfClass:[UIImageView class]]) {
        
        } else {
            [view removeFromSuperview];
        }
    }
}

@end
