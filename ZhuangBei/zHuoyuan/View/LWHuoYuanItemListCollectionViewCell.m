//
//  LWHuoYuanItemListCollectionViewCell.m
//  ZhuangBei
//
//  Created by LWQ on 2020/4/26.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWHuoYuanItemListCollectionViewCell.h"

@implementation LWHuoYuanItemListCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        _bgImageView = [UIImageView new];
        _bgImageView.image = IMAGENAME(@"testicon");
        _descL = [UILabel new];
        
        [self addSubviews:@[_bgImageView,_descL,]];
        _descL.font = kFont(12);
        _descL.textColor = BASECOLOR_TEXTCOLOR;
        
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.top).mas_offset(10);
            make.left.mas_equalTo(self.mas_left).mas_offset(20);
            make.right.mas_equalTo(self.mas_right).mas_offset(-20);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-40);
        }];
        [_descL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.height.mas_offset(20);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-10);
        }];
        
//        [_bgImageView setBoundWidth:0 cornerRadius:10 boardColor:UIColor.whiteColor];
        [self setBoundWidth:1 cornerRadius:10 boardColor:kSeparatorColor];
    }
    return self;
}
@end
