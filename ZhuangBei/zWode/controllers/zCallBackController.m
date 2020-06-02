//
//  zCallBackController.m
//  ZhuangBei
//
//  Created by aa on 2020/5/4.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zCallBackController.h"
#import <UITextView+WZB.h>

@interface zCallBackController ()<UITextViewDelegate>

@property(strong,nonatomic)UIButton * nameLabel;

@property(strong,nonatomic)UITextView * descTextView;

@property(strong,nonatomic)UIButton * editButton;


@end

@implementation zCallBackController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(UIButton*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UIButton alloc]init];
        _nameLabel.titleLabel.font = kFont(20);
        _nameLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_nameLabel setTitleColor:[UIColor colorWithHexString:@"#4A4A4A"] forState:UIControlStateNormal];
        [_nameLabel setTitle:@"意见反馈：" forState:UIControlStateNormal];
        _nameLabel.clipsToBounds = YES;
        _nameLabel.tag = 1;
    }
    return _nameLabel;
}


-(UITextView*)descTextView
{
    if (!_descTextView) {
        _descTextView = [[UITextView alloc]init];
        _descTextView.font = kFont(18);
        _descTextView.backgroundColor = [UIColor whiteColor];
        _descTextView.textColor = [UIColor colorWithHexString:@"#000000"];
        _descTextView.layer.cornerRadius = kWidthFlot(15);
        _descTextView.layer.borderWidth = 1;
        _descTextView.layer.borderColor = [UIColor colorWithHexString:@"#E1E5EA"].CGColor;
        _descTextView.delegate =self;
        [_descTextView setWzb_placeholder:@"请提出宝贵建议"];
        [_descTextView setWzb_placeholderColor:[UIColor colorWithHexString:@"#bababa"]];
    }
    return _descTextView;
}

-(UIButton*)editButton
{
    if (!_editButton) {
        _editButton = [[UIButton alloc]init];
        _editButton.titleLabel.font = kFont(20);
        [_editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_editButton setTitle:@"提交" forState:UIControlStateNormal];
        _editButton.backgroundColor = [kMainSingleton colorWithHexString:@"#3F50B5" alpha:1];
        _editButton.layer.cornerRadius = kWidthFlot(20);
        _editButton.clipsToBounds = YES;
        _editButton.tag = 1;
        [_editButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.descTextView];
    [self.view addSubview:self.editButton];
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(20));
        make.top.mas_equalTo(kWidthFlot(15));
        make.right.mas_equalTo(-kWidthFlot(40));
        make.height.mas_equalTo(kWidthFlot(50));
    }];
    
    [self.descTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(30);
        make.right.mas_equalTo(-kWidthFlot(20));
        make.left.mas_equalTo(kWidthFlot(20));
        make.height.mas_equalTo(kWidthFlot(200));
    }];
    
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.descTextView.mas_bottom).offset(30);
        make.right.mas_equalTo(-kWidthFlot(40));
        make.left.mas_equalTo(kWidthFlot(40));
        make.height.mas_equalTo(kWidthFlot(40));
    }];
}

-(void)buttonClick:(UIButton*)button
{
    if (self.descTextView.text.length>0) {
        [[zHud shareInstance] showMessage:self.descTextView.text];
        [[zHud shareInstance] showMessage:@"提交建议成功"];
        self.descTextView.text = @"";
    }else
    {
        [[zHud shareInstance] showMessage:@"请填写宝贵建议"];
    }
    
}


@end
