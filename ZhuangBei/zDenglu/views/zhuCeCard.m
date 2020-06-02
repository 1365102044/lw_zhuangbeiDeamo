//
//  zhuCeCard.m
//  ZhuangBei
//
//  Created by aa on 2020/4/25.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zhuCeCard.h"
#import "LoginTextField.h"
#import "phoneNumCheck.h"

#define  heightMargin 45
#define  leftMargin 25

#define NUM @"0123456789"
#define ALPHA @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

@interface zhuCeCard ()<UITextFieldDelegate>

@property(strong,nonatomic)NSArray * labelTitleArray;

@property(strong,nonatomic)NSMutableArray * labelArray;

@property(strong,nonatomic)LoginTextField * nameField;
@property(strong,nonatomic)LoginTextField * accountField;
@property(strong,nonatomic)LoginTextField * passwordField;
@property(strong,nonatomic)LoginTextField * checkField;
@property(strong,nonatomic)LoginTextField * inviteField;

@property(strong,nonatomic)UIButton * eyesButton;
@property(strong,nonatomic)UIButton * getCheckNumButton;
@property(strong,nonatomic)UIButton * loginBtn;

@property(strong,nonatomic)UIButton * aggreBtn;//同意
@property(strong,nonatomic)UILabel * userKnow;//用户须知

@property(strong,nonatomic)TYAttributedLabel*gotoLoginLabel;

@property(strong,nonatomic)NSMutableDictionary * userDic;

@end

@implementation zhuCeCard


-(NSMutableDictionary*)userDic
{
    if (!_userDic) {
        _userDic = [NSMutableDictionary dictionary];
    }
    return _userDic;
}

-(NSArray*)labelTitleArray
{
    if (!_labelTitleArray) {
        _labelTitleArray = @[@"姓名：",@"手机号：",@"密码：",@"验证码：",@"邀请码："];
    }
    return _labelTitleArray;
}

-(NSMutableArray*)labelArray
{
    if (!_labelArray) {
        _labelArray = [NSMutableArray array];
    }
    return _labelArray;
}

-(LoginTextField*)nameField
{
    if (!_nameField) {
        _nameField = [[LoginTextField alloc]init];
        _nameField.icon = [UIImage imageNamed:@"blank"];
        _nameField.keyboardType = UIKeyboardTypeDefault;
        _nameField.maxLength = 11;
        _nameField.myPlaceHolder = @"请输入姓名";
    }
    return _nameField;
}

-(LoginTextField*)accountField
{
    if (!_accountField) {
        _accountField = [[LoginTextField alloc]init];
        _accountField.icon = [UIImage imageNamed:@"blank"];
        _accountField.keyboardType = UIKeyboardTypePhonePad;
        _accountField.maxLength = 11;
        _accountField.myPlaceHolder = @"请输入账号";
    }
    return _accountField;
}

-(LoginTextField*)passwordField
{
    if (!_passwordField) {
        _passwordField = [[LoginTextField alloc]init];
        _passwordField.delegate = self;
        _passwordField.icon = [UIImage imageNamed:@"blank"];
        _passwordField.keyboardType = UIKeyboardTypeASCIICapable;
        _passwordField.maxLength = 12;
        [_passwordField setSecureTextEntry:YES];
        _passwordField.myPlaceHolder = @"请输入密码";
    }
    return _passwordField;
}


-(LoginTextField*)checkField
{
    if (!_checkField) {
        _checkField = [[LoginTextField alloc]init];
        _checkField.icon = [UIImage imageNamed:@"blank"];
        _checkField.keyboardType = UIKeyboardTypeASCIICapable;
        _checkField.maxLength = 11;
        _checkField.myPlaceHolder = @"请输入验证码";
    }
    return _checkField;
}

-(LoginTextField*)inviteField
{
    if (!_inviteField) {
        _inviteField = [[LoginTextField alloc]init];
        _inviteField.icon = [UIImage imageNamed:@"blank"];
        _inviteField.keyboardType = UIKeyboardTypeASCIICapable;
        _inviteField.maxLength = 11;
        _inviteField.myPlaceHolder = @"请输入邀请码（选填）";
    }
    return _inviteField;
}

