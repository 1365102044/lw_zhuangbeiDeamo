//
//  zMyfriendDetailCell.m
//  ZhuangBei
//
//  Created by aa on 2020/5/19.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zMyfriendDetailCell.h"

@interface zMyfriendDetailCell ()

@property(strong,nonatomic)UIView * baseView;

@property(strong,nonatomic)UIButton * nameButton;

@property(strong,nonatomic)UILabel * descLabel;


@end

@implementation zMyfriendDetailCell

+(zMyfriendDetailCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath
{
    static NSString * cellID = @"zMyfriendDetailCell";
    zMyfriendDetailCell * cell = [[zMyfriendDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIView*)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc]init];
        _baseView.backgroundColor = [UIColor whiteColor];
        _baseView.layer.borderColor = [UIColor colorWithHexString:@"#353535"].CGColor;
        _baseView.layer.borderWidth = 0.5;
        _baseView.layer.cornerRadius = 5;
        _baseView.clipsToBounds = YES;
    }
    return _baseView;
}


-(UIButton*)nameButton
{
    if (!_nameButton) {
        _nameButton = [[UIButton alloc]init];
        _nameButton.userInteractionEnabled = NO;
        _nameButton.tag = 1;
        [_nameButton setTitleColor:[UIColor colorWithHexString:@"#353535"] forState:UIControlStateNormal];
        [_nameButton setImage:[UIImage imageNamed:@"wode_sex"] forState:UIControlStateNormal];
        _nameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _nameButton.clipsToBounds = YES;
    }
    return _nameButton;
}

-(UILabel*)descLabel
{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc]init];
        _descLabel.font = kFont(kWidthFlot(18));
        _descLabel.textColor = [UIColor colorWithHexString:@"#353535"];
        _descLabel.numberOfLines = 0;
    }
    return _descLabel;
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.baseView];
        [self.baseView addSubview:self.nameButton];
        [self.baseView addSubview:self.descLabel];
        [self updateConstraintsForView];
    }
    return self;
}

-(void)updateConstraintsForView
{
    CGFloat left = kWidthFlot(15);
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.nameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kWidthFlot(10));
        make.left.mas_equalTo(left);
        make.width.mas_equalTo(kWidthFlot(100));
        make.height.mas_equalTo(kWidthFlot(30));
        make.bottom.mas_equalTo(-kWidthFlot(10));
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.nameButton.mas_centerY);
        make.right.mas_equalTo(-left);
        make.left.mas_equalTo(self.nameButton.mas_right).offset(10);
        make.height.mas_equalTo(kWidthFlot(30));
    }];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
       
    }else
    {
       
    }
}

@end
