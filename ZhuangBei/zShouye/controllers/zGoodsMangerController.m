//
//  zGoodsMangerController.m
//  ZhuangBei
//
//  Created by aa on 2020/5/5.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zGoodsMangerController.h"
#import "zShouYeLeftMenu.h"
#import "zHuoYuanListCell.h"
#import "zGoodsMenuModel.h"
#import "zGoodsContentModel.h"
#import "zCompanyDetailController.h"


@interface zGoodsMangerController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView * menuTableView;

@property(strong,nonatomic)zShouYeLeftMenu * leftMenu;

@property(assign,nonatomic)NSInteger currentPage;

@property(strong,nonatomic)NSMutableArray * menuListArray;

@property(strong,nonatomic)NSMutableArray * contentListArray;

@property(strong,nonatomic)NSMutableDictionary * listParmas;

@end

@implementation zGoodsMangerController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.showNav) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    [self loadMenuList];
    [self loadList];
}

-(NSMutableDictionary*)listParmas
{
    if (!_listParmas) {
        _listParmas = [NSMutableDictionary dictionary];
        [_listParmas setObject:@(3) forKey:@"code"];
        [_listParmas setObject:@(20) forKey:@"limit"];
        [_listParmas setObject:@(1) forKey:@"page"];
        [_listParmas setObject:@"" forKey:@"lastNode"];
        [_listParmas setObject:@"" forKey:@"zbid"];
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

-(zShouYeLeftMenu*)leftMenu
{
    if (!_leftMenu) {
        __weak typeof(self)weakSelf = self;
        _leftMenu = [[zShouYeLeftMenu alloc]init];
        _leftMenu.menutapBack = ^(NSInteger index) {
//            [weakSelf.menuTableView reloadData];
        };
        _leftMenu.menuSelectBack = ^(zGoodsMenuModel *goodsModel) {
            weakSelf.listParmas = nil;
            [weakSelf.listParmas setObject:@(goodsModel.typeId) forKey:@"zbid"];
            if (goodsModel.lastNode != nil) {
                [weakSelf.listParmas setObject:goodsModel.lastNode forKey:@"lastNode"];
            }
            [weakSelf loadList];
        };
    }
    return _leftMenu;
}

-(UITableView*)menuTableView
{
    if (!_menuTableView) {
        _menuTableView  = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _menuTableView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.leftMenu];
    [self.view addSubview:self.menuTableView];

}

-(void)loadMenuList
{
    __weak typeof(self)weakSelf = self;
   NSString * url = [NSString stringWithFormat:@"%@%@",kApiPrefix,kGoodsMangerMenu];
   self.noContentView.retryTapBack = ^{
       [weakSelf postDataWithUrl:url WithParam:nil];
       [weakSelf loadList];
   };
   [self postDataWithUrl:url WithParam:nil];
}

-(void)loadList
{
//    NSString * listurl = [NSString stringWithFormat:@"%@%@",kApiPrefix,];
    
    [self requestPostWithUrl:kGoodsMangerList paraString:self.listParmas success:^(id  _Nonnull response) {
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
                [self.contentListArray removeAllObjects];
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
    [[zHud shareInstance]show];
}

-(void)refreshData
{
    [_listParmas setObject:@(1) forKey:@"page"];
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    zGoodsContentModel * model =  self.contentListArray[indexPath.row];
    zCompanyDetailController * detailVC = [[zCompanyDetailController alloc]init];
    detailVC.title = @"公司详情";
    detailVC.goosModel = model;
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(void)RequsetFileWithUrl:(NSString*)url WithError:(NSError*)err
{
    self.noContentView.alpha = 1;
    [self.view bringSubviewToFront:self.noContentView];
    
    if ([url containsString:kGoodsMangerMenu]) {
        [[zHud shareInstance]hild];
        if (err.code == -1001) {
            [[zHud shareInstance] showMessage:@"无法连接服务器"];
            
        }
    }

    if ([url containsString:kGoodsMangerList]) {
        [[zHud shareInstance]hild];
        if (err.code == -1001) {
            [[zHud shareInstance] showMessage:@"无法连接服务器"];
        }
    }
}



-(void)RequsetSuccessWithData:(id)data AndUrl:(NSString*)url
{
    self.noContentView.alpha = 0;
    if ([url containsString:kGoodsMangerMenu]) {
        NSDictionary * dic = data[@"data"];
        NSString * code = data[@"code"];
        if ([code integerValue] == 0) {
            NSArray * treeList = dic[@"treeList"];
            NSMutableArray * firstArray = [NSMutableArray array];
            [treeList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                //遍历一级数组
                NSDictionary * dic =treeList[idx];
                zGoodsMenuModel * model = [zGoodsMenuModel mj_objectWithKeyValues:dic];
                model.indexSection = idx;
                NSMutableArray * secondArray = [NSMutableArray array];
                [model.children enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger jdx, BOOL * _Nonnull stop) {
                    //遍历二级数组
                    NSDictionary * sedondDic = model.children[jdx];
                    zGoodsMenuModel * secondModel = [zGoodsMenuModel mj_objectWithKeyValues:sedondDic];
                    secondModel.indexSection = jdx;
                    NSMutableArray * thirdArray = [NSMutableArray array];
                    [secondModel.children enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger zdx, BOOL * _Nonnull stop) {
                        //遍历数组
                        NSDictionary * thirdDic = secondModel.children[zdx];
                        zGoodsMenuModel * thirdModel = [zGoodsMenuModel mj_objectWithKeyValues:thirdDic];
                        thirdModel.indexSection = zdx;
                        [thirdArray addObject:thirdModel];
                    }];
                    secondModel.children = thirdArray;
                    
                    [secondArray addObject:secondModel];
                }];
                model.children = secondArray;
                [firstArray addObject:model];
            }];
            self.menuListArray = firstArray;
            self.leftMenu.menuArray = self.menuListArray;
            NSLog(@"获取货源管理目录%@",firstArray);
        }
        
    }
//    if ([url containsString:kGoodsMangerList]) {
//        [[zHud shareInstance]hild];
//
//    }
}


@end
