//
//  zWodeController.m
//  ZhuangBei
//
//  Created by aa on 2020/4/22.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zWodeController.h"
#import "zUserInfoCard.h"
#import "zInstructionsCard.h"
#import "zCategoryCard.h"
#import "zSettingViewController.h"
#import "zPersonalController.h"
#import "zUserDescController.h"
#import "zInviteController.h"
#import "zCallBackController.h"
#import "zListTypeModel.h"
#import "zEducationRankTypeInfo.h"
#import "zUserInvitelController.h"
#import "zGoodsMangerController.h"
#import "zCompanyController.h"
#import "zUserDetailController.h"
#import "zJiaoliuController.h"

@interface zWodeController ()

@property(strong,nonatomic)UIImageView * imageBaseView;
@property(strong,nonatomic)UIButton * settingButton;

@property(strong,nonatomic)zUserInfoCard * userinfoCard;
@property(strong,nonatomic)zInstructionsCard * instructionCard;
@property(strong,nonatomic)zCategoryCard * categoryCard;

@end

@implementation zWodeController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    NSString * url = [NSString stringWithFormat:@"%@%@",kApiPrefix,kgetUserInfo];
    [self postDataWithUrl:url WithParam:nil];
    
    NSString * getBusinessUrl = [NSString stringWithFormat:@"%@%@",kApiPrefix,kpersonalBusiness];
    [self postDataWithUrl:getBusinessUrl WithParam:nil];
}
-(UIImageView*)imageBaseView
{
    if (!_imageBaseView) {
        _imageBaseView = [[UIImageView alloc]init];
        _imageBaseView.backgroundColor = [kMainSingleton colorWithHexString:@"#3F50B5" alpha:1];
        _imageBaseView.userInteractionEnabled = YES;
    }
    return _imageBaseView;;
}

-(UIButton*)settingButton
{
    if (!_settingButton) {
        _settingButton = [[UIButton alloc]init];
        [_settingButton setImage:[UIImage imageNamed:@"wode_setting"] forState:UIControlStateNormal];
        [_settingButton addTarget:self action:@selector(settting) forControlEvents:UIControlEventTouchUpInside];
    }
    return _settingButton;
}

-(zUserInfoCard*)userinfoCard
{
    if (!_userinfoCard) {
        __weak typeof(self)weakSelf = self;
        _userinfoCard = [[zUserInfoCard alloc]init];
        _userinfoCard.userCardTapBack = ^(NSInteger type) {
            if (type == 1) {
                zUserInvitelController * yaoqing = [[zUserInvitelController alloc]init];
                yaoqing.title = @"我邀请的人";
                [weakSelf.navigationController pushViewController:yaoqing animated:YES];
                return;
            }
            if (type == 2) {
//                [[zHud shareInstance]showMessage:@"功能开发中"];
                zGoodsMangerController * yaoqing = [[zGoodsMangerController alloc]init];
                yaoqing.title = @"我关注的货源";
                yaoqing.showNav = YES;
                [weakSelf.navigationController pushViewController:yaoqing animated:YES];
                return;
            }
            if (type == 3) {
//                [[zHud shareInstance]showMessage:@"功能开发中"];
                zCompanyController * yaoqing = [[zCompanyController alloc]init];
                yaoqing.title = @"我的经销商";
                yaoqing.showNav = YES;
                [weakSelf.navigationController pushViewController:yaoqing animated:YES];
                return;
            }
            if (type == 4) {
                zUserDetailController * yaoqing = [[zUserDetailController alloc]init];
                yaoqing.title = @"个人信息";
                [weakSelf.navigationController pushViewController:yaoqing animated:YES];
                return;
            }
        };
    }
    return _userinfoCard;
}
-(zInstructionsCard*)instructionCard
{
    if (!_instructionCard) {
        _instructionCard = [[zInstructionsCard alloc]init];
    }
    return _instructionCard;
}
-(zCategoryCard*)categoryCard
{
    if (!_categoryCard) {
        __weak typeof(self)weakSelf = self;
        _categoryCard = [[zCategoryCard alloc]init];
        _categoryCard.categoryTapBack = ^(NSInteger type) {
            if (type == 0) {
                zPersonalController * persoanl = [[zPersonalController alloc]init];
                persoanl.title = @"基本信息";
                [weakSelf.navigationController pushViewController:persoanl animated:YES];
                return;
            }
            if (type == 1) {
                zUserDescController * userDesc = [[zUserDescController alloc]init];
                userDesc.title = @"个人信息";
                [weakSelf.navigationController pushViewController:userDesc animated:YES];
                return;
            }
            if (type == 2) {
                zJiaoliuController * jlVC = [[zJiaoliuController alloc]init];
                jlVC.title = @"联系人";
                [weakSelf.navigationController pushViewController:jlVC animated:YES];
            }
            if (type == 3) {
                zInviteController * inviter = [[zInviteController alloc]init];
                inviter.title = @"邀请好友";
                [weakSelf.navigationController pushViewController:inviter animated:YES];
            }
            if (type == 4) {
                zCallBackController * zcallBack = [[zCallBackController alloc]init];
                zcallBack.title = @"意见反馈";
                [weakSelf.navigationController pushViewController:zcallBack animated:YES];
            }
            if (type == 5) {
                [[zHud shareInstance]showMessage:@"阿猿正在玩命开发中，敬请期待..."];
            }
            
        };
    }
    return _categoryCard;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.imageBaseView];
    [self.imageBaseView addSubview:self.settingButton];
    [self.view addSubview:self.userinfoCard];
    [self.view addSubview:self.instructionCard];
    [self.view addSubview:self.categoryCard];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//    });
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.imageBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kWidthFlot(196));
    }];
    [self.settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kWidthFlot(20));
        make.top.mas_equalTo(KstatusBarHeight+20);
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(35), kWidthFlot(35)));
    }];
    [self.userinfoCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(20));
        make.right.mas_equalTo(-kWidthFlot(20));
        make.top.mas_equalTo(kWidthFlot(90));
        make.height.mas_equalTo(kWidthFlot(210));
    }];
    
    [self.instructionCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(20));
        make.right.mas_equalTo(-kWidthFlot(20));
        make.top.mas_equalTo(self.userinfoCard.mas_bottom).offset(kWidthFlot(15));
        make.height.mas_equalTo(kWidthFlot(60));
    }];
    [self.categoryCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(20));
        make.right.mas_equalTo(-kWidthFlot(20));
        make.top.mas_equalTo(self.instructionCard.mas_bottom).offset(kWidthFlot(15));
        make.height.mas_equalTo(kWidthFlot(210));
    }];

    [self.imageBaseView setNeedsLayout];
       [self.imageBaseView layoutIfNeeded];
       UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.imageBaseView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(15, 15)];
       CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
       maskLayer.frame = self.imageBaseView.bounds;
       maskLayer.path = maskPath.CGPath;
       self.imageBaseView.layer.mask = maskLayer;
}

