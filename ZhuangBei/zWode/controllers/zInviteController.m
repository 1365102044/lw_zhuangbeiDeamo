//
//  zInviteController.m
//  ZhuangBei
//
//  Created by aa on 2020/5/4.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zInviteController.h"
#import "zEducationRankTypeInfo.h"
#import <AFNetworking.h>
#import "JShareApp.h"

@interface zInviteController ()

@property(strong,nonatomic)UILabel * titleLabel;

@property(strong,nonatomic)UIButton * inviteNumBtn;

@property(strong,nonatomic)UILabel * descLabel;

@property(strong,nonatomic)UIImageView * inviteImageView;

@property(strong,nonatomic)UILabel * shareLabel;

@property(strong,nonatomic)UIButton * QQShareBtn;

@property(strong,nonatomic)UIButton * WXShareBtn;

@end

@implementation zInviteController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


-(UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"我的邀请码";
        _titleLabel.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
        _titleLabel.font = kFont(20);
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

-(UIButton*)inviteNumBtn
{
    if (!_inviteNumBtn) {
        _inviteNumBtn = [[UIButton alloc]init];
        _inviteNumBtn.titleLabel.font = kFont(48);
        [_inviteNumBtn setTitleColor:[UIColor colorWithHexString:@"#3F50B5"] forState:UIControlStateNormal];
        [_inviteNumBtn setTitle:[zUserInfo shareInstance].userInfo.invatationCode forState:UIControlStateNormal];
        _inviteNumBtn.clipsToBounds = YES;
        _inviteNumBtn.tag = 1;
        [_inviteNumBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _inviteNumBtn;
}
-(UILabel*)descLabel
{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc]init];
        _descLabel.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
        _descLabel.text = @"点击邀请码进行复制";
        _descLabel.font = kFont(16);
        _descLabel.numberOfLines = 0;
    }
    return _descLabel;
}

-(UIImageView*)inviteImageView
{
    if (!_inviteImageView) {
        _inviteImageView = [[UIImageView alloc]init];
        _inviteImageView.image = [UIImage imageNamed:@"storeIMage"];
        _inviteImageView.contentMode = UIViewContentModeScaleAspectFit;
        _inviteImageView.alpha = 1;
        _inviteImageView.backgroundColor = [UIColor whiteColor];
    }
    return _inviteImageView;
}

-(UILabel*)shareLabel
{
    if (!_shareLabel) {
        _shareLabel = [[UILabel alloc]init];
        _shareLabel.text = @"分享至:";
        _shareLabel.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
        _shareLabel.font = kFont(16);
        _shareLabel.numberOfLines = 0;
        _shareLabel.alpha = 1;
    }
    return _shareLabel;
}

-(UIButton*)QQShareBtn
{
    if (!_QQShareBtn) {
        _QQShareBtn = [[UIButton alloc]init];
        [_QQShareBtn setImage:[UIImage imageNamed:@"QQ_Share"] forState:UIControlStateNormal];
//        _QQShareBtn.layer.cornerRadius = kWidthFlot(25);
        _QQShareBtn.clipsToBounds = YES;
        _QQShareBtn.tag = 2;
        [_QQShareBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _QQShareBtn.alpha = 1;
    }
    return _QQShareBtn;
}

-(UIButton*)WXShareBtn
{
    if (!_WXShareBtn) {
        _WXShareBtn = [[UIButton alloc]init];
        [_WXShareBtn setImage:[UIImage imageNamed:@"WX_Share"] forState:UIControlStateNormal];
        _WXShareBtn.clipsToBounds = YES;
        _WXShareBtn.tag = 3;
        [_WXShareBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _WXShareBtn.alpha = 1;
    }
    return _WXShareBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.inviteNumBtn];
    [self.view addSubview:self.descLabel];
    [self.view addSubview:self.inviteImageView];
    [self.view addSubview:self.shareLabel];
    [self.view addSubview:self.QQShareBtn];
    [self.view addSubview:self.WXShareBtn];
    NSString * url = [NSString stringWithFormat:@"%@%@",kApiPrefix,getShareImage];
    
    [self.inviteImageView sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        NSLog(@"加载图片");
    }];
}






-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(kWidthFlot(30));
        make.top.mas_equalTo(kWidthFlot(100));
    }];
    
    [self.inviteNumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(kWidthFlot(67));
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(kWidthFlot(10));
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(kWidthFlot(20));
        make.top.mas_equalTo(self.inviteNumBtn.mas_bottom).offset(kWidthFlot(10));
    }];
    
    [self.inviteImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.descLabel.mas_bottom).offset(kWidthFlot(10));
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(200), kWidthFlot(200)));
    }];
    
    [self.shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.inviteImageView.mas_left).offset(-2);
        make.height.mas_equalTo(kWidthFlot(20));
        make.top.mas_equalTo(self.inviteImageView.mas_bottom).offset(kWidthFlot(10));
    }];
    
    [self.QQShareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_centerX).offset(-kWidthFlot(28));
        make.top.mas_equalTo(self.shareLabel.mas_bottom).offset(kWidthFlot(10));
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(50), kWidthFlot(50)));
    }];
    
    [self.WXShareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_centerX).offset(kWidthFlot(28));
        make.top.mas_equalTo(self.shareLabel.mas_bottom).offset(kWidthFlot(10));
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(50), kWidthFlot(50)));
    }];
}


-(void)buttonClick:(UIButton*)button
{
    if (button.tag == 1) {
        NSString * message = [self.inviteNumBtn currentTitle];
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = message;
        NSString * hudMessage = [NSString stringWithFormat:@"已复制邀请码至剪切板%@",message];
        [[zHud shareInstance]showMessage:hudMessage];
        return;
    }
    
    if (button.tag == 2) {
//        [[zHud shareInstance]showMessage:@"分享QQ"];
        [self shareQQ];
        return;
    }
    
    if (button.tag == 3) {
//        [[zHud shareInstance]showMessage:@"分享微信"];
        [self shareWX];
        return;
    }
}

-(void)shareQQ{
    NSString *url = [[NSBundle mainBundle] URLForResource:@"storeIMage" withExtension:@"png"].absoluteString;
    [JShareApp shareImageWithPlatform:JSHAREPlatformQQ imageUrl:url OrImage:self.inviteImageView.image success:^(id  _Nonnull info) {
        
    } fail:^(id  _Nonnull info) {
        
    }];
}

-(void)shareWX{
    NSString *url = [[NSBundle mainBundle] URLForResource:@"storeIMage" withExtension:@"png"].absoluteString;
    [JShareApp shareImageWithPlatform:JSHAREPlatformWechatSession imageUrl:url OrImage:self.inviteImageView.image success:^(id  _Nonnull info) {
        
    } fail:^(id  _Nonnull info) {
        
    }];
}

-(void)RequsetFileWithUrl:(NSString*)url WithError:(NSError*)err
{
    if ([url containsString:getShareImage]) {
        
        if (err.code == -1001) {
            [[zHud shareInstance] showMessage:@"无法连接服务器"];
        }
    }

}



-(void)RequsetSuccessWithData:(id)data AndUrl:(NSString*)url
{
    if ([url containsString:getShareImage]) {
        NSDictionary * dic = data[@"page"];
        NSString * code = data[@"code"];
        if ([code integerValue] == 0) {
            
        }
        NSLog(@"公司认证信息%@",dic);
    }
}

@end
