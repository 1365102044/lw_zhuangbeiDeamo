//
//  LWAddFriendTableViewCell.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/15.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWAddFriendTableViewCell.h"

@interface LWAddFriendTableViewCell ()

@property (nonatomic, strong) UIImageView * icon;
@property (nonatomic, strong) UILabel * nameL;
@property (nonatomic, strong) UILabel * emailL;
@property (nonatomic, strong) UILabel * phoneL;
@property (nonatomic, strong) UILabel * descL;
@end

@implementation LWAddFriendTableViewCell

- (void)setModel:(LWAddFriendModel *)model
{
    _model = model;
    if(model.cellType == 1){
        [_icon z_imageWithImageId:model.portrait placeholderImage:@"testtouxiang"];
        _nameL.text = model.userName;
        _emailL.text = [NSString stringWithFormat:@"邮箱：%@",model.email?LWDATA(model.email):@"暂无"];
        _phoneL.text = [NSString stringWithFormat:@"电话：%@",model.mobile?LWDATA(model.mobile):@"暂无"];
        _descL.text = [NSString stringWithFormat:@"个性签名：%@",model.sign?LWDATA(model.sign):@"暂无"];
    }else{
        [_icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kApiPrefix_PIC,model.avatar]] placeholderImage:IMAGENAME(@"testtouxiang")];
        _nameL.text = model.groupName;
        _emailL.text = [NSString stringWithFormat:@"创建时间：%@",LWDATA(model.buildTime)];
        _phoneL.text = [NSString stringWithFormat:@"创建人：%@",LWDATA(model.userName)];
        _descL.text = [NSString stringWithFormat:@"个性签名：%@",model.groupdescription?LWDATA(model.groupdescription):@"暂无"];
    }
    
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
    _icon = [UIImageView new];
    _icon.image = IMAGENAME(@"testtouxiang");
    _nameL = [LWLabel lw_lable:@"lwq" font:18 textColor:BASECOLOR_TEXTCOLOR];
    _emailL = [LWLabel lw_lable:@"邮箱：" font:14 textColor:BASECOLOR_GREYCOLOR155];
    _phoneL = [LWLabel lw_lable:@"电话：" font:14 textColor:BASECOLOR_GREYCOLOR155];
    _descL = [LWLabel lw_lable:@"个性签名：" font:14 textColor:BASECOLOR_GREYCOLOR155];
    [_icon setBoundWidth:0 cornerRadius:40];
    [self.contentView addSubviews:@[_icon,_nameL,_phoneL,_descL,_emailL]];
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(15);
        make.width.height.mas_offset(80);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(15);
    }];
    [_icon setBoundWidth:0 cornerRadius:40];
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_icon.mas_right).mas_offset(15);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
        make.top.mas_equalTo(_icon.mas_top).mas_offset(0);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_icon.mas_right).mas_offset(15);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
        make.top.mas_equalTo(_nameL.mas_bottom).mas_offset(7);
    }];
    
    [_emailL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_icon.mas_right).mas_offset(15);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
        make.top.mas_equalTo(_phoneL.mas_bottom).mas_offset(7);
    }];
    [_descL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_icon.mas_left).mas_offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
        make.top.mas_equalTo(_icon.mas_bottom).mas_offset(7);
    }];
    
}
@end
