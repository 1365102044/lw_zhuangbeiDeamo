//
//  zPersonalHeader.m
//  ZhuangBei
//
//  Created by aa on 2020/5/3.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zPersonalHeader.h"
#import "HeaderManager.h"

@interface zPersonalHeader ()

@property(strong,nonatomic)UIView * baseView;

@property(strong,nonatomic)UIButton * imageButton;


@end

@implementation zPersonalHeader

-(UIView*)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc]init];
    }
    return _baseView;
}

-(UIButton*)imageButton
{
    if (!_imageButton) {
        _imageButton = [[UIButton alloc]init];
        _imageButton.layer.cornerRadius = kWidthFlot(64);
        _imageButton.userInteractionEnabled = NO;
        _imageButton.clipsToBounds = YES;
        [_imageButton setBackgroundImage:[UIImage imageNamed:@"wode_defoutHeader"] forState:UIControlStateNormal];
        [_imageButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _imageButton;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.baseView];
        [self.baseView addSubview:self.imageButton];
        [self updateConstraintsForView];
    }
    return self;
}



-(void)updateConstraintsForView
{
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        make.height.mas_equalTo(kWidthFlot(150));
    }];
    
    [self.imageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.baseView.mas_centerX);
        make.centerY.mas_equalTo(self.baseView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(128), kWidthFlot(128)));
    }];
}

-(void)setCanEdit:(NSInteger)canEdit
{
    _canEdit = canEdit;
    self.imageButton.userInteractionEnabled = canEdit;
}

-(void)setImageID:(NSString*)imageID
{
//    imageID = 6506;
    NSString * url = [NSString stringWithFormat:@"%@app/appfujian/download?attID=%@",kApiPrefix,imageID];
    __weak typeof(self) weakSelf = self;
    [self.imageButton sd_setBackgroundImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image == nil) {
            [weakSelf.imageButton setBackgroundImage:[UIImage imageNamed:@"wode_defoutHeader"] forState:UIControlStateNormal];
        }
    }];
}

-(void)buttonClick
{
    
    if (self.personalTap) {
        self.personalTap();
    }
}

@end
