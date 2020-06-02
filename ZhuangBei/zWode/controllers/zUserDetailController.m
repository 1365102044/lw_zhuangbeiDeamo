//
//  zUserDetailController.m
//  ZhuangBei
//
//  Created by aa on 2020/5/16.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zUserDetailController.h"
#import "zEducationRankTypeInfo.h"
#import "zPersonalController.h"
#import "zUserDescController.h"

@interface zUserDetailController ()

@property(strong,nonatomic)UIButton * userDetailButton;

@property(strong,nonatomic)UIImageView * imageHeader;

@property(strong,nonatomic)UILabel * nameLabel;

@property(strong,nonatomic)UILabel * EmailLabel;

@property(strong,nonatomic)UIButton * descLabel;

@property(strong,nonatomic)UIButton * arrowButton;

@end

@implementation zUserDetailController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


-(UIButton*)userDetailButton
{
    if (!_userDetailButton) {
        _userDetailButton = [[UIButton alloc]init];
        _userDetailButton.tag = 1;
        [_userDetailButton addTarget:self action:@selector(buttonCLick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userDetailButton;
}

-(UIImageView*)imageHeader
{
    if (!_imageHeader) {
        _imageHeader = [[UIImageView alloc]init];
        _imageHeader.userInteractionEnabled = NO;
        _imageHeader.layer.cornerRadius = kWidthFlot(50);
        _imageHeader.clipsToBounds = YES;
        _imageHeader.image = [UIImage imageNamed:@"wode_defoutHeader"];
    }
    return _imageHeader;
}

-(UILabel*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = kFont(16);
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.clipsToBounds = YES;
        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}

-(UILabel*)EmailLabel
{
    if (!_EmailLabel) {
        _EmailLabel = [[UILabel alloc]init];
        _EmailLabel.font = kFont(16);
        _EmailLabel.textColor = [UIColor blackColor];
        _EmailLabel.clipsToBounds = YES;
        _EmailLabel.numberOfLines = 0;
    }
    return _EmailLabel;
}

-(UIButton*)descLabel
{
    if (!_descLabel) {
        _descLabel = [[UIButton alloc]init];
        _descLabel.tag = 2;
        _descLabel.titleLabel.font = kFont(16);
        _descLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        [_descLabel setImage:[UIImage imageNamed:@"icon_into"] forState:UIControlStateNormal];
        [_descLabel setTitle:@"个人简介" forState:UIControlStateNormal];
        [_descLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _descLabel.clipsToBounds = YES;
        [_descLabel addTarget:self action:@selector(buttonCLick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _descLabel;
}

-(UIButton*)arrowButton
{
    if (!_arrowButton) {
        _arrowButton = [[UIButton alloc]init];
        _arrowButton.tag = 2;
        _arrowButton.titleLabel.font = kFont(16);
//        _arrowButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_arrowButton setImage:[UIImage imageNamed:@"icon_into"] forState:UIControlStateNormal];
        [_arrowButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _arrowButton.clipsToBounds = YES;
        [_arrowButton addTarget:self action:@selector(buttonCLick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _arrowButton;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.userDetailButton];
    [self.userDetailButton addSubview:self.imageHeader];
    [self.userDetailButton addSubview:self.nameLabel];
    [self.userDetailButton addSubview:self.EmailLabel];
    
    [self.view addSubview:self.descLabel];
    [self.view addSubview:self.arrowButton];
    self.nameLabel.text = [zEducationRankTypeInfo shareInstance].userInfoModel.userName;
    
    self.EmailLabel.text = [NSString stringWithFormat:@"邮箱:%@",[zEducationRankTypeInfo shareInstance].userInfoModel.email];
    [self.imageHeader z_imageWithImageId:[NSString stringWithFormat:@"%@",[zEducationRankTypeInfo shareInstance].userInfoModel.portrait] placeholderImage:@"wode_defoutHeader"];
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.userDetailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(SCREEN_WIDTH*9/16);
    }];
    
    [self.imageHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kWidthFlot(20));
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(100), kWidthFlot(100)));
        make.centerX.mas_equalTo(self.userDetailButton.mas_centerX);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-kWidthFlot(60));
        make.height.mas_equalTo(kWidthFlot(20));
        make.centerX.mas_equalTo(self.userDetailButton.mas_centerX);
    }];
    
    [self.EmailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-kWidthFlot(20));
        make.height.mas_equalTo(kWidthFlot(20));
        make.centerX.mas_equalTo(self.userDetailButton.mas_centerX);
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(20));
        make.right.mas_equalTo(-kWidthFlot(44));
        make.top.mas_equalTo(self.userDetailButton.mas_bottom).offset(0);
        make.height.mas_equalTo(kWidthFlot(44));
    }];
    
    [self.arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.userDetailButton.mas_bottom).offset(0);
        make.width.mas_equalTo(kWidthFlot(44));
        make.height.mas_equalTo(kWidthFlot(44));
    }];
    
    [self.descLabel setNeedsLayout];
    [self.descLabel layoutIfNeeded];
    [self.descLabel setIconInRight];
}

-(void)buttonCLick:(UIButton*)button
{
    if (button.tag == 1) {
        zPersonalController * zpers = [[zPersonalController alloc]init];
        [self.navigationController pushViewController:zpers animated:YES];
        return;
    }
    
    if (button.tag == 2) {
        zUserDescController * zpers = [[zUserDescController alloc]init];
        zpers.title = @"个人简介";
        [self.navigationController pushViewController:zpers animated:YES];
        return;
    }
}

@end