-(UIButton*)eyesButton
{
    if (!_eyesButton) {
        _eyesButton = [[UIButton alloc]init];
        [_eyesButton setImage:[UIImage imageNamed:@"eye_close"] forState:UIControlStateNormal];
        [_eyesButton setImage:[UIImage imageNamed:@"eye_open"] forState:UIControlStateSelected];
        _eyesButton.tag = 1;
        [_eyesButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _eyesButton;
}

-(UIButton*)getCheckNumButton
{
    if (!_getCheckNumButton) {
        _getCheckNumButton = [[UIButton alloc]init];
        _getCheckNumButton.titleLabel.font = kFont(14);
        [_getCheckNumButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _getCheckNumButton.tag = 2;
        [_getCheckNumButton setTitle:@"获取" forState:UIControlStateNormal];
        [_getCheckNumButton setBackgroundColor:[kMainSingleton colorWithHexString:@"#3F50B5" alpha:1]];
        [_getCheckNumButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getCheckNumButton;
}

-(UIButton*)aggreBtn
{
    if (!_aggreBtn) {
        _aggreBtn = [[UIButton alloc]init];
        _aggreBtn.titleLabel.font = kFont(14);
        [_aggreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_aggreBtn setImage:[UIImage imageNamed:@"chose_normal"] forState:UIControlStateNormal];
        [_aggreBtn setImage:[UIImage imageNamed:@"chose_select"] forState:UIControlStateSelected];
        _aggreBtn.tag = 3;
        [_aggreBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _aggreBtn;
}

-(UIButton*)loginBtn
{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc]init];
        _loginBtn.titleLabel.font = kFont(20);
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn setTitle:@"注册" forState:UIControlStateNormal];
        _loginBtn.backgroundColor = [kMainSingleton colorWithHexString:@"#3F50B5" alpha:1];
        _loginBtn.layer.cornerRadius = kWidthFlot(20);
        _loginBtn.clipsToBounds = YES;
        _loginBtn.tag = 4;
        [_loginBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}


-(UILabel*)userKnow
{
    if (!_userKnow) {
        _userKnow = [[UILabel alloc]initWithFrame:CGRectMake(0,0,kWidthFlot(100),kWidthFlot(40))];
        _userKnow.userInteractionEnabled = YES;
        _userKnow.font = kFont(12);
        NSString * labelStr = @"我同意《用户注册协议》";
        NSString * book = @"《用户注册协议》";
//        CGAffineTransform matrix =CGAffineTransformMake(1, 0, tanf(10 * (CGFloat)M_PI / 180), 1, 0, 0);//设置反射。倾斜角度。
//
//        UIFontDescriptor *desc = [ UIFontDescriptor fontDescriptorWithName :[UIFont systemFontOfSize:kWidthFlot(16)].fontName matrix :matrix];//取得系统字符并设置反射。
        
        NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc]initWithString:labelStr];
        //目的是想改变 ‘/’前面的字体的属性，所以找到目标的range
        NSRange range = [labelStr rangeOfString:@"《"];
        NSRange pointRange = NSMakeRange(range.location,book.length);
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[NSFontAttributeName] = kFont(12);
        dic[NSForegroundColorAttributeName] = [kMainSingleton colorWithHexString:@"#3F50B5" alpha:1];
        //赋值
        [attribut addAttributes:dic range:pointRange];
        
        _userKnow.attributedText = attribut;
        _userKnow.numberOfLines = 0;
        
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)];
        [_userKnow addGestureRecognizer:labelTapGestureRecognizer];
    }
    return _userKnow;
}

-(TYAttributedLabel*)gotoLoginLabel
{
    if (!_gotoLoginLabel) {
        _gotoLoginLabel = [[TYAttributedLabel alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,kWidthFlot(40))];
        _gotoLoginLabel.userInteractionEnabled = YES;
        _gotoLoginLabel.numberOfLines = 1;
        NSString * labelStr = @"已有账号！立即去登录";
        NSString * num = @"去登录";
         TYTextContainer *textStorage = [self creatTextContainerWithCurrentStr:num totalStr:labelStr];
        _gotoLoginLabel.textContainer = textStorage;
        [self updateTYTLabel:_gotoLoginLabel];
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goLoginVC)];
        [_gotoLoginLabel addGestureRecognizer:labelTapGestureRecognizer];
    }
    return _gotoLoginLabel;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        for (int i=0; i<self.labelTitleArray.count; i++) {
            UILabel * nameLabel = [[UILabel alloc]init];
            nameLabel.textColor = [UIColor blackColor];
            nameLabel.font = kFont(18);
            nameLabel.text = self.labelTitleArray[i];
            nameLabel.numberOfLines = 0;
            [self addSubview:nameLabel];
            [self.labelArray addObject:nameLabel];
        }
        
        [self addSubview:self.nameField];
        [self addSubview:self.accountField];
        [self addSubview:self.passwordField];
        [self addSubview:self.checkField];
        [self addSubview:self.inviteField];
        
        [self addSubview:self.eyesButton];
        [self addSubview:self.getCheckNumButton];
        
        [self addSubview:self.aggreBtn];
        [self addSubview:self.userKnow];
        
        [self addSubview:self.loginBtn];
        [self addSubview:self.gotoLoginLabel];
        [self updateConstraintsForView];
    }
    return self;
}

