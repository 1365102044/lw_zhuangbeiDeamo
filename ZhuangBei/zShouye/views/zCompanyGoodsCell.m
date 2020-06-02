//
//  zCompanyGoodsCell.m
//  ZhuangBei
//
//  Created by aa on 2020/5/18.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zCompanyGoodsCell.h"

@interface zCompanyGoodsCell ()

@property(strong,nonatomic)UILabel * NameLabel;

@property(strong,nonatomic)UILabel * contentLabel;

@property(strong,nonatomic)UIView * lineView;

@end

@implementation zCompanyGoodsCell

+(zCompanyGoodsCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath
{
    static NSString * cellID = @"zCompanyGoodsCell";
    zCompanyGoodsCell * cell = [[zCompanyGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UILabel*)NameLabel
{
    if (!_NameLabel) {
        _NameLabel = [[UILabel alloc]init];
        _NameLabel.textAlignment = NSTextAlignmentLeft;
        CGFloat fitSize = kWidthFlot(18);
        _NameLabel.font = kFont(fitSize);
        _NameLabel.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
    }
    return _NameLabel;
}

-(UILabel*)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        CGFloat fitSize = kWidthFlot(14);
        _contentLabel.font = kFont(fitSize);
        _contentLabel.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
    }
    return _contentLabel;
}

-(UIView*)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#4A4A4A"];
    }
    return _lineView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        [self.contentView addSubview:self.NameLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.lineView];
        [self updateConstraintsForView];
    }
    return self;
}


-(void)updateConstraintsForView
{
    [self.NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(kWidthFlot(20));
        make.height.mas_equalTo(kWidthFlot(30));
        make.right.mas_equalTo(-kWidthFlot(20));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.NameLabel.mas_bottom).offset(kWidthFlot(10));
        make.left.mas_equalTo(kWidthFlot(20));
        make.height.mas_equalTo(kWidthFlot(20));
        make.right.mas_equalTo(-kWidthFlot(20));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(kWidthFlot(10));
        make.left.mas_equalTo(kWidthFlot(20));
        make.right.mas_equalTo(-kWidthFlot(20));
        make.height.mas_equalTo(0.5);
        make.bottom.mas_equalTo(0);
    }];
}

-(void)setGoosModel:(zCompanyGoodsModel *)goosModel
{
    _goosModel = goosModel;
    self.NameLabel.text = goosModel.zbName;
    if (goosModel.productSource == 1) {
        //自产
        self.contentLabel.text = @"产品来源：自产";
        return;
    }
    if (goosModel.productSource == 2) {
        //总代理
        self.contentLabel.text = @"产品来源：总代理";
        return;
    }
    self.contentLabel.text = @"产品来源：";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
