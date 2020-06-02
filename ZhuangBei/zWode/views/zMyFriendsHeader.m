//
//  zMyFriendsHeader.m
//  ZhuangBei
//
//  Created by aa on 2020/5/19.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zMyFriendsHeader.h"

@interface zMyFriendsHeader ()

@property(strong,nonatomic)UIView * baseView;

@property(strong,nonatomic)UIButton * headerImageBtn;

@property(strong,nonatomic)UIButton * nameButton;

@property(strong,nonatomic)UILabel * phoneLabel;

@property(strong,nonatomic)UILabel * descLabel;


@end

@implementation zMyFriendsHeader

-(UIView*)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc]init];
        _baseView.backgroundColor = [UIColor whiteColor];
        _baseView.layer.borderColor = [UIColor colorWithHexString:@"#353535"].CGColor;
        _baseView.layer.borderWidth = 0.5;
        _baseView.layer.cornerRadius = 5;
        _baseView.clipsToBounds = YES;
    }
    return _baseView;
}

-(UIButton*)headerImageBtn
{
    if (!_headerImageBtn) {
        _headerImageBtn = [[UIButton alloc]init];
        _headerImageBtn.userInteractionEnabled = NO;
        _headerImageBtn.tag = 1;
        _headerImageBtn.layer.cornerRadius = kWidthFlot(50);
        _headerImageBtn.clipsToBounds = YES;
        [_headerImageBtn setBackgroundImage:[UIImage imageNamed:@"wode_defoutHeader"] forState:UIControlStateNormal];
    }
    return _headerImageBtn;
}

-(UIButton*)nameButton
{
    if (!_nameButton) {
        _nameButton = [[UIButton alloc]init];
        _nameButton.userInteractionEnabled = NO;
        _nameButton.tag = 1;
        [_nameButton setTitleColor:[UIColor colorWithHexString:@"#353535"] forState:UIControlStateNormal];
        [_nameButton setImage:[UIImage imageNamed:@"wode_sex"] forState:UIControlStateNormal];
        _nameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _nameButton.clipsToBounds = YES;
    }
    return _nameButton;
}

-(UILabel*)phoneLabel
{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.font = kFont(kWidthFlot(14));
        _phoneLabel.textColor = [UIColor colorWithHexString:@"#353535"];
        _phoneLabel.numberOfLines = 0;
    }
    return _phoneLabel;
}


-(UILabel*)descLabel
{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc]init];
        _descLabel.font = kFont(kWidthFlot(18));
        _descLabel.textColor = [UIColor colorWithHexString:@"#353535"];
        _descLabel.numberOfLines = 0;
    }
    return _descLabel;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.baseView];
        [self.baseView addSubview:self.headerImageBtn];
        [self.baseView addSubview:self.nameButton];
        [self.baseView addSubview:self.phoneLabel];
        [self.baseView addSubview:self.descLabel];
        
        [self updateConstraintsForView];
    }
    return self;
}

-(void)updateConstraintsForView
{
    CGFloat left = kWidthFlot(15);
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10,0,10));
    }];
    [self.headerImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(left);
        make.top.mas_equalTo(left);
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(100), kWidthFlot(100)));
    }];
    
    [self.nameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(left);
        make.left.mas_equalTo(self.headerImageBtn.mas_right).offset(left);
        make.right.mas_equalTo(-kWidthFlot(150));
        make.height.mas_equalTo(kWidthFlot(50));
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameButton.mas_bottom).offset(kWidthFlot(10));
        make.left.mas_equalTo(self.headerImageBtn.mas_right).offset(left);
        make.right.mas_equalTo(-kWidthFlot(150));
        make.height.mas_equalTo(kWidthFlot(20));
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameButton.mas_bottom).offset(kWidthFlot(10));
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(-kWidthFlot(150));
        make.bottom.mas_equalTo(-kWidthFlot(10));
    }];
    
}

@end
