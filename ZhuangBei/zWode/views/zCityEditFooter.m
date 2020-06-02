//
//  zCityEditFooter.m
//  ZhuangBei
//
//  Created by aa on 2020/5/3.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zCityEditFooter.h"

@interface zCityEditFooter ()

@property(strong,nonatomic)UIView * baseView;

@property(strong,nonatomic)UIButton * editButton;

@property(strong,nonatomic)UIButton * cancleButton;

@property(strong,nonatomic)UIButton * okButton;

@end

@implementation zCityEditFooter

-(UIView*)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc]init];
    }
    return _baseView;
}

-(UIButton*)editButton
{
    if (!_editButton) {
        _editButton = [[UIButton alloc]init];
        _editButton.titleLabel.font = kFont(20);
        [_editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
        _editButton.backgroundColor = [kMainSingleton colorWithHexString:@"#3F50B5" alpha:1];
        _editButton.layer.cornerRadius = kWidthFlot(20);
        _editButton.clipsToBounds = YES;
        _editButton.tag = 1;
        [_editButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _editButton.alpha = 0;
    }
    return _editButton;
}

-(UIButton*)cancleButton
{
    if (!_cancleButton) {
        _cancleButton = [[UIButton alloc]init];
        _cancleButton.titleLabel.font = kFont(20);
        [_cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancleButton.backgroundColor = [kMainSingleton colorWithHexString:@"#9B9B9B" alpha:1];
        _cancleButton.layer.cornerRadius = kWidthFlot(20);
        _cancleButton.clipsToBounds = YES;
        _cancleButton.tag = 2;
        [_cancleButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _cancleButton.alpha = 0;
    }
    return _cancleButton;
}

-(UIButton*)okButton
{
    if (!_okButton) {
        _okButton = [[UIButton alloc]init];
        _okButton.titleLabel.font = kFont(20);
        [_okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_okButton setTitle:@"确认" forState:UIControlStateNormal];
        _okButton.backgroundColor = [kMainSingleton colorWithHexString:@"#3F50B5" alpha:1];
        _okButton.layer.cornerRadius = kWidthFlot(20);
        _okButton.clipsToBounds = YES;
        _okButton.tag = 3;
        [_okButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _okButton.alpha = 0;
    }
    return _okButton;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.baseView];
        [self.baseView addSubview:self.editButton];
        [self.baseView addSubview:self.cancleButton];
        [self.baseView addSubview:self.okButton];
        
        [self updateConstraintsForView];
    }
    return self;
}

-(void)updateConstraintsForView
{
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        make.height.mas_equalTo(kWidthFlot(55));
    }];
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.baseView.mas_centerY);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(kWidthFlot(285));
        make.height.mas_equalTo(kWidthFlot(45));
    }];
//
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.baseView.mas_centerX).offset(-kWidthFlot(10));
        make.centerY.mas_equalTo(self.baseView.mas_centerY);
        make.width.mas_equalTo(kWidthFlot(150));
        make.height.mas_equalTo(kWidthFlot(45));
    }];
    
    [self.okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.baseView.mas_centerX).offset(kWidthFlot(10));
        make.centerY.mas_equalTo(self.baseView.mas_centerY);
        make.width.mas_equalTo(kWidthFlot(150));
        make.height.mas_equalTo(kWidthFlot(45));
    }];
}

-(void)setCanEdit:(BOOL)canEdit
{
    _canEdit = canEdit;
    if (_canEdit) {
        self.editButton.alpha = 0;
        self.cancleButton.alpha = 1;
        self.okButton.alpha = 1;
    }else
    {
        self.editButton.alpha = 1;
        self.cancleButton.alpha = 0;
        self.okButton.alpha = 0;
    }
}

-(void)buttonClick:(UIButton*)button
{
    if (self.tapBack) {
        self.tapBack(button.tag);
    }
}

@end
