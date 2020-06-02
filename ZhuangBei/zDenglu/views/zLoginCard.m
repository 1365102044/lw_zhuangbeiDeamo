//
//  loginCard.m
//  ZhuangBei
//
//  Created by aa on 2020/4/25.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zLoginCard.h"
#import "LoginTextField.h"
#import "zDengluRequst.h"
#import "phoneNumCheck.h"
#import "zUserInfo.h"

@interface zLoginCard ()

@property(strong,nonatomic)UIImageView * imageBaseView;

@property(strong,nonatomic)UIImageView * logoImage;

@property(strong,nonatomic)UIImageView * smallLogoImage;


@property(strong,nonatomic)UIView * baseView;
@property(strong,nonatomic)LoginTextField * accountField;
@property(strong,nonatomic)LoginTextField * passWordField;

@property(strong,nonatomic)UIButton * showPasswordBtn;
@property(strong,nonatomic)UIButton * remmberPasswordBtn;
@property(strong,nonatomic)UIButton * loginBtn;
@property(strong,nonatomic)UIButton * fogetBtn;

@property(strong,nonatomic)UIButton * reginstBtn;

@end

@implementation zLoginCard

-(UIImageView*)imageBaseView
{
    if (!_imageBaseView) {
        _imageBaseView = [[UIImageView alloc]init];
        _imageBaseView.backgroundColor = [kMainSingleton colorWithHexString:@"#3F50B5" alpha:1];
    }
    return _imageBaseView;;
}

-(UIImageView*)logoImage
{
    if (!_logoImage) {
        _logoImage = [[UIImageView alloc]init];
        _logoImage.image = [UIImage imageNamed:@"LOGO"];
        _logoImage.contentMode = UIViewContentModeScaleAspectFill;
        _logoImage.alpha = 0.3;
    }
    return _logoImage;;
}

