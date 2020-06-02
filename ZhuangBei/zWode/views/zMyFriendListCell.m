//
//  zMyFriendListCell.m
//  ZhuangBei
//
//  Created by aa on 2020/5/19.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zMyFriendListCell.h"



@interface zMyFriendListCell ()

@property(strong,nonatomic)UIView * baseView;

@property(strong,nonatomic)UIButton * headerImageBtn;

@property(strong,nonatomic)UIButton * nameButton;

@property(strong,nonatomic)UILabel * descLabel;

@property(strong,nonatomic)UIButton * emailButton;

@property(strong,nonatomic)UIButton * phoneButton;

@end

@implementation zMyFriendListCell

+(zMyFriendListCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath
{
    static NSString * cellID = @"zMyFriendListCell";
    zMyFriendListCell * cell = [[zMyFriendListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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

-(UIButton*)headerImageBtn
{
    if (!_headerImageBtn) {
        _headerImageBtn = [[UIButton alloc]init];
        _headerImageBtn.userInteractionEnabled = NO;
        _headerImageBtn.tag = 1;
        _headerImageBtn.layer.cornerRadius = kWidthFlot(50);
        _headerImageBtn.clipsToBounds = YES;
        [_headerImageBtn setBackgroundImage:[UIImage imageNamed:@"wode_defoutHeader"] forState:UIControlStateNormal];
    }
    return _headerImageBtn;
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

-(UIButton*)emailButton
{
    if (!_emailButton) {
        _emailButton = [[UIButton alloc]init];
        _emailButton.userInteractionEnabled = NO;
        [_emailButton setTitleColor:[UIColor colorWithHexString:@"#515151"] forState:UIControlStateNormal];
        _emailButton.tag = 1;
        _emailButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_emailButton setImage:[UIImage imageNamed:@"fenge"] forState:UIControlStateNormal];
        _emailButton.clipsToBounds = YES;
    }
    return _emailButton;
}

-(UIButton*)phoneButton
{
    if (!_phoneButton) {
        _phoneButton = [[UIButton alloc]init];
        _phoneButton.userInteractionEnabled = NO;
        _phoneButton.tag = 1;
        [_phoneButton setTitleColor:[UIColor colorWithHexString:@"#515151"] forState:UIControlStateNormal];
        _phoneButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_phoneButton setImage:[UIImage imageNamed:@"fenge"] forState:UIControlStateNormal];
        _phoneButton.clipsToBounds = YES;
    }
    return _phoneButton;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.baseView];
        [self.baseView addSubview:self.headerImageBtn];
        [self.baseView addSubview:self.nameButton];
        [self.baseView addSubview:self.descLabel];
        [self.baseView addSubview:self.emailButton];
        [self.baseView addSubview:self.phoneButton];
        [self updateConstraintsForView];
    }
    return self;
}

-(void)updateConstraintsForView
{
    CGFloat left = kWidthFlot(15);
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10,0,10));
    }];
    [self.headerImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-left);
        make.top.mas_equalTo(left);
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(100), kWidthFlot(100)));
    }];
    
    [self.nameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kWidthFlot(50));
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(-kWidthFlot(150));
        make.height.mas_equalTo(kWidthFlot(50));
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameButton.mas_bottom).offset(kWidthFlot(10));
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(-kWidthFlot(150));
    }];
    
    [self.emailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.descLabel.mas_bottom).offset(kWidthFlot(10));
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(-kWidthFlot(50));
        make.height.mas_equalTo(kWidthFlot(30));
    }];
    
    [self.phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.emailButton.mas_bottom).offset(kWidthFlot(10));
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(-kWidthFlot(150));
        make.height.mas_equalTo(kWidthFlot(30));
        make.bottom.mas_equalTo(-kWidthFlot(10));
    }];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.nameButton setNeedsLayout];
    [self.nameButton layoutIfNeeded];
    
    [self.emailButton setNeedsLayout];
    [self.emailButton layoutIfNeeded];
    
    [self.phoneButton setNeedsLayout];
    [self.phoneButton layoutIfNeeded];
    
    [self.nameButton setIconInRight];
    [self.emailButton setIconInLeft];
    [self.phoneButton setIconInLeft];
}

-(void)setModel:(zFriendsModel *)model
{
    _model = model;
    [self.nameButton setTitle:model.userName forState:UIControlStateNormal];
    
    self.descLabel.text = model.minsummary;
    
    [self.emailButton setTitle:[NSString stringWithFormat:@"邮箱：%@",model.email] forState:UIControlStateNormal];
    
    [self.phoneButton setTitle:[NSString stringWithFormat:@"电话：%@",model.mobile] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
       
    }else
    {
       
    }
}

@end


