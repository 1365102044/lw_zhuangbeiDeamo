//
//  zHuoYuanListCell.m
//  ZhuangBei
//
//  Created by aa on 2020/5/7.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zHuoYuanListCell.h"

@interface zHuoYuanListCell ()

@property(strong,nonatomic)UIView * baseView;

@property(strong,nonatomic)UIImageView * baseImageView;

@property(strong,nonatomic)UIButton * arrowButton;

@property(strong,nonatomic)UILabel * nameLabel;

@property(strong,nonatomic)UILabel * farenLabel;

@property(strong,nonatomic)UILabel * phoneLabel;

@property(strong,nonatomic)UILabel * descLabel;

@end

@implementation zHuoYuanListCell

+(zHuoYuanListCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath
{
    static NSString * cellID = @"zHuoYuanListCell";
    zHuoYuanListCell * cell = [[zHuoYuanListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIView*)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc]init];
        _baseView.layer.borderColor = [UIColor colorWithHexString:@"#DDDDDD"].CGColor;
        _baseView.layer.borderWidth = 1;
        _baseView.layer.cornerRadius = kWidthFlot(8);
    }
    return _baseView;
}

-(UIImageView*)baseImageView
{
    if (!_baseImageView) {
        _baseImageView = [[UIImageView alloc]init];
        _baseImageView.image = [UIImage imageNamed:@"testicon"];
    }
    return _baseImageView;
}

-(UIButton*)arrowButton
{
    if (!_arrowButton) {
        _arrowButton = [[UIButton alloc]init];
        [_arrowButton setImage:[UIImage imageNamed:@"huoyuan_kefu"] forState:UIControlStateNormal];
        [_arrowButton setImage:[UIImage imageNamed:@"huoyuan_kefu"] forState:UIControlStateNormal];
        _arrowButton.titleLabel.font = [UIFont systemFontOfSize:kWidthFlot(12)];
        [_arrowButton setTitleColor:[UIColor colorWithHexString:@"#4A4A4A"] forState:UIControlStateNormal];
    }
    return _arrowButton;
}

-(UILabel*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = kFont(12);
        _nameLabel.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
        _nameLabel.numberOfLines = 1;
        _nameLabel.text = @"北京和为永泰";
    }
    return _nameLabel;
}

-(UILabel*)farenLabel
{
    if (!_farenLabel) {
        _farenLabel = [[UILabel alloc]init];
        _farenLabel.font = kFont(12);
        _farenLabel.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
        _farenLabel.numberOfLines = 1;
        _farenLabel.text = @"法人：费云健";
    }
    return _farenLabel;
}

-(UILabel*)phoneLabel
{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.font = kFont(12);
        _phoneLabel.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
        _phoneLabel.numberOfLines = 1;
        _phoneLabel.text = @"电话：010-5269882223";
    }
    return _phoneLabel;
}

-(UILabel*)descLabel
{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc]init];
        _descLabel.font = kFont(12);
        _descLabel.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
        _descLabel.numberOfLines = 1;
        _descLabel.text = @"简介：北京和为永泰科技股份有限公司";
    }
    return _descLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.baseView];
        [self.baseView addSubview:self.baseImageView];
        [self.baseView addSubview:self.arrowButton];
        [self.baseView addSubview:self.nameLabel];
        [self.baseView addSubview:self.farenLabel];
        [self.baseView addSubview:self.phoneLabel];
        [self.baseView addSubview:self.descLabel];
        [self updateConstraintsForView];
    }
    return self;
}

-(void)updateConstraintsForView
{
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(10));
        make.right.mas_equalTo(-kWidthFlot(20));
        make.top.mas_equalTo(kWidthFlot(5));
        make.bottom.mas_equalTo(-kWidthFlot(5));
        make.height.mas_equalTo(kWidthFlot(118));
    }];
    
    [self.baseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [self.arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kWidthFlot(7));
        make.right.mas_equalTo(-kWidthFlot(15));
        make.height.mas_equalTo(kWidthFlot(25));
        make.width.mas_equalTo(kWidthFlot(25));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(5));
        make.top.mas_equalTo(kWidthFlot(10));
        make.right.mas_equalTo(-kWidthFlot(20));
        make.height.mas_equalTo(kWidthFlot(17));
    }];
    
    [self.farenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(5));
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(kWidthFlot(7));
        make.right.mas_equalTo(-kWidthFlot(20));
        make.height.mas_equalTo(kWidthFlot(17));
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(5));
        make.top.mas_equalTo(self.farenLabel.mas_bottom).offset(kWidthFlot(7));
        make.right.mas_equalTo(-kWidthFlot(20));
        make.height.mas_equalTo(kWidthFlot(17));
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(5));
        make.top.mas_equalTo(self.phoneLabel.mas_bottom).offset(kWidthFlot(7));
        make.right.mas_equalTo(-kWidthFlot(20));
        make.height.mas_equalTo(kWidthFlot(17));
    }];
}

-(void)setName:(NSString *)name
{
    [self.arrowButton setTitle:name forState:UIControlStateNormal];
}

-(void)setModel:(zGoodsContentModel *)model
{
    _model = model;
    self.nameLabel.text = model.name;
    self.farenLabel.text = [NSString stringWithFormat:@"法人：%@",model.faRen];
    self.phoneLabel.text = [NSString stringWithFormat:@"电话：%@",model.phone];
    self.descLabel.text = [NSString stringWithFormat:@"简介："];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
       
    }else
    {
       
    }
}

@end
