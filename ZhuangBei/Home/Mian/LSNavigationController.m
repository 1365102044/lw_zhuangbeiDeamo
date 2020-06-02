//
//  LSNavigationController.m
//  TabBar
//
//  Created by Airy on 16/4/12.
//  Copyright © 2016年 Airy. All rights reserved.
//

#import "LSNavigationController.h"

#define LSColor_alpha(r, g, b, a)   [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define LSColor(r, g, b)            LSColor_alpha(r, g, b, 1.0)
#define LSOrangeColor               LSColor(255, 131, 71)


@interface LSNavigationController ()

@end

@implementation LSNavigationController

+ (void)initialize
{
    [super initialize];
    [self setNavigationBar];
}

+ (void)setNavigationBar
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.tintColor = [UIColor whiteColor];
    navBar.barTintColor = LSOrangeColor;
    
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                   NSFontAttributeName : [UIFont systemFontOfSize:19]};
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIImage *image = [[UIImage imageNamed:@"toolbar_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                                           style:UIBarButtonItemStyleDone
                                                                                          target:self
                                                                                          action:@selector(leftBarButtonItemClicked)];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)leftBarButtonItemClicked
{
    [self popViewControllerAnimated:YES];
}

@end
