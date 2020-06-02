//
//  zBusinessController.m
//  ZhuangBei
//
//  Created by aa on 2020/5/16.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zBusinessController.h"

@interface zBusinessController ()

@end

@implementation zBusinessController

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



@end
