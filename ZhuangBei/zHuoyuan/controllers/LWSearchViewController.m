//
//  LWSearchViewController.m
//  ZhuangBei
//
//  Created by LWQ on 2020/4/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWSearchViewController.h"
#import "LWSeachView.h"
#import "LWHuoYuanThreeLevelListTableViewCell.h"
#import "LWHuoYuanDeatilViewController.h"
#import "PPNetworkHelper.h"
#import "LWGongYingShangListViewController.h"
#import "LWThreeLevelTableView.h"

@interface LWSearchViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray * listDatas;
@property (nonatomic, strong) LWThreeLevelTableView * tableView;
@property (nonatomic, strong) LWSeachView * searchView;
@property (nonatomic, strong) NSString * searchValue;

@end

@implementation LWSearchViewController

- (void)requestDatas
{
    [[zHud shareInstance] hild];
    [PPNetworkHelper cancelAllRequest];
    
    [self requestPostWithUrl:@"app/appzhuangbei/listByQian" para:@{@"searchValue":LWDATA(self.searchValue),@"gysLimit":@"100",} paraType:(LWRequestParamTypeString) success:^(id  _Nonnull response) {
        
        
        
        if ([response[@"code"] integerValue] == 0) {
            NSDictionary *page = response[@"page"];
            self.currPage = [page[@"currPage"] integerValue];
            self.totalPage = [page[@"totalPage"] integerValue];
            NSArray *list = page[@"list"];
            if (self.currPage == 1) {
                [self.listDatas removeAllObjects];
            }
            for (NSDictionary *dict in list) {
                [self.listDatas addObject: [LWHuoYuanThreeLevelModel modelWithDictionary:dict]];
            }
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
            if (self.currPage >= self.totalPage) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_footer resetNoMoreData];
            }
        }
        if (self.listDatas.count == 0) {
            self.nothingView.alpha = 1;
            [self.view bringSubviewToFront:self.nothingView];
        }else{
            self.nothingView.alpha = 0;
            [self.view sendSubviewToBack:self.nothingView];
        }
        self.tableView.mj_footer.hidden = self.listDatas.count == 0;
        self.tableView.listDatas = self.listDatas;
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (self.currPage == 1) {
            [self.tableView.mj_footer setHidden:YES];
        }
    }];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.tableView endTableViewCellEdit];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    //    self.navigationController.navigationBar.hidden = YES;
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ConfiUI];
    self.tableView.mj_footer.hidden = YES;
    [self requestDatas];
}

- (void)ConfiUI
{
    WEAKSELF(self)
    self.searchView = [LWSeachView seachview:^(NSInteger tag, NSString * str) {
        if (tag == 1) {
            [weakself.navigationController popViewControllerAnimated:YES];
        }else{
            LWLog(@"------------------%@",str);
            weakself.searchValue = str;
            [weakself requestDatas];
        }
    }];
    [self.view addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).mas_offset(STATUS_BAR_HEIGHT);
        make.height.mas_offset(60);
    }];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.searchView.mas_bottom).mas_offset(0);
    }];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.nothingView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.left.mas_equalTo(self.view).mas_offset(0);
        make.top.mas_equalTo(self.searchView.mas_bottom).mas_offset(10);
    }];
}

- (LWThreeLevelTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[LWThreeLevelTableView alloc] initWithFrame:CGRectZero];
        _tableView.sourceVc = self;
    }
    return _tableView;
}

- (NSMutableArray *)listDatas
{
    if (!_listDatas) {
        _listDatas = [[NSMutableArray alloc] init];
    }
    return _listDatas;
}
@end
