//
//  IFChatCell.m
//  IMDemo
//
//  Created by zhangtongle-Pro on 2018/4/10.
//  Copyright © 2018年  Admin. All rights reserved.
//

#import "IFChatCell.h"

const int leadingSpace = 8;
const int trailingSpace = 8;
const int bottomSpace = 8;
const CGFloat iconHeight = 40;

const CGFloat textTopSpace = 13;
const CGFloat textBottomSpace = bottomSpace + 13;
const CGFloat textLeadingSpace = 13 + trailingSpace;
const CGFloat textTrailingSpace = 13 + leadingSpace*2 + iconHeight;

const static int subTitleFontNum = 16;


@interface IFChatCell () {
    
}
@end

@implementation IFChatCell

- (instancetype)initWithStyle:(IFChatCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        _layoutType = style;
        
        [self createUI];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_layoutType == IFChatCellStyleLeft || _layoutType == IFChatCellStyleRight) {
        UIRectCorner rectCorners = UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight;
        if (_layoutType == IFChatCellStyleRight || _layoutType == IFChatCellStyleRightAndNoBG) {
            rectCorners = UIRectCornerTopLeft | UIRectCornerBottomLeft | UIRectCornerBottomRight;
        }
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:_textBGIV.bounds byRoundingCorners:rectCorners cornerRadii:CGSizeMake(8, 8)];
        CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
        shapeLayer.path = path.CGPath;
        _textBGIV.layer.mask = shapeLayer;
    }
}


#pragma mark - UI

- (void)createUI {
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    _iconIV = imageView;
    
    UIImageView *textBGIV = [[UIImageView alloc] init];
    _textBGIV = textBGIV;
    if (_layoutType == IFChatCellStyleRight || _layoutType == IFChatCellStyleLeft) {
        textBGIV.backgroundColor =  BASECOLOR_BLUECOLOR;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:16];
    _titleLabel = label;
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.textColor = [UIColor grayColor];
    label2.font = [UIFont systemFontOfSize:13];
    label2.numberOfLines = 1;
    _subTitleLabel = label2;
    
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.textColor = [UIColor whiteColor];
    label3.font = [UIFont systemFontOfSize:14];
    label3.numberOfLines = 0;
    _contentLabel = label3;
    
    [self addSubview:imageView];
    [self addSubview:textBGIV];
    [self addSubview:label];
    [self addSubview:label2];
    [self addSubview:label3];
    
    [_iconIV setBoundWidth:0 cornerRadius:20];
    
    if (_layoutType == IFChatCellStyleLeft || _layoutType == IFChatCellStyleLeftAndNoBG) {
        [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(leadingSpace);
            make.top.equalTo(self.mas_top).offset(10);
            make.size.mas_equalTo(CGSizeMake(iconHeight, iconHeight));
        }];
        [label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.mas_top).offset(0);
            make.left.equalTo(imageView.mas_right).offset(leadingSpace);
            make.trailing.lessThanOrEqualTo(self).offset(-textTrailingSpace);
            make.height.mas_equalTo(20);
        }];
        [label2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label.mas_bottom).offset(5);
            make.left.equalTo(label.mas_left);
            make.height.mas_equalTo(15);
            make.trailing.lessThanOrEqualTo(self).offset(-textTrailingSpace);
        }];
        [label3 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label2.mas_bottom).offset(textTopSpace);
            make.leading.equalTo(imageView.mas_trailing).offset(textLeadingSpace);
            make.trailing.lessThanOrEqualTo(self).offset(-textTrailingSpace);
            make.bottom.equalTo(self).offset(-textTopSpace);
        }];
        
        //        [textBGIV mas_remakeConstraints:^(MASConstraintMaker *make) {
        //            make.top.equalTo(label3).offset(-1); // -textTopSpace
        //            make.leading.equalTo(label3).offset(-13);
        //            make.trailing.equalTo(label3).offset(13);
        //            make.bottom.equalTo(label3).offset(5);
        //        }];
        label.textAlignment = label2.textAlignment  = NSTextAlignmentLeft;
    } else {
        label.textAlignment = label2.textAlignment  = NSTextAlignmentRight;
        [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-leadingSpace);
            make.top.equalTo(self.mas_top).offset(10);
            make.size.mas_equalTo(CGSizeMake(iconHeight, iconHeight));
        }];
        [label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.mas_top).offset(0);
            make.left.lessThanOrEqualTo(self.mas_left).offset(textTrailingSpace);
            make.right.equalTo(imageView.mas_left).offset(-leadingSpace);
            make.height.mas_equalTo(20);
        }];
        [label2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label.mas_bottom).offset(5);
            make.right.equalTo(label.mas_right);
            make.height.mas_equalTo(15);
            make.left.lessThanOrEqualTo(self.mas_left).offset(textTrailingSpace);
        }];
        
        [label3 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label2.mas_bottom).offset(textTopSpace);
            make.right.equalTo(imageView.mas_left).offset(-textLeadingSpace);
            //            make.left.lessThanOrEqualTo(self.mas_left).offset(textTrailingSpace);
            make.bottom.equalTo(self).offset(-textTopSpace);
            make.width.mas_lessThanOrEqualTo(250);
        }];
        
        
    }
    [textBGIV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label3).offset(-1); // -textTopSpace
        make.leading.equalTo(label3).offset(-13);
        make.trailing.equalTo(label3).offset(13);
        make.bottom.equalTo(label3).offset(5);
    }];
}

+ (CGFloat)reserveWithForCell {
    return 3*leadingSpace + iconHeight + textLeadingSpace + textTrailingSpace;
}

+ (CGFloat)caculateTextHeightWithMaxWidth:(CGFloat)maxWidth text:(NSString *)text {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:subTitleFontNum] forKey:NSFontAttributeName];
    CGSize size = [text boundingRectWithSize:CGSizeMake(maxWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    CGFloat height = ceilf(size.height);
    if (height < iconHeight - textTopSpace*2) {
        height = iconHeight - textTopSpace*2;
    }
    //    return  height + textTopSpace + 2*textBottomSpace;
    return height + 10+20 + 25+ 15 + 15+10+15;
}
@end


@implementation IFChatImageCell

- (void)createUI
{
    [super createUI];
    self.contextImageView = [UIImageView new];
    [self addSubview:self.contextImageView];
    self.contentLabel.hidden = YES;
    self.contextImageView.contentMode = UIViewContentModeScaleAspectFit;
    if (self.layoutType == IFChatCellStyleLeft || self.layoutType == IFChatCellStyleLeftAndNoBG) {
        
        [self.contextImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel.mas_left).mas_offset(0);
            make.top.mas_equalTo(self.subTitleLabel.mas_bottom).mas_offset(10);
            make.width.mas_offset(150);
            make.height.mas_offset(200);
        }];
        
    } else {
        [self.contextImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.titleLabel.mas_right).mas_offset(0);
            make.top.mas_equalTo(self.subTitleLabel.mas_bottom).mas_offset(10);
            make.width.mas_offset(150);
            make.height.mas_offset(200);
        }];
        
    }
    [self.textBGIV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contextImageView).offset(-1); // -textTopSpace
        make.leading.equalTo(self.contextImageView).offset(-13);
        make.trailing.equalTo(self.contextImageView).offset(13);
        make.bottom.equalTo(self.contextImageView).offset(5);
    }];
    
    [self.contextImageView ex_addTapAction:self selector:@selector(clickImageView)];
}

- (void)clickImageView
{
    if(self.clickImgeBlock){
        self.self.clickImgeBlock();
    }
}
@end
