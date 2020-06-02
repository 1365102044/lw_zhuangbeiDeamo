//
//  QuestionHeaderView.m
//  chose
//
//  Created by aa on 2019/12/2.
//  Copyright © 2019 aa. All rights reserved.
//

#import "QuestionHeaderView.h"
#import "Masonry.h"

@interface QuestionHeaderView ()

@property(strong,nonatomic)UIButton * typeBtn;//选择题类型
@property(strong,nonatomic)UILabel * QuestionLabel;//问题描述

@end

@implementation QuestionHeaderView

-(UIButton*)typeBtn
{
    if (!_typeBtn) {
        _typeBtn = [[UIButton alloc]init];
        _typeBtn.layer.borderWidth = 1;
        _typeBtn.layer.borderColor = [UIColor orangeColor].CGColor;
        _typeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_typeBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }
    return _typeBtn;
}

-(UILabel*)QuestionLabel
{
    if (!_QuestionLabel) {
        _QuestionLabel = [[UILabel alloc]init];
        _QuestionLabel.numberOfLines = 0;
        _QuestionLabel.font = [UIFont systemFontOfSize:16];
        _QuestionLabel.textColor = [UIColor blackColor];
    }
    return _QuestionLabel;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.typeBtn];
        [self addSubview:self.QuestionLabel];
    }
    return self;
}
-(void)updateConstraintsForView
{
    [self.typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(50,20));
    }];
    
    [self.QuestionLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
    }];
}

-(void)setQuestionModel:(QuestionModel *)questionModel
{
    if ([questionModel.questionType isEqualToString:@"danxt"]) {
//        单选题
        [self.typeBtn setTitle:@"单选题" forState:UIControlStateNormal];
    }else
    {
//        多选题
//        [self.typeBtn setTitle:@"多选题" forState:UIControlStateNormal];
    }
//    :%@,questionModel.questionId
    NSString * question = [NSString stringWithFormat:@"%@",questionModel.questionName];
    
    [self setQuestionLabelTextWith:question];
    
    [self updateConstraintsForView];
}

-(void)setQuestionLabelTextWith:(NSString*)text
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.alignment = NSTextAlignmentLeft;  //对齐
    paraStyle.headIndent = 0.0f;//行首缩进
    //参数：（字体大小17号字乘以2，34f即首行空出两个字符）
    CGFloat emptylen = self.QuestionLabel.font.pointSize * 4;
    paraStyle.firstLineHeadIndent = emptylen;//首行缩进
    paraStyle.tailIndent = 0.0f;//行尾缩进
    paraStyle.lineSpacing = 2.0f;//行间距
    
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:text attributes:@{NSParagraphStyleAttributeName:paraStyle}];
    
    self.QuestionLabel.attributedText = attrText;
}


@end
