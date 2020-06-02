//
//  zInstructionsCard.m
//  ZhuangBei
//
//  Created by aa on 2020/4/27.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zInstructionsCard.h"

@interface zInstructionsCard ()

@property(strong,nonatomic)UIView * baseView;

@property(strong,nonatomic)UIButton* nameBtn;

@end

@implementation zInstructionsCard

-(UIView*)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc]init];
        _baseView.backgroundColor = [UIColor whiteColor];
        _baseView.layer.cornerRadius = 15;
        _baseView.layer.borderColor = [UIColor whiteColor].CGColor;
        _baseView.layer.borderWidth = 1;
        _baseView.clipsToBounds = YES;
    }
    return _baseView;
}
-(UIButton*)nameBtn
{
    if (!_nameBtn) {
        _nameBtn = [[UIButton alloc]init];
        _nameBtn.titleLabel.font = kFont(16);
        _nameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_nameBtn setTitle:@"操作手册" forState:UIControlStateNormal];
        [_nameBtn setTitleColor:[kMainSingleton colorWithHexString:@"#4A4A4A" alpha:1] forState:UIControlStateNormal];
        _nameBtn.clipsToBounds = YES;
    }
    return _nameBtn;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.baseView];
        [self.baseView addSubview:self.nameBtn];
        [self updateConstraintsForView];
    }
    return self;
}

-(void)updateConstraintsForView
{
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.nameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_baseView setNeedsLayout];
    [_baseView layoutIfNeeded];
    UIBezierPath *shadowPath = [UIBezierPath
    bezierPathWithRect:_baseView.bounds];
    _baseView.layer.masksToBounds = NO;
    _baseView.layer.shadowColor = [UIColor blackColor].CGColor;
    _baseView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    _baseView.layer.shadowOpacity = 0.1f;
    _baseView.layer.shadowPath = shadowPath.CGPath;
}
@end
