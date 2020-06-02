//
//  zCityCollectionHeaderView.m
//  ZhuangBei
//
//  Created by aa on 2020/5/13.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zCityCollectionHeaderView.h"

@interface zCityCollectionHeaderView ()

@property(strong,nonatomic)UIButton * allSelect;

@end

@implementation zCityCollectionHeaderView

-(UIButton*)allSelect
{
    if (!_allSelect) {
        _allSelect = [[UIButton alloc]init];
        _allSelect.userInteractionEnabled = NO;
        _allSelect.titleLabel.font = kFont(14);
        _allSelect.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_allSelect setTitleColor:[kMainSingleton colorWithHexString:@"#4A4A4A" alpha:1] forState:UIControlStateNormal];
        [_allSelect setImage:[UIImage imageNamed:@"chose_normal"] forState:UIControlStateNormal];
        [_allSelect setImage:[UIImage imageNamed:@"chose_select"] forState:UIControlStateSelected];
        [_allSelect setTitle:@"全选" forState:UIControlStateNormal];
        [_allSelect addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allSelect;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.allSelect];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.allSelect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kWidthFlot(5));
        make.bottom.mas_equalTo(-kWidthFlot(5));
        make.right.mas_equalTo(-kWidthFlot(10));
        make.width.mas_equalTo(kWidthFlot(60));
    }];
    
    [self.allSelect setNeedsLayout];
    [self.allSelect layoutIfNeeded];
    [self.allSelect setIconInLeftWithSpacing:kWidthFlot(5)];
}

-(void)setCanEdit:(BOOL)canEdit
{
    _canEdit = canEdit;
    if (_canEdit) {
        self.allSelect.userInteractionEnabled = YES;
    }else
    {
        self.allSelect.userInteractionEnabled = NO;
    }
}

-(void)setSelectAll:(BOOL)selectAll
{
    _selectAll = selectAll;
    self.allSelect.selected = selectAll;
}

-(void)buttonClick:(UIButton*)button
{
    self.allSelect.selected = !button.selected;
    
    if (self.selectAllTap) {
        self.selectAllTap(self.allSelect.selected);
    }
}
@end
