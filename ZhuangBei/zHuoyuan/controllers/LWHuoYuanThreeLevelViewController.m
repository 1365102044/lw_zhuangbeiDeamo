//
//  LWHuoYuanThreeLevelViewController.m
//  ZhuangBei
//
//  Created by LWQ on 2020/4/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWHuoYuanThreeLevelViewController.h"
#import "LWHuoYuanThreeLevelListTableViewCell.h"
#import "LWGongYingShangListViewController.h"
#import "LWHuoYuanDaTingModel.h"
#import "LWHuoYuanDeatilViewController.h"
#import "LWThreeLevelTableView.h"

@interface LWHuoYuanThreeLevelViewController ()
@property (nonatomic, strong) NSMutableArray<LWHuoYuanThreeLevelModel *> * listDatas;
@property (nonatomic, strong) LWThreeLevelTableView * tableView;
//@property (nonatomic, assign) NSInteger  lastEditingIndex;
@end

// 货源大厅三级页面
@implementation LWHuoYuanThreeLevelViewController
- (void)requestDatas
{
    [self requestPostWithUrl:@"app/appzhuangbei/listByQian" paraString:@{@"id":LWDATA(self.zbTypeId),@"gysLimit":@(100)} success:^(id  _Nonnull response) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        //        LWLog(@"-------------货源大厅三级列表:%@",response);
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
            
            //            if (self.currPage >= self.totalPage) {
            //                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            //            }else{
            //                [self.tableView.mj_footer resetNoMoreData];
            //            }
        }
        if (self.listDatas.count == 0) {
            [self.view bringSubviewToFront:self.nothingView];
        }else{
            [self.view sendSubviewToBack:self.nothingView];
        }
        self.nothingView.alpha = self.listDatas.count == 0 ? 1:0;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.titleStr;
    [self confiUI];
    [self requestDatas];
}

- (void)confiUI
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
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
