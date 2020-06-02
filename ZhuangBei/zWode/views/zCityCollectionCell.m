//
//  historyCollectionCell.m
//  guoziyunparent
//
//  Created by aa on 2019/7/19.
//  Copyright © 2019 xuxianwang. All rights reserved.
//

#import "zCityCollectionCell.h"

@interface zCityCollectionCell ()

@property (nonatomic, strong) UILabel *textlabel;

@end

@implementation zCityCollectionCell

- (void)setSelect:(BOOL)select
{
    _select = select;
    
    if (select) {
        [self.contentView setBoundWidth:1 cornerRadius:0 boardColor:RGB(63, 80, 181)];
        self.textlabel.textColor = [UIColor colorWithRed:63/255.0 green:80/255.0 blue:181/255.0 alpha:1];
        self.textlabel.backgroundColor = [UIColor colorWithRed:205/255.0 green:210/255.0 blue:230/255.0 alpha:1];
    }else{
        [self.contentView setBoundWidth:1 cornerRadius:0 boardColor:UIColor.whiteColor];
        self.textlabel.textColor = [UIColor colorWithHexString:@"#333333"];
        self.textlabel.backgroundColor = [UIColor colorWithHexString:@"#F4F4F4"];
        [self.contentView setBoundWidth:1 cornerRadius:0 boardColor:[UIColor colorWithHexString:@"#F4F4F4"]];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textlabel = [UILabel new];
        self.textlabel.frame = self.bounds;
        self.textlabel.font = [UIFont systemFontOfSize:13];
        self.textlabel.numberOfLines = 0;
        [self.contentView addSubview:self.textlabel];
        self.textlabel.textAlignment = NSTextAlignmentCenter;
        self.textlabel.textColor = [UIColor colorWithHexString:@"#9B9B9B"];
        self.textlabel.backgroundColor = [UIColor colorWithHexString:@"#F4F4F4"];
        [self.textlabel layoutIfNeeded];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.textlabel.frame = self.bounds;
    
    [self clipCornerWithView:self.textlabel andTopLeft:YES andTopRight:YES andBottomLeft:YES andBottomRight:YES];
    
}


-(void)setSouceString:(NSString *)souceString
{
    self.textlabel.text = souceString;
}


- (UIView *)clipCornerWithView:(UIView *)originView
                    andTopLeft:(BOOL)topLeft
                   andTopRight:(BOOL)topRight
                 andBottomLeft:(BOOL)bottomLeft
                andBottomRight:(BOOL)bottomRight
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:originView.bounds
                                                   byRoundingCorners:(topLeft==YES ? UIRectCornerTopLeft : 0) |
                              (topRight==YES ? UIRectCornerTopRight : 0) |
                              (bottomLeft==YES ? UIRectCornerBottomLeft : 0) |
                              (bottomRight==YES ? UIRectCornerBottomRight : 0)
                                                         cornerRadii:CGSizeMake(0,0)];
    // 创建遮罩层
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = originView.bounds;
    maskLayer.path = maskPath.CGPath;   // 轨迹
    originView.layer.mask = maskLayer;
    
    return originView;
}

-(void)setBackColor:(UIColor *)backColor
{
    self.textlabel.backgroundColor = backColor;
}

-(void)setModel:(zListTypeModel *)model
{
    self.textlabel.text = model.name;
    
    if (model.select) {
        
        self.textlabel.textColor = [UIColor colorWithHexString:@"#3F50B5"];
        self.textlabel.backgroundColor = [UIColor colorWithHexString:@"#F4F4F4"];
        self.textlabel.layer.borderWidth = 1;
        self.textlabel.layer.borderColor = [UIColor colorWithHexString:@"#3F50B5"].CGColor;
    }else
    {
        self.textlabel.textColor = [UIColor colorWithHexString:@"#9B9B9B"];
        self.textlabel.backgroundColor = [UIColor colorWithHexString:@"#F4F4F4"];
        self.textlabel.layer.borderWidth = 1;
        self.textlabel.layer.borderColor = [UIColor colorWithHexString:@"#9B9B9B"].CGColor;
    }
}

@end