-(void)updateConstraintsForView
{
    for (int i = 0; i<self.labelArray.count; i++) {
        UILabel * nameLabel = self.labelArray[i];
        
        CGFloat top = leftMargin + (heightMargin + leftMargin)* i;
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(top);
            make.left.mas_equalTo(leftMargin);
            make.height.mas_equalTo(40);
        }];
    }
    
    [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leftMargin + (heightMargin + leftMargin) * 0);
        make.left.mas_equalTo(kWidthFlot(80));
        make.right.mas_equalTo(-leftMargin);
        make.height.mas_equalTo(40);
    }];
    [self.accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leftMargin + (heightMargin + leftMargin) * 1);
        make.left.mas_equalTo(kWidthFlot(80));
        make.right.mas_equalTo(-leftMargin);
        make.height.mas_equalTo(40);
    }];

    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leftMargin + (heightMargin + leftMargin) * 2);
        make.left.mas_equalTo(kWidthFlot(80));
        make.right.mas_equalTo(-(leftMargin + 40));
        make.height.mas_equalTo(40);
    }];
    
    [self.eyesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.passwordField.mas_centerY);
        make.right.mas_equalTo(-leftMargin);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(30);
    }];

    [self.checkField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leftMargin + (heightMargin + leftMargin) * 3);
        make.left.mas_equalTo(kWidthFlot(80));
        make.right.mas_equalTo(-(leftMargin + 80));
        make.height.mas_equalTo(40);
    }];
    
    [self.getCheckNumButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.checkField.mas_bottom);
        make.right.mas_equalTo(-leftMargin);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];

    [self.inviteField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leftMargin + (heightMargin + leftMargin) * 4);
        make.left.mas_equalTo(kWidthFlot(80));
        make.right.mas_equalTo(-leftMargin);
        make.height.mas_equalTo(40);
    }];
    
    [self.userKnow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.inviteField.mas_bottom).offset(10);
        make.right.mas_equalTo(-leftMargin);
        make.height.mas_equalTo(kWidthFlot(30));
    }];
    [self.aggreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.inviteField.mas_bottom).offset(10);
        make.right.mas_equalTo(self.userKnow.mas_left).offset(-1);
        make.height.mas_equalTo(kWidthFlot(30));
        make.width.mas_equalTo(kWidthFlot(30));
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.aggreBtn.mas_bottom).offset(kWidthFlot(40));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(kWidthFlot(285));
        make.height.mas_equalTo(kWidthFlot(45));
    }];
    
    [self.gotoLoginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-kWidthFlot(20));
        make.left.mas_equalTo(kWidthFlot(0));
        make.right.mas_equalTo(-kWidthFlot(0));
        make.height.mas_equalTo(kWidthFlot(40));
    }];
}

