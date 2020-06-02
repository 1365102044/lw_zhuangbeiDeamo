//
//  LWJiaoLiuGroupCollectionReusableView.m
//  ZhuangBei
//
//  Created by LWQ on 2020/4/27.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWJiaoLiuGroupCollectionReusableView.h"

// 群组 组头
@implementation LWJiaoLiuGroupCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleL = [UILabel new];
        _titleL.font = kFont(18);
        [self addSubview:_titleL];
        UIImageView *imageview = [UIImageView new];
        imageview.backgroundColor = UIColor.redColor;
        [self addSubview:imageview];
        
        
        
        UIView *des1 = [UIView new];
        UIView *des2 = [UIView new];
        des1.backgroundColor = UIColor.blueColor;
        des2.backgroundColor = UIColor.blueColor;
        des2.alpha = 0.3;
        [self addSubviews:@[des2,des1]];
        [des1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(2);
            make.height.mas_offset(20);
            make.left.mas_equalTo(self).mas_offset(10);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        [des2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(1);
            make.height.mas_offset(20);
            //        make.top.bottom.mas_equalTo(bg);
            make.left.mas_equalTo(des1.mas_right).mas_offset(2);
            //        make.right.mas_equalTo(bg.mas_right);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(des2.mas_right).mas_offset(10);
            make.right.mas_equalTo(self.mas_right).mas_offset(-10);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        
    }
    return self;
}

@end

// 群组 cell
@interface LWJiaoLiuGroupCollectionCell()

@end

@implementation LWJiaoLiuGroupCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _bgImageView = [UIImageView new];
        _bgImageView.image = IMAGENAME(@"testicon");
        _nameL = [UILabel new];
        _nameL.textColor = UIColor.whiteColor;
        _nameL.font = kFont(15);
        _nameL.textAlignment = NSTextAlignmentRight;
        UIView *line = [UIView new];
        line.backgroundColor = UIColor.grayColor;
        [self addSubviews:@[_bgImageView,_nameL,line]];
        
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_bgImageView.mas_left).mas_offset(3);
            make.right.mas_equalTo(_bgImageView.mas_right).mas_offset(-3);
            make.top.mas_equalTo(_bgImageView.mas_top).mas_offset(10);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_nameL.mas_right);
            make.top.mas_equalTo(_nameL.mas_bottom).mas_offset(5);
            make.width.mas_offset(40);
            make.height.mas_offset(2);
        }];
        [_bgImageView setBoundWidth:0 cornerRadius:10];
    }
    return self;
}
@end


