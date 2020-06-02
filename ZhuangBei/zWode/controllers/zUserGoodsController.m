//
//  zUserGoodsController.m
//  ZhuangBei
//
//  Created by aa on 2020/5/16.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zUserGoodsController.h"

@interface zUserGoodsController ()

@end

@implementation zUserGoodsController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nothingView.alpha = 1;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
