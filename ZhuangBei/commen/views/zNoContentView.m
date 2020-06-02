//
//  zNoContentView.m
//  ZhuangBei
//
//  Created by aa on 2020/4/22.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zNoContentView.h"

@interface zNoContentView ()

@property(strong,nonatomic)UIImageView * iconImageView;

@property(strong,nonatomic)UILabel * descLabel;

@property(strong,nonatomic)UIButton * retryButton;

@end

@implementation zNoContentView

-(UIImageView*)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_iconImageView setImage:[UIImage imageNamed:@"z_noContent"]];
    }
    return _iconImageView;
}

-(UILabel*)descLabel
{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc]init];
        _descLabel.font = kFont(14);
        _descLabel.textColor = [kMainSingleton colorWithHexString:@"#333333" alpha:0.5];
        _descLabel.text = @"当前网络不佳,请检查网络设置";
        _descLabel.numberOfLines = 1;
    }
    return _descLabel;
}

-(UIButton*)retryButton
{
    if (!_retryButton) {
        _retryButton = [[UIButton alloc]init];
        [_retryButton setTitle:@"点击重试" forState:UIControlStateNormal];
        [_retryButton setTitleColor:[kMainSingleton colorWithHexString:@"#FFFFFF" alpha:1] forState:UIControlStateNormal];
        [_retryButton setBackgroundColor:[kMainSingleton colorWithHexString:@"#cdcdcd" alpha:1]];
        _retryButton.layer.cornerRadius = 5;
        _retryButton.clipsToBounds = YES;
        [_retryButton addTarget:self action:@selector(retryButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _retryButton;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.iconImageView];
        [self addSubview:self.descLabel];
        [self addSubview:self.retryButton];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY).offset(-kWidthFlot(50));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(200), kWidthFlot(200)));
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(kWidthFlot(10));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(kWidthFlot(20));
    }];
    
    [self.retryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.descLabel.mas_bottom).offset(kWidthFlot(10));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(100), kWidthFlot(30)));
    }];
    
}


-(void)retryButtonClick{
    
    [[zHud shareInstance]show];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[zHud shareInstance]hild];
    });
    
    if (self.retryTapBack) {
        self.retryTapBack();
    }
}
@end
