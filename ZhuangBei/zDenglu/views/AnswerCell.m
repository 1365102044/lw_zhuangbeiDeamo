//
//  AnswerCell.m
//  chose
//
//  Created by aa on 2019/12/2.
//  Copyright © 2019 aa. All rights reserved.
//

#import "AnswerCell.h"

@interface AnswerCell ()

@property(strong,nonatomic)UIButton * choseBtn;//选择题类型
@property(strong,nonatomic)UILabel * AnswerLabel;//问题描述

@end

@implementation AnswerCell

+(AnswerCell*)creatTableViewCellWithTableView:(UITableView *)tableView AndIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSString * CellID = [NSString stringWithFormat:@"AnswerCell%ld__%ld",indexPath.section,indexPath.row];
    AnswerCell * cell = [[AnswerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIButton*)choseBtn
{
    if (!_choseBtn) {
        _choseBtn = [[UIButton alloc]init];
        [_choseBtn setBackgroundImage:[UIImage imageNamed:@"chose_no"] forState:UIControlStateNormal];
        [_choseBtn setBackgroundImage:[UIImage imageNamed:@"chose_yes"] forState:UIControlStateSelected];
        [_choseBtn addTarget:self action:@selector(selectBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _choseBtn;
}

-(UILabel*)AnswerLabel
{
    if (!_AnswerLabel) {
        _AnswerLabel = [[UILabel alloc]init];
        _AnswerLabel.numberOfLines = 0;
        _AnswerLabel.font = [UIFont systemFontOfSize:16];
        _AnswerLabel.textColor = [UIColor blackColor];
    }
    return _AnswerLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.choseBtn];
        [self.contentView addSubview:self.AnswerLabel];
    }
    return self;
}

-(void)updateConstraintsForView
{
    [self.choseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(20,20));
    }];
    
    [self.AnswerLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
    }];
}


-(void)setAnswerModel:(AnswerModel *)answerModel
{
    _answerModel = answerModel;
    if (_answerModel.ISCHOSE) {
        self.choseBtn.selected = YES;
    }
//    :%@ ,answerModel.optionId
    NSString * answerString = [NSString stringWithFormat:@"%ld.%@ ",answerModel.optionNum,answerModel.optionName];
    [self setAnswerLabelTextWith:answerString];
    [self updateConstraintsForView];
}

-(void)setAnswerLabelTextWith:(NSString*)text
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.alignment = NSTextAlignmentLeft;  //对齐
    paraStyle.headIndent = 0.0f;//行首缩进
    //参数：（字体大小17号字乘以2，34f即首行空出两个字符）
    paraStyle.tailIndent = 0.0f;//行尾缩进
    paraStyle.lineSpacing = 2.0f;//行间距
    
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:text attributes:@{NSParagraphStyleAttributeName:paraStyle}];
    
    self.AnswerLabel.attributedText = attrText;
}


-(void)selectBtnClick
{
    if (self.upDataSelectAnswerBack) {
        self.upDataSelectAnswerBack(self.answerModel);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
//    self.choseBtn.selected  = selected;
//    if (selected) {
//
//    }else
//    {
//        
//    }

}

@end
