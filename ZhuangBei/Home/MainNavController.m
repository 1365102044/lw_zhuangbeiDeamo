//
//  MainNavController.m
//  QunBao
//
//  Created by fujunzhi on 16/1/5.
//  Copyright © 2016年 QunBao. All rights reserved.
//

#import "MainNavController.h"

@interface MainNavController ()

@end

@implementation MainNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationBar *bar = [UINavigationBar appearance];

    [bar setTranslucent:NO];
    //设置导航条背景颜色
    [bar setBarTintColor:[UIColor whiteColor]];
    [bar setBackgroundColor:[UIColor whiteColor]];
    [bar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    //设置标题字体属性
    NSDictionary *titleTextAttributes = @{
                                          NSFontAttributeName : [UIFont systemFontOfSize:18],
                                          NSForegroundColorAttributeName : [UIColor blackColor]
                                          };
    [bar setTitleTextAttributes:titleTextAttributes];
    
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"··· " style:UIBarButtonItemStyleDone target:self action:nil];
    
    //统一返回按钮样式
    UIBarButtonItem * leftBarButtonItem =   [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"return_btn"] style:UIBarButtonItemStylePlain target:self action:nil];
    
    self.navigationItem.leftBarButtonItem =leftBarButtonItem;

}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }else
    {
    }
    [super pushViewController:viewController animated:animated];
}


@end
