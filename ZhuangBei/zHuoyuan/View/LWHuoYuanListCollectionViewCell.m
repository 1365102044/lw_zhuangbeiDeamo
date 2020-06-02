//
//  LWHuoYuanListCollectionViewCell.m
//  ZhuangBei
//
//  Created by LWQ on 2020/4/26.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWHuoYuanListCollectionViewCell.h"
#import "UIView+Extension.h"

@implementation LWHuoYuanListCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        _bgImageView = [UIImageView new];
        _bgImageView.image = IMAGENAME(@"testicon");
        _descL = [UILabel new];
        UIView * descL_bg = [UIView new];
        [self addSubviews:@[_bgImageView,descL_bg,_descL,]];
//        _descL.text = @"测试数据";
        _descL.font = kFont(12);
        _descL.textColor = UIColor.whiteColor;
        descL_bg.backgroundColor = UIColor.blackColor;
        descL_bg.alpha = 0.3;
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        [_descL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.height.mas_offset(20);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-10);
        }];
        [descL_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.mas_equalTo(self);
            make.height.mas_offset(20);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-10);
        }];
        
        [self.contentView setBoundWidth:1 cornerRadius:10 boardColor:BASECOLOR_BOARD];
        
    }
    return self;
}
@end
