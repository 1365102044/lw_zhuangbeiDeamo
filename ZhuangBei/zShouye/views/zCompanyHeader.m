//
//  zCompanyHeader.m
//  ZhuangBei
//
//  Created by aa on 2020/5/8.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zCompanyHeader.h"
#import "sliderNavMenu.h"

@interface zCompanyHeader ()<sliderNavMenuDelegate>

@property(strong,nonatomic)UIView * baseView;

@property(strong,nonatomic)UIImageView * logoImageView;
@property(strong,nonatomic)UILabel * nameLabel;
@property(strong,nonatomic)UILabel * timeLabel;
@property(strong,nonatomic)UILabel * descNameLabel;
@property(strong,nonatomic)UILabel * descContentLabel;
@property(strong,nonatomic)sliderNavMenu * navigationSliderMenu;

@end

@implementation zCompanyHeader

-(UIView*)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc]init];
    }
    return _baseView;
}

-(UIImageView*)logoImageView
{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc]init];
        _logoImageView.clipsToBounds = YES;
        _logoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _logoImageView.image = [UIImage imageNamed:@"testicon"];
    }
    return _logoImageView;
}

-(UILabel*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = kFont(14);
        _nameLabel.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
        _nameLabel.numberOfLines = 0;
        _nameLabel.text = @"北京装备科技设计有限公司";
    }
    return _nameLabel;
}
-(UILabel*)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = kFont(12);
        _timeLabel.textColor = [UIColor colorWithHexString:@"#9B9B9B"];
        _timeLabel.numberOfLines = 0;
        _timeLabel.text = @"成立时间:2000年1月1日";
    }
    return _timeLabel;
}
-(UILabel*)descNameLabel
{
    if (!_descNameLabel) {
        _descNameLabel = [[UILabel alloc]init];
        _descNameLabel.textAlignment = NSTextAlignmentCenter;
        _descNameLabel.font = kFont(12);
        _descNameLabel.textColor = [UIColor colorWithHexString:@"#9B9B9B"];
        _descNameLabel.numberOfLines = 0;
        _descNameLabel.text = @"公司简介:";
    }
    return _descNameLabel;
}

-(UILabel*)descContentLabel
{
    if (!_descContentLabel) {
        _descContentLabel = [[UILabel alloc]init];
        _descContentLabel.font = kFont(12);
        _descContentLabel.textColor = [UIColor colorWithHexString:@"#9B9B9B"];
        _descContentLabel.text = @"";
        _descContentLabel.numberOfLines = 0;
    }
    return _descContentLabel;
}

-(sliderNavMenu*)navigationSliderMenu
{
    if (!_navigationSliderMenu) {
        _navigationSliderMenu = [[sliderNavMenu alloc]init];
        _navigationSliderMenu.userInteractionEnabled = YES;
        _navigationSliderMenu.havesliderBar = YES;
        _navigationSliderMenu.padding = kWidthFlot(30);
        _navigationSliderMenu.sliderRoundCorner = 1.5;
        _navigationSliderMenu.normalFontColor = [UIColor colorWithHexString:@"#666666"];
        _navigationSliderMenu.selectFontColor = [UIColor colorWithHexString:@"#333333"];
        if (self.type ==1) {
            [_navigationSliderMenu setSourceArray:@[@"企业详情"]];
        }else
        {
            [_navigationSliderMenu setSourceArray:@[@"企业详情",@"货源详情"]];
        }
        _navigationSliderMenu.sliderType = menuAligenLeft;
        _navigationSliderMenu.delegate = self;
    }
    return _navigationSliderMenu;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.baseView];
        
        [self.baseView addSubview:self.logoImageView];
        [self.baseView addSubview:self.nameLabel];
        [self.baseView addSubview:self.timeLabel];
        [self.baseView addSubview:self.descNameLabel];
        [self.baseView addSubview:self.descContentLabel];
        [self.baseView addSubview:self.navigationSliderMenu];
        [self updateConstraintsForView];
    }
    return self;
}


-(void)updateConstraintsForView
{
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kWidthFlot(5));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(50), kWidthFlot(50)));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.logoImageView.mas_bottom).offset(kWidthFlot(10));
        make.left.mas_equalTo(kWidthFlot(30));
        make.right.mas_equalTo(-kWidthFlot(30));
        make.height.mas_equalTo(kWidthFlot(20));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(kWidthFlot(5));
        make.left.mas_equalTo(kWidthFlot(30));
        make.right.mas_equalTo(-kWidthFlot(30));
        make.height.mas_equalTo(kWidthFlot(20));
    }];
    [self.descNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(kWidthFlot(5));
        make.left.mas_equalTo(kWidthFlot(30));
        make.width.mas_equalTo(SCREEN_WIDTH-kWidthFlot(60));
        make.height.mas_equalTo(kWidthFlot(20));
    }];
    [self.descContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.descNameLabel.mas_bottom).offset(kWidthFlot(5));
        make.left.mas_equalTo(kWidthFlot(30));
        make.width.mas_equalTo(SCREEN_WIDTH-kWidthFlot(60));
    }];
    
    [self.navigationSliderMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.descContentLabel.mas_bottom).offset(kWidthFlot(5));
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(-kWidthFlot(10));
    }];
}

-(void)setType:(NSInteger)type
{
    _type = type;
    if (type==1) {
        [self.navigationSliderMenu setSourceArray:@[@"企业详情"]];
    }
}

-(void)setGoosModel:(zGoodsContentModel *)goosModel
{
    _goosModel = goosModel;
    self.nameLabel.text = _goosModel.name;
    self.timeLabel.text = [NSString stringWithFormat:@"成立时间:%@",_goosModel.createDate];
    self.descContentLabel.text = _goosModel.approveText;
}

-(void)setCompanyType:(NSInteger)companyType
{
    _companyType = companyType;
    self.navigationSliderMenu.selectIndex = companyType;
}



-(void)sliderNavMenuSelectIndex:(NSInteger)index
{
    if (self.headerSlideBack) {
        self.headerSlideBack(index);
    }
}


@end
