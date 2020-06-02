//
//  zLeftMenuHeader.m
//  ZhuangBei
//
//  Created by aa on 2020/5/7.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zLeftMenuHeader.h"

@interface zLeftMenuHeader ()

@property(strong,nonatomic)UIButton * arrowButton;


@end

@implementation zLeftMenuHeader

-(UIButton*)arrowButton
{
    if (!_arrowButton) {
        _arrowButton = [[UIButton alloc]init];
        [_arrowButton setImage:[UIImage imageNamed:@"leftMenu_arrowDown"] forState:UIControlStateNormal];
        [_arrowButton setImage:[UIImage imageNamed:@"leftMenu_arrowLeft"] forState:UIControlStateSelected];
        _arrowButton.titleLabel.font = [UIFont systemFontOfSize:kWidthFlot(12)];
        [_arrowButton setTitleColor:[UIColor colorWithHexString:@"#4A4A4A"] forState:UIControlStateNormal];
        _arrowButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_arrowButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _arrowButton;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.arrowButton];
        [self updateConstraintsForView];
    }
    return self;
}

-(void)updateConstraintsForView
{
    [self.arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 10,0, 10));
        make.height.mas_equalTo(kWidthFlot(20));
    }];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.arrowButton setNeedsLayout];
    [self.arrowButton layoutIfNeeded];
    [self.arrowButton setIconInLeftWithSpacing:kWidthFlot(3)];
}


-(void)setHyModel:(zGoodsMenuModel *)hyModel
{
    _hyModel = hyModel;
    [self.arrowButton setTitle:hyModel.title forState:UIControlStateNormal];
    self.arrowButton.selected = hyModel.select;
}


-(void)buttonClick:(UIButton*)button
{
    if (self.menuHeaerTapBack) {
        self.menuHeaerTapBack(_hyModel);
    }
}
@end
