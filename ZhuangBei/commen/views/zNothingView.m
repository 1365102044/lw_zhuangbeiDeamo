//
//  zNothingView.m
//  ZhuangBei
//
//  Created by aa on 2020/4/22.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zNothingView.h"

@interface zNothingView ()

@property(strong,nonatomic)UIImageView * iconImageView;

@property(strong,nonatomic)UILabel * descLabel;

@end

@implementation zNothingView

-(UIImageView*)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_iconImageView setImage:[UIImage imageNamed:@"z_nothing"]];
    }
    return _iconImageView;
}

-(UILabel*)descLabel
{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc]init];
        _descLabel.font = kFont(14);
        _descLabel.textColor = [kMainSingleton colorWithHexString:@"#333333" alpha:0.5];
        _descLabel.text = @"暂无数据";
        _descLabel.numberOfLines = 1;
    }
    return _descLabel;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.iconImageView];
        [self addSubview:self.descLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY).offset(-kWidthFlot(50));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(100), kWidthFlot(100)));
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(kWidthFlot(10));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(kWidthFlot(20));
    }];
    
    
}

@end
