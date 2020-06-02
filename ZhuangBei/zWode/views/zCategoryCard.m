//
//  zCategoryCard.m
//  ZhuangBei
//
//  Created by aa on 2020/4/27.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zCategoryCard.h"

@interface zCategoryCard ()

@property(strong,nonatomic)UIView * baseView;

@property(strong,nonatomic)UIButton* jibenBtn;

@property(strong,nonatomic)UIButton* gerenBtn;

@property(strong,nonatomic)UIButton* lianxirenBtn;

@property(strong,nonatomic)UIButton* yaoqingBtn;

@property(strong,nonatomic)UIButton* yijianBtn;

@property(strong,nonatomic)UIButton* kefuBtn;

@property(strong,nonatomic)NSArray * titleArray;

@property(strong,nonatomic)NSMutableArray * itemsArray;

@end

@implementation zCategoryCard

-(NSArray*)titleArray
{
    if (!_titleArray) {
        _titleArray = @[
            @{
                @"name":@"基本信息",
                @"image":@"wode_jiben",
            },@{
                @"name":@"个人简介",
                @"image":@"wode_personal",
            },@{
                @"name":@"联系人",
                @"image":@"wode_lianxiren",
            },@{
                @"name":@"邀请好友",
                @"image":@"wode_yaoqing",
            },@{
                @"name":@"意见反馈",
                @"image":@"wode_fankui",
            },@{
                @"name":@"联系客服",
                @"image":@"wode_kefu",
            }
        ];
    }
    return _titleArray;
}

-(UIView*)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc]init];
        _baseView.backgroundColor = [UIColor whiteColor];
        _baseView.layer.cornerRadius = 15;
        _baseView.layer.borderColor = [UIColor whiteColor].CGColor;
        _baseView.layer.borderWidth = 1;
        _baseView.clipsToBounds = YES;
    }
    return _baseView;
}

-(NSMutableArray*)itemsArray
{
    if (!_itemsArray) {
        _itemsArray = [NSMutableArray array];
    }
    return _itemsArray;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.baseView];
        for (int i = 0; i<self.titleArray.count; i++) {
            UIButton * button = [[UIButton alloc]init];
            button.tag = i;
            button.titleLabel.font = kFont(kWidthFlot(14));
            NSString * name = self.titleArray[i][@"name"];
            NSString * image = self.titleArray[i][@"image"];
            [button setTitle:name forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithHexString:@"4A4A4A"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonCLick:) forControlEvents:UIControlEventTouchUpInside];
            [self.baseView addSubview:button];
            [self.itemsArray addObject:button];
        }
        [self updateConstraintsForView];
    }
    return self;
}



-(void)updateConstraintsForView
{
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    for (int i = 0; i<self.itemsArray.count; i++) {
        UIButton * button = self.itemsArray[i];
        
        CGFloat margin = (SCREEN_WIDTH - kWidthFlot(40))/3;
        CGFloat height = kWidthFlot(100);
        NSInteger lie = i % 3;
        NSInteger hang = i/3;
        CGFloat left = margin * lie;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(left);
            make.top.mas_equalTo(height * hang);
            make.size.mas_equalTo(CGSizeMake(margin, height));
        }];
    }

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_baseView setNeedsLayout];
    [_baseView layoutIfNeeded];
    UIBezierPath *shadowPath = [UIBezierPath
    bezierPathWithRect:_baseView.bounds];
    _baseView.layer.masksToBounds = NO;
    _baseView.layer.shadowColor = [UIColor blackColor].CGColor;
    _baseView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    _baseView.layer.shadowOpacity = 0.1f;
    _baseView.layer.shadowPath = shadowPath.CGPath;
    
    for (int i = 0; i<self.itemsArray.count; i++) {
        UIButton * button = self.itemsArray[i];
        [button setNeedsLayout];
        [button layoutIfNeeded];
        [button setIconInTopWithSpacing:5];
    }

}

-(void)buttonCLick:(UIButton*)button
{
    if (self.categoryTapBack) {
        self.categoryTapBack(button.tag);
    }
}

@end
