//
//  LWHuoYuanThreeLevelListTableViewCell.m
//  ZhuangBei
//
//  Created by LWQ on 2020/4/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWHuoYuanThreeLevelListTableViewCell.h"

@interface LWHuoYuanThreeLevelListTableViewCell ()
@property (nonatomic, strong) UIImageView * goodsIv;
@property (nonatomic, strong) UILabel * goodsNameL;
@property (nonatomic, strong) UILabel * goodsDescL;
@property (nonatomic, strong) UIView * itemsBgView;
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIView * rightContextView;
@property (nonatomic, assign) CGFloat  lastOffsetX;
@end
@implementation LWHuoYuanThreeLevelListTableViewCell

- (void)clickItemsView:(UITapGestureRecognizer *)tap
{
    if(tap.view.tag == 100){
        if(self.clickItemsBlock){
            self.clickItemsBlock(nil);
        }
        return;
    }
    gysListModel *model = _model.gysList[tap.view.tag];
    if(self.clickItemsBlock){
        self.clickItemsBlock(model);
    }
}

- (void)clickMoreBtn
{
    if(self.clickItemsBlock){
               self.clickItemsBlock(nil);
           }
}

- (void)setModel:(LWHuoYuanThreeLevelModel *)model
{
    _model = model;
    _goodsNameL.text = model.zbName;
    _goodsDescL.text = [NSString stringWithFormat:@"%@>%@",model.zblxPName,model.zblxName];
    NSMutableArray *items = [[NSMutableArray alloc] init];
    //    NSMutableArray *itemsModelArr= [[NSMutableArray alloc] init];
    for (gysListModel *itemmodel in model.gysList) {
        if(!itemmodel.companyNameSecond || !itemmodel.companyNameFirst) break;
        if (items.count >= 4)  break;
        [items addObject:[NSString stringWithFormat:@"%@%@",itemmodel.companyNameFirst,itemmodel.companyNameSecond]];
        //        [itemsModelArr addObject:itemmodel];
    }
    [self.itemsBgView removeAllSubviews];
    self.itemsBgView.userInteractionEnabled = YES;
    NSMutableArray *lables = [NSMutableArray array];
    for (int i = 0; i<items.count; i++) {
        UIView *itemview = [self lineView:items[i] tag:i];
        [self.itemsBgView addSubview:itemview];
        [itemview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.mas_equalTo(self.itemsBgView);
            if (lables.count == 0) {
                make.top.mas_equalTo(self.itemsBgView.mas_top).mas_offset(8);
            }else{
                UIView *lastview = lables.lastObject;
                make.top.mas_equalTo(lastview.mas_bottom).mas_offset(6);
            }
            if (items.count - 1 == i) {
                make.bottom.mas_equalTo(self.itemsBgView.mas_bottom);
            }
        }];
        [lables addObject:itemview];
    }
    [self.goodsIv z_imageWithImageId:model.imgId];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self confiCellUI];
    }
    return self;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat maxX = 90;
    CGPoint offest = scrollView.contentOffset;
    if(offest.x < 0) {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        [scrollView setBounces:NO];
        return;
    }
    [scrollView setBounces:YES];
    if (offest.x< 40) {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        self.isEditing = NO;
    }else {
        [scrollView setContentOffset:CGPointMake(maxX, 0) animated:NO];
        self.isEditing = YES;
    }
//        if (_lastOffsetX > offest.x) {
//        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
//        _lastOffsetX = 0;
//        return;
//    }
//    if (_lastOffsetX < offest.x && offest.x >= 40) {
//        [scrollView setContentOffset:CGPointMake(maxX, 0) animated:NO];
//        self.isEditing = YES;
//    }
//    if ( 0 <= offest.x && offest.x <= 90) {
//        _lastOffsetX = offest.x;
//    }
}


