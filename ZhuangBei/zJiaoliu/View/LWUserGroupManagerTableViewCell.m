//
//  LWUserGroupManagerTableViewCell.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/15.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWUserGroupManagerTableViewCell.h"

@interface LWUserGroupManagerTableViewCell()

@end

@implementation LWUserGroupManagerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self confiCellUI];
    }
    return self;
}

- (void)confiCellUI
{
    _groupnameL =  [LWLabel lw_lable:@"默认" font:20 textColor:BASECOLOR_TEXTCOLOR];
    _editBtn = [UIButton new];
    [_editBtn setTitle:@"修改" forState:UIControlStateNormal];
    [_editBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    _editBtn.backgroundColor = BASECOLOR_BLUECOLOR;
    _editBtn.titleLabel.font = kFont(15);
    
    _deleteBtn = [UIButton new];
    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    _deleteBtn.backgroundColor = BASECOLOR_BLUECOLOR;
    _deleteBtn.titleLabel.font = kFont(15);
    
    [self.contentView addSubviews:@[_groupnameL,_editBtn,_deleteBtn]];
    
    [_groupnameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(20);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(15);
    }];
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-20);
        make.top.mas_equalTo(_groupnameL.mas_bottom).mas_offset(5);
        make.width.mas_offset(80);
        make.height.mas_offset(35);
    }];
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.deleteBtn.mas_left).mas_offset(-20);
        make.top.mas_equalTo(_groupnameL.mas_bottom).mas_offset(5);
        make.width.mas_offset(80);
        make.height.mas_offset(35);
    }];
}

@end
