//
//  zLeftMenuThirdCell.m
//  ZhuangBei
//
//  Created by aa on 2020/5/17.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zLeftMenuThirdCell.h"

@interface zLeftMenuThirdCell ()

@property(strong,nonatomic)UIButton * arrowButton;

@end

@implementation zLeftMenuThirdCell

-(UIButton*)arrowButton
{
    if (!_arrowButton) {
        _arrowButton = [[UIButton alloc]init];
        _arrowButton.userInteractionEnabled = NO;
        [_arrowButton setImage:[UIImage imageNamed:@"leftMenu_arrowDown"] forState:UIControlStateNormal];
        [_arrowButton setImage:[UIImage imageNamed:@"leftMenu_arrowDown"] forState:UIControlStateNormal];
        _arrowButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _arrowButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _arrowButton.titleLabel.font = [UIFont systemFontOfSize:kWidthFlot(12)];
        [_arrowButton setTitleColor:[UIColor colorWithHexString:@"#4A4A4A"] forState:UIControlStateNormal];
    }
    return _arrowButton;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.arrowButton];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(kWidthFlot(10));
        make.right.mas_equalTo(-kWidthFlot(10));
        make.height.mas_equalTo(kWidthFlot(30));
    }];
}

-(void)setGoodsModel:(zGoodsMenuModel *)goodsModel
{
    _goodsModel = goodsModel;
    [self.arrowButton setTitle:goodsModel.title forState:UIControlStateNormal];
}

@end