-(UIImageView*)smallLogoImage
{
    if (!_smallLogoImage) {
        _smallLogoImage = [[UIImageView alloc]init];
        _smallLogoImage.image = [UIImage imageNamed:@"LOGO"];
        _smallLogoImage.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _smallLogoImage;;
}



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

-(LoginTextField*)accountField
{
    if (!_accountField) {
        _accountField = [[LoginTextField alloc]init];
        _accountField.icon = [UIImage imageNamed:@"zAccount"];
        _accountField.keyboardType = UIKeyboardTypeASCIICapable;
        _accountField.maxLength = 11;
        _accountField.myPlaceHolder = @"请输入账号";
    }
    return _accountField;
}

-(LoginTextField*)passWordField
{
    if (!_passWordField) {
        _passWordField = [[LoginTextField alloc]init];
        _passWordField.icon = [UIImage imageNamed:@"zpass_word"];
        _passWordField.keyboardType = UIKeyboardTypeDefault;
        _passWordField.maxLength = 12;
        _passWordField.secureTextEntry = YES;
        _passWordField.myPlaceHolder = @"请输入密码";
    }
    return _passWordField;
}

-(UIButton*)showPasswordBtn
{
    if (!_showPasswordBtn) {
        _showPasswordBtn = [[UIButton alloc]init];
        _showPasswordBtn.titleLabel.font = kFont(14);
        [_showPasswordBtn setTitleColor:[kMainSingleton colorWithHexString:@"#4A4A4A" alpha:1] forState:UIControlStateNormal];
        _showPasswordBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_showPasswordBtn setImage:[UIImage imageNamed:@"chose_normal"] forState:UIControlStateNormal];
        [_showPasswordBtn setImage:[UIImage imageNamed:@"chose_select"] forState:UIControlStateSelected];
        [_showPasswordBtn setTitle:@"显示密码" forState:UIControlStateNormal];
        _showPasswordBtn.tag = 1;
        [_showPasswordBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showPasswordBtn;
}

-(UIButton*)remmberPasswordBtn
{
    if (!_remmberPasswordBtn) {
        _remmberPasswordBtn = [[UIButton alloc]init];
        _remmberPasswordBtn.titleLabel.font = kFont(14);
        _remmberPasswordBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_remmberPasswordBtn setTitleColor:[kMainSingleton colorWithHexString:@"#4A4A4A" alpha:1] forState:UIControlStateNormal];
        [_remmberPasswordBtn setImage:[UIImage imageNamed:@"chose_normal"] forState:UIControlStateNormal];
        [_remmberPasswordBtn setImage:[UIImage imageNamed:@"chose_select"] forState:UIControlStateSelected];
        [_remmberPasswordBtn setTitle:@"记住密码" forState:UIControlStateNormal];
        _remmberPasswordBtn.tag = 2;
        [_remmberPasswordBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _remmberPasswordBtn;
}

-(UIButton*)loginBtn
{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc]init];
        _loginBtn.titleLabel.font = kFont(18);
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        _loginBtn.backgroundColor = [kMainSingleton colorWithHexString:@"#3F50B5" alpha:1];
        _loginBtn.layer.cornerRadius = kWidthFlot(20);
        _loginBtn.clipsToBounds = YES;
        _loginBtn.tag = 3;
        [_loginBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

-(UIButton*)fogetBtn
{
    if (!_fogetBtn) {
        _fogetBtn = [[UIButton alloc]init];
        _fogetBtn.titleLabel.font = kFont(14);
        [_fogetBtn setTitleColor:[kMainSingleton colorWithHexString:@"#4A4A4A" alpha:1] forState:UIControlStateNormal];
        [_fogetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
        _fogetBtn.tag = 4;
        [_fogetBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fogetBtn;
}

-(UIButton*)reginstBtn
{
    if (!_reginstBtn) {
        _reginstBtn = [[UIButton alloc]init];
        _reginstBtn.titleLabel.font = kFont(18);
        [_reginstBtn setTitleColor:[kMainSingleton colorWithHexString:@"#4A4A4A" alpha:1] forState:UIControlStateNormal];
        [_reginstBtn setTitle:@"新用户注册" forState:UIControlStateNormal];
        _reginstBtn.layer.cornerRadius = kWidthFlot(20);
        _reginstBtn.clipsToBounds = YES;
        _reginstBtn.tag = 5;
        [_reginstBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reginstBtn;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [kMainSingleton colorWithHexString:@"#FAFAFA" alpha:1];
        [self addSubview:self.imageBaseView];
        [self.imageBaseView addSubview:self.logoImage];
        [self.imageBaseView addSubview:self.smallLogoImage];
        [self addSubview:self.baseView];
        [self.baseView addSubview:self.accountField];
        [self.baseView addSubview:self.passWordField];
        [self.baseView addSubview:self.showPasswordBtn];
        [self.baseView addSubview:self.remmberPasswordBtn];
        [self.baseView addSubview:self.loginBtn];
        [self.baseView addSubview:self.fogetBtn];
        [self addSubview:self.reginstBtn];
        [self updateConstraintsForView];
        
        if ([[zUserInfo shareInstance].remmberAccount isEqualToString:@"1"]) {
            self.remmberPasswordBtn.selected = YES;
            self.accountField.text = [zUserInfo shareInstance].userAccount;
            self.passWordField.text = [zUserInfo shareInstance].userPassWord;
        }
    }
    return self;
}

-(void)updateConstraintsForView
{
    [self.imageBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kWidthFlot(290));
    }];
    
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.imageBaseView.mas_centerX);
        make.centerY.mas_equalTo(self.imageBaseView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(200), kWidthFlot(200)));
    }];
    
    [self.smallLogoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.imageBaseView.mas_centerX);
        make.centerY.mas_equalTo(self.imageBaseView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(100), kWidthFlot(100)));
    }];
    
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageBaseView.mas_bottom).offset(-kWidthFlot(80));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.left.mas_equalTo(kWidthFlot(20));
        make.right.mas_equalTo(-kWidthFlot(20));
    }];
    
    [self.accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(35));
        make.right.mas_equalTo(-kWidthFlot(35));
        make.top.mas_equalTo(kWidthFlot(40));
        make.height.mas_equalTo(kWidthFlot(40));
    }];
    
    [self.passWordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.accountField.mas_bottom).offset(kWidthFlot(20));
        make.left.mas_equalTo(kWidthFlot(35));
        make.right.mas_equalTo(-kWidthFlot(35));
        make.height.mas_equalTo(kWidthFlot(40));
    }];
    
    [self.remmberPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passWordField.mas_bottom).offset(kWidthFlot(10));
        make.right.mas_equalTo(-kWidthFlot(20));
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(95), kWidthFlot(20)));
    }];
    
    [self.showPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passWordField.mas_bottom).offset(kWidthFlot(10));
        make.right.mas_equalTo(self.remmberPasswordBtn.mas_left).offset(-10);
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(95), kWidthFlot(20)));
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.showPasswordBtn.mas_bottom).offset(kWidthFlot(70));
        make.centerX.mas_equalTo(self.baseView.mas_centerX);
        make.width.mas_equalTo(kWidthFlot(230));
        make.height.mas_equalTo(kWidthFlot(45));
    }];
    
    [self.fogetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginBtn.mas_bottom).offset(kWidthFlot(10));
        make.centerX.mas_equalTo(self.loginBtn.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(80), kWidthFlot(30)));
        make.bottom.mas_equalTo(-kWidthFlot(10));
    }];
    
    [self.reginstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.baseView.mas_bottom).offset(kWidthFlot(70));
        make.centerX.mas_equalTo(self.loginBtn.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(150), kWidthFlot(40)));
    }];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.showPasswordBtn setNeedsLayout];
    [self.showPasswordBtn layoutIfNeeded];
    [self.showPasswordBtn setIconInLeftWithSpacing:2];
    
    [self.remmberPasswordBtn setNeedsLayout];
    [self.remmberPasswordBtn layoutIfNeeded];
    [self.remmberPasswordBtn setIconInLeftWithSpacing:2];
 
    //背景图下方切圆角
    [self.imageBaseView setNeedsLayout];
    [self.imageBaseView layoutIfNeeded];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.imageBaseView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(15, 15)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.imageBaseView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.imageBaseView.layer.mask = maskLayer;
    
    [_baseView setNeedsLayout];
    [_baseView layoutIfNeeded];
    UIBezierPath *shadowPath = [UIBezierPath
    bezierPathWithRect:_baseView.bounds];
    _baseView.layer.masksToBounds = NO;
    _baseView.layer.shadowColor = [UIColor blackColor].CGColor;
    _baseView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    _baseView.layer.shadowOpacity = 0.1f;
    _baseView.layer.shadowPath = shadowPath.CGPath;
    
    
}