-(void)buttonClick:(UIButton*)button
{
    if (button.tag == 1) {
        //眼睛
        self.eyesButton.selected = !button.selected;
        [self.passwordField setSecureTextEntry:!self.eyesButton.selected];
        return;
    }
    if (button.tag == 2) {
        //验证码
        BOOL rightNum = [phoneNumCheck validateMobile:self.accountField.text];
        if (rightNum) {
            if (self.getMessageCodeTapBack) {
                self.getMessageCodeTapBack(self.accountField.text);
            }
            [self daojishi];
        }else
        {
            [[zHud shareInstance]showMessage:@"请输入正确的手机号"];
        }
        return;
    }
    if (button.tag == 3) {
        self.aggreBtn.selected = !button.selected;
        return;
    }
    if (button.tag == 4) {
        //注册
        if (self.nameField.text.length==0) {
            [[zHud shareInstance]showMessage:@"姓名不可为空"];
            return;
        }
        if (self.accountField.text.length==0) {
            [[zHud shareInstance]showMessage:@"手机号不可为空"];
            return;
        }
        if (self.passwordField.text.length<6) {
            [[zHud shareInstance]showMessage:@"请输入至少6位数密码"];
            return;
        }
        if (self.checkField.text.length==0) {
            [[zHud shareInstance]showMessage:@"验证码不可为空"];
            return;
        }
        
        NSString * password = self.passwordField.text;
        [self.userDic setObject:self.nameField.text forKey:@"nickName"];
        [self.userDic setObject:self.accountField.text forKey:@"username"];
        [self.userDic setObject:password forKey:@"password"];
        [self.userDic setObject:self.checkField.text forKey:@"verificationCode"];
        [self.userDic setObject:self.inviteField.text forKey:@"invatationCode"];
        if (self.aggreBtn.selected) {
            if (self.zhuceBack) {
                self.zhuceBack(self.userDic);
            }
        }else
        {
            [[zHud shareInstance]showMessage:@"需同意用户注册协议"];
        }
    }
}


-(void)daojishi
{
    __block NSInteger second = 60;
       //(1)创建一个队列
       dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
       //(2)创建一个定时器模拟事件源
       dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
       //(3)设置定时间隔
       dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
       //(4)设置定时器响应回调
       dispatch_source_set_event_handler(timer, ^{
           dispatch_async(dispatch_get_main_queue(), ^{
               if (second == 0) {
                   self.getCheckNumButton.userInteractionEnabled = YES;
                   [self.getCheckNumButton setTitle:[NSString stringWithFormat:@"获取"] forState:UIControlStateNormal];
                   second = 60;
                   //(6)取消定时器
                   dispatch_cancel(timer);
               } else {
                   self.getCheckNumButton.userInteractionEnabled = NO;
                   [self.getCheckNumButton setTitle:[NSString stringWithFormat:@"%ldS",second] forState:UIControlStateNormal];
                   second--;
               }
           });
       });
       //(5)启动定时器
       dispatch_resume(timer);

}

//初始化文字信息 设置颜色及点击事件
-(TYTextContainer*)creatTextContainerWithCurrentStr:(NSString*)currentStr totalStr:(NSString*)total
{
    TYTextContainer *textContainer = [[TYTextContainer alloc]init];
//    张九龄
    NSString * string = [currentStr substringFromIndex:currentStr.length];
    NSString * text = total;
    textContainer.text = text;
    
    //取出需要变色的字
    TYTextStorage *textheader = [[TYTextStorage alloc]init];
    textheader.range = [text rangeOfString:currentStr];
    textheader.textColor = [kMainSingleton colorWithHexString:@"#D0021B" alpha:1];
    textheader.font = [UIFont fontWithName:@"TamilSangamMN" size:kWidthFlot(18)];
    [textContainer addTextStorage:textheader];

    //取出剩余的字
    TYTextStorage *textStorage = [[TYTextStorage alloc]init];
    textStorage.range = [text rangeOfString:string];
    textStorage.textColor = [UIColor blackColor];
//    TamilSangamMN-Bold
    textStorage.font = [UIFont fontWithName:@"TamilSangamMN" size:kWidthFlot(16)];
    [textContainer addTextStorage:textStorage];
    textContainer.linesSpacing = 5;
    textContainer = [textContainer createTextContainerWithTextWidth:kWidthFlot(300)];
    return textContainer;
}

-(void)updateTYTLabel:(TYAttributedLabel*)label
{
    // 水平对齐方式
    label.textAlignment = kCTTextAlignmentCenter;
    // 垂直对齐方式
    label.verticalAlignment = TYVerticalAlignmentCenter;
    // 文字间隙
    label.characterSpacing = 2;
    // 文本行间隙
    label.linesSpacing = 2;
}


-(void)labelClick
{
    if (self.xieyiBack) {
        self.xieyiBack(1);
    }
}

-(void)goLoginVC
{
    if (self.backLogin) {
        self.backLogin();
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHANUM] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

@end
