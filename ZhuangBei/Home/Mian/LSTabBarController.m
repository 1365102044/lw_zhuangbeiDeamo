//
//  LSTabBarController.m
//  TabBar
//
//  Created by Airy on 16/4/12.
//  Copyright © 2016年 Airy. All rights reserved.
//

#import "LSTabBarController.h"
#import "LSTabBar.h"
#import "MainNavController.h"
#import "zAshouyeController.h"
#import "zHyController.h"
#import "zJiaoliuController.h"
#import "zWodeController.h"
#import "LWClientHeader.h"

@interface LSTabBarController ()

@property (nonatomic, strong) LSTabBar *tabbar;

@end

@implementation LSTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    [self setTabBar];
    [self addChildVC];
    
    [self addObserver:self
           forKeyPath:@"selectedIndex"
              options:NSKeyValueObservingOptionNew
              context:nil];
    ADD_NOTI(unreadMsgNumberChange, LOCAL_UNREAD_MSG_LIST_CHANGE_NOTI_KEY);
}

- (void)unreadMsgNumberChange
{
    zJiaoliuController *vc = (zJiaoliuController *)(self.childViewControllers[2].childViewControllers.firstObject);
    NSInteger num = [LWClientManager share].unreadMsgNum + LWClientManager.share.unreadSysMsgNum;
    vc.navigationController.tabBarItem.badgeValue = (num == 0) ? nil: [NSString stringWithFormat:@"%ld",(long)num];
}


- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"selectedIndex"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    _tabbar.selectedIndex = self.selectedIndex;
}

- (void)setTabBar
{
    _tabbar = [[LSTabBar alloc] init];
    [self setValue:_tabbar forKey:@"tabBar"];
    
    __weak __typeof(self) weakSelf = self;
    [_tabbar setTabBarClicked:^(NSUInteger from, NSUInteger to) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.selectedIndex = to;
    }];
}



- (void)addChildVC
{
    //首页
    
//    zAshouyeController *syVC = [[zAshouyeController alloc]init];
//    //        syVC.tabBarItem.badgeValue = @"N";
//    [self setupChildViewController:syVC title:@"首页" imageName:@"home_nor" selectedImageName:@"home_sel"];
    
    
    //货源
//    zHyController *hyVC = [[zHyController alloc]init];
//    [self setupChildViewController:hyVC title:@"货源" imageName:@"goods_nor" selectedImageName:@"goods_sel"];
    //交流
//    zJiaoliuController*jlVC = [[zJiaoliuController alloc]init];
//    NSInteger num = [LWClientManager share].unreadMsgNum + LWClientManager.share.unreadSysMsgNum;
//    jlVC.tabBarItem.badgeValue =  num == 0 ? nil: [NSString stringWithFormat:@"%ld",num];
//
//    [self setupChildViewController:jlVC title:@"交流大厅" imageName:@"friend_nor" selectedImageName:@"friend_sel"];
    
    //我的
//    zWodeController*wdVC = [[zWodeController alloc]init];
//    [self setupChildViewController:wdVC title:@"我的" imageName:@"personal_nor" selectedImageName:@"personal_sel"];
//
    
    
    [self addVCWithvc:[[zAshouyeController alloc] init]
                title:@"首页"
                image:@"home_nor"
        selectedImage:@"home_sel"
           badgeValue:@"0"];
    
    [self addVCWithvc:[[zHyController alloc] init]
                title:@"货源"
                image:@"goods_nor"
        selectedImage:@"goods_sel"
           badgeValue:@"0"];
    
    NSInteger num = [LWClientManager share].unreadMsgNum + LWClientManager.share.unreadSysMsgNum;
    [self addVCWithvc:[[zJiaoliuController alloc] init]
                title:@"交流大厅"
                image:@"friend_nor"
        selectedImage:@"friend_sel"
           badgeValue:[NSString stringWithFormat:@"%ld",(long)num]];
    
    
    [self addVCWithvc:[[zWodeController alloc] init]
                title:@"我的"
                image:@"personal_nor"
        selectedImage:@"personal_sel"
           badgeValue:@"0"];
}

- (void)addVCWithvc:(UIViewController *)vc
              title:(NSString *)title
              image:(NSString *)image
      selectedImage:(NSString *)selectedImage
         badgeValue:(NSString *)badgeValue
{
    MainNavController *navigationController = [[MainNavController alloc] initWithRootViewController:vc];
    
    navigationController.tabBarItem.title = title;
    navigationController.tabBarItem.image = [UIImage imageNamed:image];
    UIImage *selected = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigationController.tabBarItem.selectedImage = selected;
    
    [self addChildViewController:navigationController];
    
    [_tabbar addTabBarButtonWithItem:navigationController.tabBarItem];
    navigationController.tabBarItem.badgeValue = badgeValue;
}

@end
