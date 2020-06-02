//
//  zSettingCellView.m
//  ZhuangBei
//
//  Created by aa on 2020/5/1.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zSettingCellView.h"

@interface zSettingCellView ()

@property(strong,nonatomic)UILabel * titleLabel;

@property(strong,nonatomic)UIButton * contentButton;

@property(strong,nonatomic)UIView * lineView;

@end

@implementation zSettingCellView

-(UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = kFont(16);
        _titleLabel.textColor = [kMainSingleton colorWithHexString:@"#4A4A4A" alpha:1];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

-(UIButton*)contentButton
{
    if (!_contentButton) {
        _contentButton = [[UIButton alloc]init];
        _contentButton.titleLabel.font = kFont(16);
        [_contentButton setTitleColor:[kMainSingleton colorWithHexString:@"#4A4A4A" alpha:1] forState:UIControlStateNormal];
        _contentButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_contentButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [_contentButton setImage:[UIImage imageNamed:@"wode_more"] forState:UIControlStateNormal];
    }
    return _contentButton;
}

-(UIView*)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [kMainSingleton colorWithHexString:@"#4A4A4A" alpha:1];
    }
    return _lineView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentButton];
        [self addSubview:self.lineView];
        [self updateConstraintsForView];
    }
    return self;
}

-(void)updateConstraintsForView
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(10));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(kWidthFlot(20));
    }];
    
    [self.contentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kWidthFlot(20));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(kWidthFlot(20));
        make.width.mas_equalTo(kWidthFlot(150));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(1);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentButton setNeedsLayout];
    [self.contentButton layoutIfNeeded];
    [self.contentButton setIconInRightWithSpacing:5];
    
}

-(void)updateConstraintsBUtton
{
    [self.contentButton setNeedsLayout];
    [self.contentButton layoutIfNeeded];
    [self.contentButton setIconInRightWithSpacing:5];
}

-(void)setName:(NSString *)name
{
    _name = name;
    self.titleLabel.text = name;
}

-(void)setContent:(NSString *)content
{
    _content = content;
    [self.contentButton setTitle:content forState:UIControlStateNormal];
    [self updateConstraintsBUtton];
}

-(void)setIsPhoneNum:(BOOL)isPhoneNum
{
    if (isPhoneNum) {
        if (_content.length == 11) {
        NSString *numberString = [_content stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        [self.contentButton setTitle:numberString forState:UIControlStateNormal];
        }
        [self.contentButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
}

-(void)buttonClick
{
    if (self.settingBack) {
        self.settingBack();
    }
}
@end
