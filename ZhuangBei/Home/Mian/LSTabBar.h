//
//  LSTabBar.h
//  TabBar
//
//  Created by Airy on 16/4/12.
//  Copyright © 2016年 Airy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSTabBar : UITabBar

@property (nonatomic, copy) void  (^ tabBarClicked)(NSUInteger from, NSUInteger to);
@property (nonatomic, assign) NSUInteger            selectedIndex;

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@end
