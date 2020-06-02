//
//  zUserDescController.m
//  ZhuangBei
//
//  Created by aa on 2020/5/3.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zUserDescController.h"
#import <UITextView+WZB.h>
#import "zEducationRankTypeInfo.h"

@interface zUserDescController ()<UITextViewDelegate>

@property(strong,nonatomic)UIButton * imageHeader;

@property(strong,nonatomic)UIButton * nameLabel;

@property(strong,nonatomic)UITextView * descTextView;

@property(strong,nonatomic)UIButton * editButton;

@property(strong,nonatomic)NSMutableDictionary * mianParam;

@end

@implementation zUserDescController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(NSMutableDictionary*)mianParam
{
    if (!_mianParam) {
        _mianParam = [NSMutableDictionary dictionary];
        
        [_mianParam setObject:@([zEducationRankTypeInfo shareInstance].userInfoModel.userId) forKey:@"userId"];
        [_mianParam setObject:@([zEducationRankTypeInfo shareInstance].userInfoModel.userDm) forKey:@"userDm"];
    }
    return _mianParam;
}

-(UIButton*)imageHeader
{
    if (!_imageHeader) {
        _imageHeader = [[UIButton alloc]init];
        _imageHeader.layer.cornerRadius = kWidthFlot(25);
        _imageHeader.clipsToBounds = YES;
        [_imageHeader setBackgroundImage:[UIImage imageNamed:@"wode_defoutHeader"] forState:UIControlStateNormal];
    }
    return _imageHeader;
}
-(UIButton*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UIButton alloc]init];
        _nameLabel.titleLabel.font = kFont(20);
        _nameLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_nameLabel setTitleColor:[UIColor colorWithHexString:@"#4A4A4A"] forState:UIControlStateNormal];
        [_nameLabel setTitle:[zEducationRankTypeInfo shareInstance].userInfoModel.userName forState:UIControlStateNormal];
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
        [_descTextView setWzb_placeholder:@"请填写个人简介"];
        [_descTextView setWzb_placeholderColor:[UIColor colorWithHexString:@"#bababa"]];
        _descTextView.editable = NO;
    }
    return _descTextView;
}

-(UIButton*)editButton
{
    if (!_editButton) {
        _editButton = [[UIButton alloc]init];
        _editButton.titleLabel.font = kFont(20);
        [_editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
        [_editButton setTitle:@"确定" forState:UIControlStateSelected];
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
    
    if ([zEducationRankTypeInfo shareInstance].userInfoModel.minsummary.length>0) {
        self.descTextView.text = [zEducationRankTypeInfo shareInstance].userInfoModel.minsummary;
    }
    [self.view addSubview:self.imageHeader];
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.descTextView];
    [self.view addSubview:self.editButton];
    
        NSString * url = [NSString stringWithFormat:@"%@app/appfujian/download?attID=%@",kApiPrefix,[zEducationRankTypeInfo shareInstance].userInfoModel.portrait];
        __weak typeof(self) weakSelf = self;
        [self.imageHeader sd_setBackgroundImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (image == nil) {
                [weakSelf.imageHeader setBackgroundImage:[UIImage imageNamed:@"wode_defoutHeader"] forState:UIControlStateNormal];
            }
        }];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.imageHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(44));
        make.top.mas_equalTo(kWidthFlot(15));
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(50), kWidthFlot(50)));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageHeader.mas_right).offset(5);
        make.top.mas_equalTo(kWidthFlot(15));
        make.right.mas_equalTo(-kWidthFlot(40));
        make.height.mas_equalTo(kWidthFlot(50));
    }];
    
    [self.descTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageHeader.mas_bottom).offset(30);
        make.right.mas_equalTo(-kWidthFlot(40));
        make.left.mas_equalTo(kWidthFlot(45));
        make.height.mas_equalTo(kWidthFlot(200));
    }];
    
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.descTextView.mas_bottom).offset(30);
        make.right.mas_equalTo(-kWidthFlot(40));
        make.left.mas_equalTo(kWidthFlot(45));
        make.height.mas_equalTo(kWidthFlot(40));
    }];
}

-(void)buttonClick:(UIButton*)button
{
    self.editButton.selected  = !button.selected;
    if (self.editButton.selected) {
        self.descTextView.editable = YES;
        [self.descTextView becomeFirstResponder];
    }else
    {
        if (self.descTextView.text.length>0) {
            
            [self.mianParam setObject:self.descTextView.text forKey:@"minsummary"];
            
            NSString * url = [NSString stringWithFormat:@"%@%@",kApiPrefix,changePersonalMin];
            [self postDataWithUrl:url WithParam:self.mianParam];
        }else
        {
            [[zHud shareInstance] showMessage:@"请填写个人简介"];
        }
    }
    
    
}

-(void)RequsetFileWithUrl:(NSString*)url WithError:(NSError*)err
{
    if ([url containsString:changePersonalMin]) {
        
        if (err.code == -1001) {
            [[zHud shareInstance] showMessage:@"无法连接服务器"];
        }
    }

}



-(void)RequsetSuccessWithData:(id)data AndUrl:(NSString*)url
{
    if ([url containsString:changePersonalMin]) {
        NSDictionary * dic = data[@"data"];
        NSString * code = data[@"code"];
        if ([code integerValue] == 0) {
            [[zHud shareInstance] showMessage:@"编辑成功"];
        }
        NSLog(@"公司认证信息%@",dic);
    }
}



@end
