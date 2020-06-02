//
//  zCompanyController.m
//  ZhuangBei
//
//  Created by aa on 2020/5/5.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zCompanyController.h"
#import "zJxsLeftMenu.h"
#import "zHuoYuanListCell.h"
#import "zCompanyDetailController.h"
#import "zBusinessLoactionModel.h"

@interface zCompanyController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView * menuTableView;

@property(strong,nonatomic)zJxsLeftMenu * leftMenu;

@property(strong,nonatomic)NSMutableDictionary * listParmas;

@property(assign,nonatomic)NSInteger currentPage;

@property(strong,nonatomic)NSMutableArray * menuListArray;

@property(strong,nonatomic)NSMutableArray * contentListArray;

@property(strong,nonatomic)NSMutableArray * addLocationArray;

@end

@implementation zCompanyController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.showNav) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    [self loadMenuList];
    [self loadList];
}

-(NSMutableArray*)addLocationArray{
    if (!_addLocationArray) {
        _addLocationArray = [NSMutableArray array];
    }
    return _addLocationArray;
}

-(zJxsLeftMenu*)leftMenu
{
    if (!_leftMenu) {
        __weak typeof(self)weakSelf = self;
        _leftMenu = [[zJxsLeftMenu alloc]init];
        _leftMenu.menutapBack = ^(NSInteger index) {
//            [weakSelf.menuTableView reloadData];
            
            zBusinessLoactionModel * model = weakSelf.menuListArray[index];
            if (model.select) {
                [weakSelf.addLocationArray removeObject:@(model.cityid)];
            }else
            {
                [weakSelf.addLocationArray addObject:@(model.cityid)];
            }
            model.select = !model.select;
            weakSelf.leftMenu.menuArray = weakSelf.menuListArray;
            [weakSelf refreshData];
        };
    }
    return _leftMenu;
}

-(UITableView*)menuTableView
{
    if (!_menuTableView) {
        _menuTableView  = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _menuTableView.backgroundColor = [UIColor clearColor];
        _menuTableView.delegate = self;
        _menuTableView.dataSource = self;
        _menuTableView.allowsSelection = YES;
        _menuTableView.estimatedRowHeight = kWidthFlot(44);
        _menuTableView.estimatedSectionHeaderHeight = 2;
        _menuTableView.estimatedSectionFooterHeight = 2;
        _menuTableView.showsVerticalScrollIndicator = NO;
        _menuTableView.rowHeight = UITableViewAutomaticDimension;
        _menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _menuTableView.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        _menuTableView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
    return _menuTableView;
}
-(NSMutableDictionary*)listParmas
{
    if (!_listParmas) {
        _listParmas = [NSMutableDictionary dictionary];
        [_listParmas setObject:@(2) forKey:@"code"];
        [_listParmas setObject:@(20) forKey:@"limit"];
        [_listParmas setObject:@(1) forKey:@"page"];
        [_listParmas setObject:@"" forKey:@"typeIds"];
        [_listParmas setObject:@"" forKey:@"searchData"];
    }
    return _listParmas;
}

-(NSMutableArray*)contentListArray
{
    if (!_contentListArray) {
        _contentListArray = [NSMutableArray array];
    }
    return _contentListArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.leftMenu];
    [self.view addSubview:self.menuTableView];
//    self.nothingView.alpha = 1;
    [self.view bringSubviewToFront:self.nothingView];
}

-(void)loadMenuList
{
    __weak typeof(self)weakSelf = self;
   NSString * url = [NSString stringWithFormat:@"%@%@",kApiPrefix,kGetBusinessManLocationList];
   self.noContentView.retryTapBack = ^{
       [weakSelf postDataWithUrl:url WithParam:nil];
       [weakSelf loadList];
   };
   [self postDataWithUrl:url WithParam:nil];
}

