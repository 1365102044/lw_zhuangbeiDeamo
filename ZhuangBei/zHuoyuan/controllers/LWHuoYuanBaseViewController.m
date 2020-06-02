//
//  LWHuoYuanBaseViewController.m
//  ZhuangBei
//
//  Created by LWQ on 2020/4/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWHuoYuanBaseViewController.h"
#import "LWSearchViewController.h"

@interface LWHuoYuanBaseViewController ()

@end

@implementation LWHuoYuanBaseViewController

- (void)clickSearchBtn:(UIButton *)sender
{
    LWSearchViewController *seachvc = [LWSearchViewController new];
    [self.navigationController pushViewController:seachvc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    UIButton *seachBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
     [seachBtn setImage:IMAGENAME(@"icon_search") forState:UIControlStateNormal];
     [seachBtn addTarget:self action:@selector(clickSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:seachBtn];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:seachBtn];
}

- (void)refreshData
{
    self.currPage = 1;
    [self requestDatas];
}

- (void)loadMore
{
    if (self.currPage < self.totalPage) {
        ++ self.currPage;
        [self requestDatas];
    }
}

- (void)requestDatas
{
    
}
@end
