//
//  LWGongYingShangListTableViewCell.m
//  ZhuangBei
//
//  Created by LWQ on 2020/4/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWGongYingShangListTableViewCell.h"

@interface LWGongYingShangListTableViewCell()
@property (nonatomic, strong) UILabel * compnayL;
@property (nonatomic, strong) UILabel * farenL;
@property (nonatomic, strong) UILabel * phoneL;
@property (nonatomic, strong) UILabel * addressL;
@property (nonatomic, strong) UILabel * desL;
@property (nonatomic, strong) UIImageView * logo;
@property (nonatomic, strong) UIView * bgview;

@end

@implementation LWGongYingShangListTableViewCell

- (void)setModel:(gysListModel *)model
{
    _model = model;
    [_logo z_imageWithImageId:model.imagesId placeholderImage:@"testicon"];
    _compnayL.text = model.name;
    _farenL.text = [NSString stringWithFormat:@"法人：%@",model.faRen];
    _phoneL.text = [NSString stringWithFormat:@"电话：%@",model.phone];
    _addressL.text = [NSString stringWithFormat:@"地址：%@",model.gongSiUrl];
    
    _desL.text = [NSString stringWithFormat:@"简介：%@",model.gongSiJj];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self confiCellUI];
    }
    return self;
}

- (void)confiCellUI
{
    _compnayL = [LWLabel lw_lable:@"" font:20 textColor:BASECOLOR_TEXTCOLOR];
    _farenL = [LWLabel lw_lable:@"" font:15 textColor:BASECOLOR_TEXTCOLOR];
    _phoneL = [LWLabel lw_lable:@"" font:15 textColor:BASECOLOR_TEXTCOLOR];
    _addressL = [LWLabel lw_lable:@"" font:15 textColor:BASECOLOR_TEXTCOLOR];
    _desL = [LWLabel lw_lable:@"" font:15 textColor:BASECOLOR_TEXTCOLOR];
    _logo = [UIImageView new];
    _bgview = [UIView new];
    UIView *line = [UIView new];
    line.backgroundColor = UIColor.grayColor;
    
    UILabel *startL = [LWLabel lw_lable:@"" font:15 textColor:BASECOLOR_TEXTCOLOR];
    
    [_bgview addSubviews:@[_compnayL,_farenL,_phoneL,_addressL,_desL,_logo,line,startL,]];
    [self.contentView addSubview:_bgview];
    _desL.numberOfLines = 0;
    startL.text = @"星级:  ";
    _logo.image = IMAGENAME(@"testicon");
    [_logo setBoundWidth:0 cornerRadius:35];
    
    CGFloat margin_l = 15;
    CGFloat margin_t = 15;
    [_compnayL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_bgview.mas_left).mas_offset(margin_l);
        make.right.mas_equalTo(_bgview.mas_right).mas_offset(-margin_l);
        make.top.mas_equalTo(_bgview.mas_top).mas_offset(20);
    }];
    [_logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_bgview.mas_right).mas_offset(-15-10);
        make.top.mas_equalTo(_compnayL.mas_bottom).mas_offset(0);
        make.width.mas_offset(70);
        make.height.mas_offset(70);
    }];
    [_farenL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_compnayL.mas_left);
        make.right.mas_equalTo(_logo.mas_left).mas_offset(-5);
        make.top.mas_equalTo(_compnayL.mas_bottom).mas_offset(margin_t);
    }];
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(_farenL);
        make.top.mas_equalTo(_farenL.mas_bottom).mas_offset(margin_t);
    }];
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_farenL);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
        make.top.mas_equalTo(_phoneL.mas_bottom).mas_offset(margin_t);
    }];
    [_desL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_compnayL);
        make.top.mas_equalTo(_addressL.mas_bottom).mas_offset(margin_t);
        make.bottom.mas_equalTo(_bgview.mas_bottom).mas_offset(-15);
    }];
//    [line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_compnayL.mas_left);
//        make.right.mas_equalTo(_logo.mas_right);
//        make.height.mas_offset(1);
//        make.top.mas_equalTo(_desL.mas_bottom).mas_offset(margin_t+10);
//    }];
//    [startL mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_compnayL.mas_left);
//        make.top.mas_equalTo(line.mas_bottom).mas_offset(margin_t);
//        make.bottom.mas_equalTo(_bgview.mas_bottom).mas_offset(-15);
//    }];
    [_bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(10);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(0);
    }];
    
    [_bgview setBoundWidth:1 cornerRadius:0 boardColor:UIColor.grayColor];
}
@end

