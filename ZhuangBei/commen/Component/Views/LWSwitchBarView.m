//
//  LWSwitchBarView.m
//  ZhuangBei
//
//  Created by LWQ on 2020/4/27.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWSwitchBarView.h"

@interface LWSwitchBarView ()

@property (nonatomic, strong) NSArray * itemsDataList;
@property (nonatomic, copy) clickBlock  callBlock;
@property (nonatomic, assign) NSInteger  lastIndex;
@property (nonatomic, strong) NSMutableArray<UIButton *> *itembtns;

@end

@implementation LWSwitchBarView

/// 初始化静态方法
/// @param items 显示的item数组
/// @param callBlock 点击事件回调（UIButton）
+ (instancetype)switchBarView:(NSArray *)items clickBlock:(clickBlock)callBlock
{
    LWSwitchBarView *instace = [[LWSwitchBarView alloc] init];
    instace.itemsDataList = items;
    instace.callBlock = callBlock;
    [instace confiUI];
    return instace;
}

- (void)clickBtnItem:(UIButton *)sender
{
    if (self.callBlock) {
        self.callBlock(sender);
    }
    if (sender.tag == _lastIndex) {
        return;
    }
    _currentIndex = sender.tag;
    _itembtns[_lastIndex].selected = NO;
    _itembtns[_currentIndex].selected = YES;
    _lastIndex = _currentIndex;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        _itemsDataList = @[@"消息",@"联系人",@"群组"];
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

- (void)confiUI
{
    _currentIndex = _lastIndex = 0;
    NSMutableArray *itembtns = [[NSMutableArray alloc] initWithCapacity:_itemsDataList.count];
    for (int i = 0; i< _itemsDataList.count; i++) {
        UIButton *itembtn = [UIButton new];
        [itembtn setTitle:_itemsDataList[i] forState:UIControlStateNormal];
        [itembtn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
        [itembtn setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
        [itembtn setBackgroundImage:[UIImage imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
        [itembtn setBackgroundImage:[UIImage imageWithColor:UIColor.whiteColor] forState:UIControlStateHighlighted];
        [itembtn setBackgroundImage:[UIImage imageWithColor:BASECOLOR_BLUECOLOR] forState:UIControlStateSelected];
        [itembtn setBoundWidth:0 cornerRadius:18];
        itembtn.tag = i;
        [itembtn addTarget:self action:@selector(clickBtnItem:) forControlEvents:UIControlEventTouchUpInside];
        itembtn.selected = i == 0;
        [itembtns addObject:itembtn];
    }
    _itembtns = itembtns;
    
    [self addSubviews:itembtns];
    [itembtns mas_distributeViewsAlongAxis:(MASAxisTypeHorizontal) withFixedSpacing:10 leadSpacing:0 tailSpacing:0];
    [itembtns mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset(0);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-0);
        make.width.greaterThanOrEqualTo(@(70*_itemsDataList.count)).priorityHigh();
    }];
    //    [self setBoundWidth:1 cornerRadius:20 boardColor:UIColor.grayColor];
    //    [self ex_addSingleShadowWithColor];
    
    self.layer.cornerRadius=18;
    self.layer.shadowColor=[UIColor blackColor].CGColor;
    self.layer.shadowOffset=CGSizeMake(0, 0);
    self.layer.shadowOpacity=0.2;
    self.layer.shadowRadius=5;
}

-(void)setSelectIndex:(NSInteger)selectIndex
{
    if(selectIndex > _itembtns.count - 1) return;
    _selectIndex = selectIndex;
    _currentIndex = _selectIndex;
    UIButton *item = self.itembtns[_selectIndex];
    [self clickBtnItem:item];
}

@end