-(void)loadList
{
//    NSString * listurl = [NSString stringWithFormat:@"%@%@",kApiPrefix,];
    
    [self requestPostWithUrl:kGetMyBusinessManList paraString:self.listParmas success:^(id  _Nonnull response) {
        [[zHud shareInstance]hild];
        NSString * code = response[@"code"];
        if ([code integerValue] == 0) {
            NSDictionary * dic = response[@"page"];
            NSLog(@"货源列表%@",dic);
            NSArray * list = dic[@"list"];
            [self.menuTableView.mj_header endRefreshing];
            if (list.count==0) {
                if (self.currentPage == 1) {
                    self.nothingView.alpha =1;
                    [self.view bringSubviewToFront:self.nothingView];
                }else
                {
                    [self.menuTableView.mj_footer endRefreshingWithNoMoreData];
                }
            }else
            {
                if (list.count<20) {
                    [self.menuTableView.mj_footer endRefreshingWithNoMoreData];
                    [self.menuTableView.mj_footer setHidden:YES];
                }else
                {
                    [self.menuTableView.mj_footer endRefreshing];
                }
                if (self.currentPage == 1) {
                    [self.contentListArray removeAllObjects];
                }
                self.nothingView.alpha =0;
                [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary * dic = list[idx];
                    zGoodsContentModel * model = [zGoodsContentModel mj_objectWithKeyValues:dic];
                    [self.contentListArray addObject:model];
                }];
                [self.menuTableView reloadData];
            }
            
        }else
        {
            NSString * msg =response[@"msg"];
            [[zHud shareInstance]showMessage:msg];
        }
    } failure:^(NSError * _Nonnull error) {
        [[zHud shareInstance]hild];
    }];
    
//    [self postDataWithUrl:listurl WithParam:self.listParmas];
    [[zHud shareInstance]show];
}

-(void)refreshData
{
    [_listParmas setObject:@(1) forKey:@"page"];
    NSString * citys = [self.addLocationArray componentsJoinedByString:@","];
    [_listParmas setObject:citys forKey:@"typeIds"];
    [self loadList];
}

-(void)loadMoreData
{
    self.currentPage ++ ;
    [_listParmas setObject:@(self.currentPage) forKey:@"page"];
    [self loadList];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.leftMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
        make.width.mas_equalTo(kWidthFlot(150));
    }];
    [self.menuTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftMenu.mas_right).offset(0);
       make.top.mas_equalTo(0);
       make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
       make.right.mas_equalTo(0);
    }];
    [self.nothingView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftMenu.mas_right).offset(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
        make.right.mas_equalTo(0);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contentListArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    zHuoYuanListCell * cell = [zHuoYuanListCell instanceWithTableView:tableView AndIndexPath:indexPath];
    zGoodsContentModel * model =  self.contentListArray[indexPath.row];
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    zGoodsContentModel * model =  self.contentListArray[indexPath.row];
    zCompanyDetailController * detailVC = [[zCompanyDetailController alloc]init];
    detailVC.title = @"公司详情";
    detailVC.goosModel = model;
    detailVC.type = 1;
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(void)RequsetFileWithUrl:(NSString*)url WithError:(NSError*)err
{
    self.noContentView.alpha = 1;
    [self.view bringSubviewToFront:self.noContentView];
    
    if ([url containsString:kGetBusinessManLocationList]) {
        [[zHud shareInstance]hild];
        if (err.code == -1001) {
            [[zHud shareInstance] showMessage:@"无法连接服务器"];
            
        }
    }

    if ([url containsString:kGetMyBusinessManList]) {
        [[zHud shareInstance]hild];
        if (err.code == -1001) {
            [[zHud shareInstance] showMessage:@"无法连接服务器"];
        }
    }
}



-(void)RequsetSuccessWithData:(id)data AndUrl:(NSString*)url
{
    self.noContentView.alpha = 0;
    if ([url containsString:kGetBusinessManLocationList]) {
        NSDictionary * dic = data[@"data"];
        NSString * code = data[@"code"];
        if ([code integerValue] == 0) {
            NSArray * treeList = dic[@"treeListAddress"];
            NSMutableArray * citysArray = [NSMutableArray array];
            
            [treeList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary * dic = treeList[idx];
                
                zBusinessLoactionModel * model = [zBusinessLoactionModel mj_objectWithKeyValues:dic];
                [citysArray addObject:model];
            }];
            self.menuListArray = citysArray;
            self.leftMenu.menuArray = self.menuListArray;
        }
        
    }
}

@end
