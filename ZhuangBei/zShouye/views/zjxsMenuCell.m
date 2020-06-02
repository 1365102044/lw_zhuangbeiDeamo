//
//  zjxsMenuCell.m
//  ZhuangBei
//
//  Created by aa on 2020/5/8.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zjxsMenuCell.h"

@interface zjxsMenuCell ()

@property(strong,nonatomic)UIButton * arrowButton;

@end

@implementation zjxsMenuCell

+(zjxsMenuCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath
{
    static NSString * cellID = @"zjxsMenuCell";
    zjxsMenuCell * cell = [[zjxsMenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIButton*)arrowButton
{
    if (!_arrowButton) {
        _arrowButton = [[UIButton alloc]init];
        _arrowButton.userInteractionEnabled = NO;
        [_arrowButton setImage:[UIImage imageNamed:@"chose_normal"] forState:UIControlStateNormal];
        [_arrowButton setImage:[UIImage imageNamed:@"chose_select"] forState:UIControlStateSelected];
        _arrowButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _arrowButton.titleLabel.font = [UIFont systemFontOfSize:kWidthFlot(12)];
        [_arrowButton setTitleColor:[UIColor colorWithHexString:@"#4A4A4A"] forState:UIControlStateNormal];
    }
    return _arrowButton;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.arrowButton];
        [self updateConstraintsForView];
    }
    return self;
}

-(void)updateConstraintsForView
{
    [self.arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kWidthFlot(5));
        make.left.mas_equalTo(kWidthFlot(20));
        make.height.mas_equalTo(kWidthFlot(30));
        make.right.mas_equalTo(-kWidthFlot(20));
        make.bottom.mas_equalTo(-kWidthFlot(5));
    }];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.arrowButton layoutIfNeeded];
    [self.arrowButton setNeedsLayout];
    
    [self.arrowButton setIconInLeftWithSpacing:kWidthFlot(5)];
}

-(void)setModel:(zBusinessLoactionModel *)model
{
    _model = model;
    self.arrowButton.selected = model.select;
    [self.arrowButton setTitle:model.title forState:UIControlStateNormal];
    [self.arrowButton setTitle:model.title forState:UIControlStateSelected];
}

//-(void)buttonClick:(UIButton*)button
//{
//    if (self.selectTapBack) {
//        self.selectTapBack(_model);
//    }
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
       
    }else
    {
       
    }
}

@end
