//
//  MainTabBarController.m
//  QunBao
//
//  Created by fujunzhi on 16/11/3.
//  Copyright © 2016年 QunBao. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainNavController.h"
#import "zAshouyeController.h"
#import "zHyController.h"
#import "zJiaoliuController.h"
#import "zWodeController.h"
@interface MainTabBarController ()
@end

@implementation MainTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpChildControllers];
}



- (void) setUpChildControllers
{
    //首页
    
    zAshouyeController *syVC = [[zAshouyeController alloc]init];
    UIViewController *syNVC = [self setupChildViewController:syVC navigationController:[MainNavController class] title:@"首页" imageName:@"huoyuan_kefu.png" selectedImageName:@"huoyuan_kefu.png" offset:NO];
    
    //货源
    zHyController *hyVC = [[zHyController alloc]init];
   
    UIViewController *hyNVC = [self setupChildViewController:hyVC navigationController:[MainNavController class] title:@"货源" imageName:@"huoyuan_kefu.png" selectedImageName:@"huoyuan_kefu.png" offset:NO];
    
    //交流
    zJiaoliuController*jlVC = [[zJiaoliuController alloc]init];
    UIViewController *jlNVC = [self setupChildViewController:jlVC navigationController:[MainNavController class] title:@"交流大厅" imageName:@"huoyuan_kefu.png" selectedImageName:@"huoyuan_kefu.png" offset:NO];
//    jlNVC.tabBarItem.badgeValue = @"88";
    
    //我的
    zWodeController*wdVC = [[zWodeController alloc]init];
    
    UIViewController *wodeNVC = [self setupChildViewController:wdVC navigationController:[MainNavController class] title:@"我的" imageName:@"huoyuan_kefu.png" selectedImageName:@"huoyuan_kefu.png" offset:NO];
    
    //添加的是导航控制器
    self.viewControllers = @[syNVC, hyNVC, jlNVC, wodeNVC];
    


    
    //添加动画
//    self.selectAnimation = TabBarSelectAnimationScale;
    
    //添加中心按钮
//    __weak typeof(self) weakSelf = self;
//    [self addCenterItemWithIcon:@"search_nomal" selectedIcon:@"search_nomal" title:@"搜索" offset:YES clickBlock:^{
//        UIStoryboard *board = [UIStoryboard storyboardWithName:@"SearchViewController" bundle:nil];
//        SearchViewController *searchVC= [board instantiateViewControllerWithIdentifier:@"SearchViewController"];
//        UIViewController *searchNVC = [weakSelf setupChildViewController:searchVC navigationController:[MainNavController class] title:@"我的" imageName:@"" selectedImageName:@"" offset:NO];
//
//        [weakSelf presentViewController:searchNVC animated:YES completion:nil];
//    }];
    
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
//    NSLog(@"%@",self.tabBarItem.badgeValue);
    
}


@end