-(void)setIsEditing:(BOOL)isEditing
{
    if (!isEditing) {
          [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
      }
    if (_isEditing != isEditing) {
        _isEditing = isEditing;
        if (self.editBlock) {
            self.editBlock(_isEditing);
        }
    }
}

- (void)confiCellUI
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, 230)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self.contentView addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
        make.width.mas_offset(SCREEN_WIDTH-20);
    }];
    _scrollView.backgroundColor = UIColor.whiteColor;
    _goodsIv = [UIImageView new];
    _goodsNameL = [UILabel new];
    _goodsDescL = [UILabel new];
    
    UIView *leftContextView = [UIView new];
    leftContextView.backgroundColor = UIColor.whiteColor;
    [_scrollView addSubview:self.rightContextView];
    [_scrollView addSubview:leftContextView];
    [leftContextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.mas_equalTo(_scrollView);
        make.width.mas_offset(SCREEN_WIDTH-20);
        make.height.mas_offset(210);
    }];
    [self.rightContextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(_scrollView);
        make.left.mas_equalTo(leftContextView.mas_right).mas_offset(-10);
        make.width.mas_offset(100);
        make.height.mas_offset(210);
    }];
    
    
    UIImageView *moreBg = [UIImageView new];
    moreBg.image = IMAGENAME(@"morebgicon");
    UIButton *morebtn = [UIButton new];
    [morebtn setTitle:@"查看全部" forState:UIControlStateNormal];
    [morebtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [morebtn addTarget:self action:@selector(clickMoreBtn) forControlEvents:UIControlEventTouchUpInside];
    _goodsIv.image = IMAGENAME(@"testicon");
    _goodsNameL.text = @"防弹插板";
    _goodsNameL.font = kFont(16);
    _goodsDescL.text = @"特巡装备/软件>特警单警防护";
    _goodsDescL.font = kFont(13);
    _goodsDescL.textColor = UIColor.grayColor;
    morebtn.backgroundColor = UIColor.clearColor;
    morebtn.titleLabel.font = kFont(14);
    [leftContextView addSubviews:@[_goodsIv,_goodsNameL,_goodsDescL,moreBg,morebtn]];
    [_goodsIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(110);
        make.height.mas_offset(110);
        make.top.mas_equalTo(leftContextView).mas_offset(20);
        make.left.mas_equalTo(leftContextView.mas_left).mas_offset(15);
    }];
    [_goodsNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_goodsIv.mas_left);
        make.right.mas_equalTo(leftContextView.mas_right).mas_offset(-10);
        make.top.mas_equalTo(_goodsIv.mas_bottom).mas_offset(20);
    }];
    [_goodsDescL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_goodsIv.mas_left);
        make.right.mas_equalTo(_goodsNameL.mas_right);
        make.top.mas_equalTo(_goodsNameL.mas_bottom).mas_offset(10);
    }];
    
    [moreBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(100);
        make.height.mas_offset(30);
        make.right.mas_equalTo(leftContextView.mas_right).mas_offset(-0);
        make.top.mas_equalTo(leftContextView.mas_top).mas_offset(5);
    }];
    [morebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(100);
        make.height.mas_offset(30);
        make.centerY.mas_equalTo(moreBg.mas_centerY);
        make.centerX.mas_equalTo(moreBg.mas_centerX);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self).mas_offset(10);
        make.bottom.mas_equalTo(self).mas_offset(-10);
        make.right.mas_equalTo(self).mas_offset(-10);
        make.width.mas_offset(SCREEN_WIDTH-20);
    }];
    [leftContextView setBoundWidth:1 cornerRadius:10 boardColor:BASECOLOR_BOARD];
    [self.contentView setBoundWidth:1 cornerRadius:10 boardColor:BASECOLOR_BOARD];
//    [self.goodsIv setBoundWidth:0.5 cornerRadius:0 boardColor:BASECOLOR_BOARD];
    [self.scrollView setBoundWidth:1 cornerRadius:10 boardColor:BASECOLOR_BOARD];
    
    self.itemsBgView = [UIView new];
    self.itemsBgView.userInteractionEnabled = YES;
    [leftContextView addSubview:self.itemsBgView];
    [self.itemsBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_goodsIv.mas_right).mas_offset(20);
        make.right.mas_equalTo(leftContextView.mas_right).mas_offset(-10);
        make.top.mas_equalTo(moreBg.mas_bottom).mas_offset(0);
    }];
    self.contentView.tag = 100;
    [self.contentView ex_addTapAction:self selector:@selector(clickItemsView:)];
}

- (UIView *)lineView:(NSString *)text tag:(NSInteger)tag
{
    UIView *bg = [UIView new];
    UIView *des1 = [UIView new];
    UIView *des2 = [UIView new];
    des1.backgroundColor = UIColor.blueColor;
    des2.backgroundColor = UIColor.blueColor;
    des2.alpha = 0.3;
    [bg addSubviews:@[des2,des1]];
    [des1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(2);
        make.height.mas_offset(20);
        make.left.mas_equalTo(bg);
        make.centerY.mas_equalTo(bg.mas_centerY);
    }];
    [des2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(1);
        make.height.mas_offset(20);
        //        make.top.bottom.mas_equalTo(bg);
        make.left.mas_equalTo(des1.mas_right).mas_offset(2);
        //        make.right.mas_equalTo(bg.mas_right);
        make.centerY.mas_equalTo(bg.mas_centerY);
    }];
    UILabel *lable = [LWLabel lw_lable:@"" font:14 textColor:BASECOLOR_TEXTCOLOR];
    [bg addSubview:lable];
    bg.tag = tag;
    lable.text = text;
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(des2.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(bg.mas_centerY);
        make.right.mas_equalTo(bg.mas_right);
        make.top.bottom.mas_equalTo(bg);
    }];
    [bg ex_addTapAction:self selector:@selector(clickItemsView:)];
    return bg;
}

- (UIView *)rightContextView
{
    if (!_rightContextView) {
        _rightContextView = [[UIView alloc] init];
        UILabel *alll = [LWLabel lw_lable:@"查看全部" font:16 textColor:BASECOLOR_TEXTCOLOR];
        [_rightContextView addSubview:alll];
        [alll mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.mas_equalTo(_rightContextView);
            make.left.mas_equalTo(_rightContextView.mas_left).mas_offset(10);
        }];
        alll.textAlignment = NSTextAlignmentCenter;
        _rightContextView.tag = 100;
        [_rightContextView ex_addTapAction:self selector:@selector(clickItemsView:)];
    }
    return _rightContextView;
}
@end
