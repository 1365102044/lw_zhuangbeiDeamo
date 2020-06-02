//
//  zShouYeLeftMenu.m
//  ZhuangBei
//
//  Created by aa on 2020/5/5.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zShouYeLeftMenu.h"
#import "zLeftMenuHeader.h"
#import "zLeftMenuCell.h"
#import "zHuoYuanModel.h"



@interface zShouYeLeftMenu ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView * menuTableView;

@end

@implementation zShouYeLeftMenu

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
    }
    return _menuTableView;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
        [self addSubview:self.menuTableView];
        [self updateConstraintsForView];
    }
    return self;
}

-(void)updateConstraintsForView
{
    [self.menuTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.menuArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   zGoodsMenuModel * model =  self.menuArray[section];
    if (model.select==YES) {
        return model.children.count;
    }
   return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    zLeftMenuCell * cell = [zLeftMenuCell instanceWithTableView:tableView AndIndexPath:indexPath];
    cell.menuSelectBack = ^(zGoodsMenuModel * _Nonnull goodsModel) {
        if (weakSelf.menuSelectBack) {
            weakSelf.menuSelectBack(goodsModel);
        }
    };
    zGoodsMenuModel * model =  self.menuArray[indexPath.section];
    zGoodsMenuModel * secondModel = model.children[indexPath.row];
    cell.goodsModel =  secondModel;
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    __weak typeof(self)weakSelf = self;
    zLeftMenuHeader * header = [[zLeftMenuHeader alloc]init];
    header.menuHeaerTapBack = ^(zGoodsMenuModel * _Nonnull hymodel) {
        zGoodsMenuModel * model = weakSelf.menuArray[hymodel.indexSection];
        model.select = !model.select;
        if (weakSelf.menuSelectBack) {
            weakSelf.menuSelectBack(model);
        }
        [UIView performWithoutAnimation:^{
            [weakSelf.menuTableView reloadData];
        }];
    };
    header.hyModel = self.menuArray[section];
    return header;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    zGoodsMenuModel * model =  self.menuArray[indexPath.section];
    zGoodsMenuModel * secondModel = model.children[indexPath.row];
    secondModel.select = !secondModel.select;
    [UIView performWithoutAnimation:^{
        [weakSelf.menuTableView reloadData];
    }];
}

-(void)setMenuArray:(NSArray *)menuArray
{
    _menuArray = menuArray;
    [self.menuTableView reloadData];
}


@end
