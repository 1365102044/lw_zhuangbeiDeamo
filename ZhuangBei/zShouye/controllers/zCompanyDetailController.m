//
//  zCompanyDetailController.m
//  ZhuangBei
//
//  Created by aa on 2020/5/8.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zCompanyDetailController.h"
#import "zCompanyDetailCell.h"
#import "zCompanyHeader.h"
#import "zCompanyGoodsCell.h"
#import "zCompanyGoodsModel.h"
#import "LWHuoYuanDeatilViewController.h"

@interface zCompanyDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView * companyTable;

@property(assign,nonatomic)NSInteger companyType;//0 企业详情 1货源详情

@property(strong,nonatomic)NSMutableArray * goodsListArray;//公司货源

@end

@implementation zCompanyDetailController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(NSMutableArray*)goodsListArray
{
    if (!_goodsListArray) {
        _goodsListArray = [NSMutableArray array];
    }
    return _goodsListArray;
}

-(UITableView*)companyTable
{
    if (!_companyTable) {
        _companyTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _companyTable.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        _companyTable.delegate = self;
        _companyTable.dataSource = self;
        _companyTable.estimatedRowHeight = 100;
        _companyTable.showsVerticalScrollIndicator = NO;
        _companyTable.rowHeight = UITableViewAutomaticDimension;
        _companyTable.sectionHeaderHeight =UITableViewAutomaticDimension;
        _companyTable.estimatedSectionHeaderHeight = 2;
        _companyTable.estimatedSectionFooterHeight = 2;
        _companyTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _companyTable;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.companyType = 0;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    [self.view addSubview:self.companyTable];
    [self getCompanyGoodsList];
    
}



-(void)getCompanyGoodsList
{
    NSDictionary * dic = @{@"gysId":@(self.goosModel.goodsid),
                           @"limit":@(20),
                           @"page":@(1)
    };
    
    [self requestPostWithUrl:kGetCompanyGoodsList paraString:dic success:^(id  _Nonnull response) {
        [[zHud shareInstance]hild];
        NSString * code = response[@"code"];
        if ([code integerValue] == 0) {
            NSDictionary * dic = response[@"page"];
            NSLog(@"货源列表%@",dic);
            NSArray * list = dic[@"list"];
            if (list.count==0) {
//                self.nothingView.alpha =1;
//                [self.view bringSubviewToFront:self.nothingView];
            }else
            {
                self.nothingView.alpha =0;
                [self.goodsListArray removeAllObjects];
                [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary * dic = list[idx];
                    zCompanyGoodsModel * model = [zCompanyGoodsModel mj_objectWithKeyValues:dic];
                    [self.goodsListArray addObject:model];
                }];
                [self.companyTable reloadData];
            }
            
        }else
        {
            NSString * msg =response[@"msg"];
            [[zHud shareInstance]showMessage:msg];
        }
    } failure:^(NSError * _Nonnull error) {
        [[zHud shareInstance]hild];
    }];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.companyTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
    }];
}

-(void)setGoosModel:(zGoodsContentModel *)goosModel
{
    _goosModel = goosModel;
}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.companyType == 0) {
        return 1;
    }else
    {
        return self.goodsListArray.count;
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.companyType == 0) {
        zCompanyDetailCell * cell = [zCompanyDetailCell instanceWithTableView:tableView AndIndexPath:indexPath];
        cell.typesArray = @[];
        cell.goosModel = _goosModel;
        return cell;
    }else
    {
        zCompanyGoodsCell * cell = [zCompanyGoodsCell instanceWithTableView:tableView AndIndexPath:indexPath];
        zCompanyGoodsModel * model = self.goodsListArray[indexPath.row];
        cell.goosModel = model;
        return cell;
    }
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    __weak typeof(self)weakSelf = self;
    zCompanyHeader * companyHeader = [[zCompanyHeader alloc]init];
    companyHeader.headerSlideBack = ^(NSInteger index) {
        weakSelf.companyType = index;
        [UIView performWithoutAnimation:^{
//            NSIndexPath * indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
           [self.companyTable reloadSection:0 withRowAnimation:UITableViewRowAnimationNone];
        }];
    };
    companyHeader.type = self.type;
    companyHeader.goosModel = _goosModel;
    companyHeader.companyType = self.companyType;
    return companyHeader;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.companyType==0) {
        
    }else
    {
        zCompanyGoodsModel * model = self.goodsListArray[indexPath.row];
        LWHuoYuanDeatilViewController * goodsDetailVC = [[LWHuoYuanDeatilViewController alloc]init];
        goodsDetailVC.title = @"货源详情";
//        goodsDetailVC.modelId = [NSString stringWithFormat:@"%ld",model.zbType];
        goodsDetailVC.gongYingShangDm = [NSString stringWithFormat:@"%ld",model.gysId];
        goodsDetailVC.zhuangBeiDm = [NSString stringWithFormat:@"%ld",model.zbId];
        goodsDetailVC.zhuangBeiLx = [NSString stringWithFormat:@"%ld",model.zbType];
       NSString * zbName =  [model.zbName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        goodsDetailVC.zhuangBeiName = zbName;
        [self.navigationController pushViewController:goodsDetailVC animated:YES];
    }
}

@end
