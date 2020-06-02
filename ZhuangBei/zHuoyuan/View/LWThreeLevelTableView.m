//
//  LWThreeLevelTableView.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/11.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWThreeLevelTableView.h"
#import "LWHuoYuanThreeLevelListTableViewCell.h"
#import "LWGongYingShangListViewController.h"
#import "LWHuoYuanDeatilViewController.h"

@implementation LWThreeLevelTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
            self.delegate = self;
             self.dataSource = self;
             self.rowHeight = 230;
             [self registerClass:[LWHuoYuanThreeLevelListTableViewCell class] forCellReuseIdentifier:@"LWHuoYuanThreeLevelListTableViewCell"];
             self.backgroundColor = UIColor.whiteColor;
             self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

-(void)setSourceVc:(UIViewController *)sourceVc
{
    _sourceVc = sourceVc;
    self.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:_sourceVc refreshingAction:@selector(requestDatas)];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self endTableViewCellEdit];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWHuoYuanThreeLevelListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWHuoYuanThreeLevelListTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model  = self.listDatas[indexPath.row];
    WEAKSELF(self)
    cell.clickItemsBlock = ^(gysListModel * _Nonnull itemmodel) {
        [weakself handlerCellEnvent:itemmodel indexpath:indexPath];
    };
    cell.editBlock = ^(BOOL editing) {
        if (editing) {
            if (weakself.lastEditingIndex > 0) {
                LWHuoYuanThreeLevelListTableViewCell *cell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:weakself.lastEditingIndex -1 inSection:0]];
                cell.isEditing = NO;
            }
            weakself.lastEditingIndex = indexPath.row+1;
        }
    };
    return  cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.listDatas.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self handlerCellEnvent:nil indexpath:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

//结束cell的编辑状态
- (void)endTableViewCellEdit
{
    if (self.lastEditingIndex > 0) {
        LWHuoYuanThreeLevelListTableViewCell *cell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.lastEditingIndex -1 inSection:0]];
        cell.isEditing = NO;
        self.lastEditingIndex = 0;
    }
}

//cell上的s点击事件处理
- (void)handlerCellEnvent:(gysListModel *)itemmodel indexpath:(NSIndexPath *)indexPath
{
    if (itemmodel) {
        LWHuoYuanDeatilViewController *vc = [LWHuoYuanDeatilViewController new];
        LWHuoYuanThreeLevelModel *model = self.listDatas[indexPath.row];
        vc.gongYingShangDm = itemmodel.customId;
        vc.zhuangBeiDm = model.zbId;
        vc.zhuangBeiLx = model.zblxId;
        vc.zhuangBeiName = model.zbName;
        [self.sourceVc.navigationController pushViewController:vc animated:YES];
    }else{
        LWHuoYuanThreeLevelModel *model = self.listDatas[indexPath.row];
        LWGongYingShangListViewController *vc = [LWGongYingShangListViewController new];
        vc.zbTypeId = model.zblxId;
        vc.zbId = model.zbId;
        [self.sourceVc.navigationController pushViewController:vc animated:YES];
    }
}
@end
