//
//  LoginTextField.m
//  ZhuangBei
//
//  Created by aa on 2020/4/22.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LoginTextField.h"

@interface LoginTextField ()

@property(strong, nonatomic)UIImageView *iconView;

@property(strong, nonatomic)UIButton *btnClear;

@property(strong, nonatomic)UIView *lineView;

@end

@implementation LoginTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
        _iconView = [[UIImageView alloc]init];
        _btnClear = [[UIButton alloc]init];
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor blackColor];
        [_btnClear setImage:[UIImage imageNamed:@"login_btn_shanchu"] forState:UIControlStateNormal];
        [self addSubview:_iconView];
        [self addSubview:_btnClear];
        [self addSubview:self.lineView];
        
        self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kWidthFlot(50), 0)];
        self.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kWidthFlot(12), 0)];
        [self setLeftViewMode:(UITextFieldViewModeAlways)];
        [self setRightViewMode:(UITextFieldViewModeAlways)];
//        self.layer.borderColor = [kMainSingleton colorWithHexString:@"#D1D4D8" alpha:1].CGColor;
//        self.layer.borderWidth = 1;
//        self.layer.cornerRadius = kWidthFlot(4);
        
        [_btnClear addTarget:self action:@selector(actionClear:) forControlEvents:(UIControlEventTouchUpInside)];
        
        _btnClear.hidden = YES;
        
        [self addTarget:self action:@selector(actionChange:) forControlEvents:(UIControlEventEditingChanged)];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(12));
        make.centerY.mas_equalTo(self);
    }];
    [_btnClear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-kWidthFlot(12));
        make.centerY.mas_equalTo(self);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconView.mas_right).offset(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}


#pragma mark - action
- (void)actionChange:(id)sender {
    _btnClear.hidden = self.text.length == 0;
}

- (void)actionClear:(id)sender {
    self.text = @"";
    self.btnClear.hidden = YES;
}


#pragma mark - getter and setter
- (void)setMyPlaceHolder:(NSString *)myPlaceHolder {
    _myPlaceHolder = myPlaceHolder;    
    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:myPlaceHolder attributes:@{NSForegroundColorAttributeName : [kMainSingleton colorWithHexString:@"#9B9B9B" alpha:1], NSFontAttributeName: kFont(14)}];
    self.attributedPlaceholder = placeholderString;
}

- (void)setIcon:(UIImage *)icon {
    _icon = icon;
    _iconView.image = icon;
}




@end
