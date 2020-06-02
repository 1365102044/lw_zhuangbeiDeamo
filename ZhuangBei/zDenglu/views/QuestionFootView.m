//
//  QuestionFootView.m
//  ZhuangBei
//
//  Created by aa on 2020/4/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import "QuestionFootView.h"

@interface QuestionFootView ()

@property(strong,nonatomic)UIButton * AddButton;

@end

@implementation QuestionFootView

-(UIButton*)AddButton
{
    if (!_AddButton) {
        _AddButton = [[UIButton alloc]init];
        _AddButton.titleLabel.font = kFont(20);
        [_AddButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_AddButton setTitle:@"提交" forState:UIControlStateNormal];
        _AddButton.backgroundColor = [UIColor blueColor];
        _AddButton.layer.cornerRadius = kWidthFlot(20);
        _AddButton.clipsToBounds = YES;
        _AddButton.tag = 4;
        [_AddButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _AddButton;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.AddButton];
        [self updateConstraintsForView];
    }
    return self;
}

-(void)updateConstraintsForView
{
    [self.AddButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-kWidthFlot(5));
        make.left.mas_equalTo(kWidthFlot(20));
        make.right.mas_equalTo(-kWidthFlot(20));
    }];
}

-(void)buttonClick:(UIButton*)button{
    
    if (self.addAnswerBack) {
        self.addAnswerBack();
    }
}
@end