-(void)buttonClick:(UIButton*)button
{
    if (button.tag==1) {
        //显示密码
        self.showPasswordBtn.selected = !button.selected;
        [self.passWordField setSecureTextEntry:!self.showPasswordBtn.selected];
        return;
    }
    if (button.tag==2) {
        //记住密码
        self.remmberPasswordBtn.selected = !button.selected;
        
        if (self.remmberPasswordBtn.selected) {
            [zUserInfo shareInstance].remmberAccount = @"1";
        }else
        {
            [zUserInfo shareInstance].remmberAccount = @"2";
        }
        [[zUserInfo shareInstance] saveUserInfo];
        return;
    }
    if (button.tag==3) {
        //登录
//        BOOL rightNum = [phoneNumCheck validateMobile:self.accountField.text];
//        if (rightNum) {
            if (self.passWordField.text.length>0) {
                if (self.logInBack) {
                    self.logInBack(self.accountField.text,self.passWordField.text,self.remmberPasswordBtn.selected);
                }
            }else
            {
                [[zHud shareInstance]showMessage:@"请输入密码"];
            }
//        }else
//        {
//            [[zHud shareInstance]showMessage:@"请输入正确的手机号"];
//        }
        return;
    }
    if (button.tag==4) {
        //忘记密码
//        if (self.eventBack) {
//            self.eventBack(4);
//        }
        [[zHud shareInstance]showMessage:@"修改密码开发中"];
        return;
    }
    if (button.tag==5) {
        //注册
        if (self.eventBack) {
            self.eventBack(5);
        }
        return;
    }
}

@end