//设置
-(void)settting{
    zSettingViewController  * setting = [[zSettingViewController alloc]init];
    setting.title = @"设置";
    [self.navigationController pushViewController:setting animated:YES];
}

-(void)RequsetFileWithUrl:(NSString*)url WithError:(NSError*)err
{
    if ([url containsString:kgetUserInfo]) {
        [[zHud shareInstance]showMessage:@"获取用户信息失败"];
        return;
    }
}

-(void)RequsetSuccessWithData:(id)data AndUrl:(NSString*)url
{
    if ([url containsString:kgetUserInfo]) {
        NSDictionary * dic = data;
//        NSLog(@"验证码成功%@",dic);
        NSString * msg = dic[@"msg"];
        NSString * code = dic[@"code"];
        
        if ([code integerValue] == 0) {
            //请求成功
            NSArray * citys = dic[@"provinceList"];
            NSMutableArray * cityArray = [NSMutableArray array];
            [citys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary * dic = citys[idx];
                zListTypeModel * typeModel = [zListTypeModel mj_objectWithKeyValues:dic];
//                typeModel.select = NO;
                [cityArray addObject:typeModel];
            }];
            NSDictionary * userInfoDic = dic[@"list"];

            zUserCenterModel * userModel = [zUserCenterModel mj_objectWithKeyValues:userInfoDic];
            [zEducationRankTypeInfo shareInstance].citys = cityArray;
            [zEducationRankTypeInfo shareInstance].userInfoModel = userModel;
            self.userinfoCard.userCenterModel = userModel;
        }else
        {
            [[zHud shareInstance]showMessage:msg];
        }
        
    }
    
    if ([url containsString:kpersonalBusiness]) {
        NSDictionary * dic = data;
        NSString * msg = dic[@"msg"];
        NSString * code = dic[@"code"];
        if ([code integerValue] == 0) {
            
            NSString * inviteNumber = dic[@"data"][@"inviteNumber"];
            NSString * goodsNumber = dic[@"data"][@"productNumber"];
            NSString * businessNumber = dic[@"data"][@"providerNumber"];
            
             self.userinfoCard.myNumbers = [NSString stringWithFormat:@"%@",inviteNumber];
            
            self.userinfoCard.mygoodsNumbers = [NSString stringWithFormat:@"%@",goodsNumber];
            
            self.userinfoCard.mybusinessNumbers = [NSString stringWithFormat:@"%@",businessNumber];
            
        }
    }
}


@end
