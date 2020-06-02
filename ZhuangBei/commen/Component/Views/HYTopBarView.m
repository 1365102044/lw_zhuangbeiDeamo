//
//  HYTopBarView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/28.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYTopBarView.h"
#import "LWButton.h"

@interface HYTopBarView ()
@property (nonatomic, strong) NSArray * dataArr;
@property (nonatomic, strong) UIView * lineView;
@property (nonatomic, strong) NSMutableArray * btnArr;
@property (nonatomic, strong) UIScrollView * backView;
@property (nonatomic, strong) UIColor * selectColor;
@property (nonatomic, strong) UIButton * lastSelectBtn;
@property (nonatomic, copy) callBackBlock callBackBlock;

@end

@implementation HYTopBarView
+ (instancetype)creatTopBarWithDataArr:(NSArray *)dataArr selectColor:(UIColor *)selectColor lineStyle:(TopBarLineStyle)lineStyle callBack:(callBackBlock)callBackBlock;
{
    HYTopBarView *instance = [HYTopBarView creatTopBarWithDataArr:dataArr selectColor:selectColor callBack:callBackBlock];
    instance.lineStyle = lineStyle;
    return instance;
}
+ (instancetype)creatTopBarWithDataArr:(NSArray *)dataArr selectColor:(UIColor *)selectColor callBack:(callBackBlock)callBackBlock
{
    HYTopBarView *temp = [[HYTopBarView alloc] init];
    temp.dataArr = dataArr;
    temp.selectColor = selectColor;
    temp.callBackBlock = callBackBlock;
    [temp setUI];
    return temp;
}

- (void)setUI
{
    self.backgroundColor = UIColor.whiteColor;
    self.btnArr = [NSMutableArray array];
    if (self.dataArr.count == 0) {
        return;
    }
    
    [self addSubview:self.backView];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(0);
    }];
//    CGFloat Items_W = (SCREEN_WIDTH - (_dataArr.count - 1) * 10 - 10 *4)/(_dataArr.count);
    CGFloat Items_W = 100;
    
    _backView.contentSize = CGSizeMake(Items_W * _dataArr.count , 1);
//    _backView.backgroundColor = UIColor.redColor;
    CGFloat left = ((SCREEN_WIDTH - Items_W*_dataArr.count) - 30)/2;
    for (int i = 0 ; i<self.dataArr.count; i++) {
        LWButton *btn = [LWButton lw_button:self.dataArr[i] font:18 textColor:BASECOLOR_TEXTCOLOR backColor:UIColor.whiteColor target:self acction:@selector(clickBtn:)];

        [_backView addSubview:btn];
        btn.tag = i;
        [self.btnArr addObject:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_backView.mas_left).mas_offset(Items_W * i + i * 10 + left);
            make.top.mas_equalTo(_backView.mas_top).mas_offset((8));
            make.width.mas_offset(Items_W);
            make.bottom.mas_equalTo(_backView.mas_bottom).mas_offset(-2);
        }];
    }
//    [self.btnArr mas_distributeViewsAlongAxis:(MASAxisTypeHorizontal) withFixedItemLength:150 leadSpacing:10 tailSpacing:10];
//    [self.btnArr mas_distributeViewsAlongAxis:(MASAxisTypeHorizontal) withFixedSpacing:10 leadSpacing:0 tailSpacing:0];
//     [self.btnArr mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_backView.mas_top).mas_offset((8));
//        make.bottom.mas_equalTo(_backView.mas_bottom).mas_offset(-2);
//    }];
    self.lastSelectBtn = self.btnArr.firstObject;
    [self.lastSelectBtn setTitleColor:_selectColor forState:UIControlStateNormal];


    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = _selectColor;
    [_backView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_backView.subviews.firstObject.mas_centerX);
        make.width.mas_offset((60));
        make.height.mas_offset((5));
        make.bottom.mas_equalTo(_backView.mas_bottom).mas_offset(0);
    }];
}
//- (void)setLineTopSpace:(CGFloat)lineTopSpace
//{
//    _lineTopSpace = lineTopSpace;
//    [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(_backView.mas_bottom).mas_offset(0);
//    }];
//}

-(void)setLineStyle:(TopBarLineStyle)lineStyle
{
    CGFloat lineW = 60;
    if (lineStyle == TopBarLineStyleWithCountFixWidth) {
        lineW = SCREEN_WIDTH/self.dataArr.count;
    }else if (lineStyle == TopBarLineStyleWithBtnWidth){
        lineW = (SCREEN_WIDTH - (_dataArr.count - 1) * 10 - 10 *4)/(_dataArr.count);
    }
    self.lineView.width = lineW;
    [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(lineW);
    }];
}

- (void)clickBtn:(UIButton *)sender
{
    if (!self.isNotCanClickBool) {
        [self.lastSelectBtn setTitleColor:BASECOLOR_TEXTCOLOR forState:UIControlStateNormal];
        [(UIButton *)sender setTitleColor:_selectColor forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.25 animations:^{
            self.lineView.centerX = sender.centerX;
        }];
        self.lastSelectBtn = sender;
        if (self.callBackBlock) {
            self.callBackBlock(sender.tag);
        }
    }
}

- (UIScrollView*)backView
{
    if (!_backView) {
        _backView = [[UIScrollView alloc] init];
        _backView.showsHorizontalScrollIndicator = NO;
        _backView.scrollEnabled = NO;
    }
    return _backView;
}

- (void)selectCurrentBtn:(UIButton *)sender
{
    [self.lastSelectBtn setTitleColor:BASECOLOR_TEXTCOLOR forState:UIControlStateNormal];
    if (self.isNotCanClickBool) {
    }
    [(UIButton *)sender setTitleColor:_selectColor forState:UIControlStateNormal];
    [UIView animateWithDuration:0.25 animations:^{
        self.lineView.centerX = sender.centerX;
    }];
    self.lastSelectBtn = sender;
    if (!self.isNotCanClickBool) {
        if (self.callBackBlock) {
            self.callBackBlock(sender.tag);
        }
    }
}

- (void)selectIndex:(NSInteger)index
{
    if (index >= self.btnArr.count) {
        return;
    }
    LWButton *btn =  [self.btnArr objectAtIndex:index];
    [self selectCurrentBtn:btn];
}

/**
 修改btn内容
 
 @param title 字符串
 @param index 下标
 */
- (void)changeBtnTitle:(NSString *)title index:(NSInteger)index;
{
    if (index >= self.btnArr.count) {
        return;
    }
    UIButton *btn = self.btnArr[index];
    [btn setTitle:title forState:UIControlStateNormal];
//    [btn setTitle:title forState:UIControlStateSelected];
}
@end
