//
//  sliderNavMenu.m
//  guoziyunparent
//
//  Created by aa on 2019/7/5.
//  Copyright © 2019 xuxianwang. All rights reserved.
//

#import "sliderNavMenu.h"

@interface sliderNavMenu ()

@property(strong,nonatomic)NSMutableArray * itemsArray;

@property(strong,nonatomic)UIScrollView * scrollView;

@property(strong,nonatomic)UIButton * selectButton;

@property(strong,nonatomic)UIImage * normalImage;

@property(strong,nonatomic)UIImage * selectImage;

@property(assign,nonatomic)BOOL canScroll;//项目较少的时候不能滚动

@property(assign,nonatomic)BOOL finishCaculate;//计算

@property(nonatomic, strong) UIView *sliderBar;

@property(nonatomic,strong) UIColor * selectColor;


@end

@implementation sliderNavMenu

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        self.normalFontColor = [UIColor colorWithHexString:@"#494949"];
        self.selectFontColor = [UIColor colorWithHexString:@"#FFFFFF"];
        self.selectItemBackGroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        self.padding = 20;
        self.fontSize = 14.f;
        self.normalFont = [UIFont fontWithName:@"TamilSangamMN" size:kWidthFlot(14)];
        self.selectFont = [UIFont fontWithName:@"TamilSangamMN-Bold" size:kWidthFlot(14)];
        self.canScroll = YES;
        [self addSubview:self.scrollView];
        [self setNeedsLayout];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
//    [self updateLayout];
}

-(void)setSourceArray:(NSArray *)sourceArray
{
    [self.itemsArray removeAllObjects];
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [sourceArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton * itemButton = [[UIButton alloc]init];
        NSString *title  = sourceArray[idx];
        itemButton.tag = idx;
        [itemButton setTitle:title forState:UIControlStateNormal];
        [itemButton.titleLabel setFont:self.normalFont];
        [itemButton setTitleColor:self.normalFontColor forState:UIControlStateNormal];
        [itemButton setTitleColor:self.selectFontColor forState:UIControlStateSelected];
        [itemButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
//        itemButton.layer.cornerRadius = 17;
        itemButton.layer.masksToBounds = YES;
        [itemButton setBackgroundImage:self.normalImage forState:UIControlStateNormal];
        [itemButton setBackgroundImage:self.normalImage forState:UIControlStateSelected];
        [itemButton setBackgroundImage:self.normalImage forState:UIControlStateHighlighted];
        [itemButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.itemsArray addObject:itemButton];
        [self.scrollView addSubview:itemButton];
        if (idx==0) {
            itemButton.selected = YES;
            [itemButton.titleLabel setFont:self.selectFont];
            self.selectButton = itemButton;
        }
    }];
    [self.scrollView addSubview:self.sliderBar];
    [self.scrollView bringSubviewToFront:self.sliderBar];
    [self updateLayout];
}


-(void)updateLayout
{
    __block CGFloat lastX = 0;
    __block CGFloat totalWidth = 0;
    __weak typeof(self) weakeSelf = self;
    [self.itemsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton * button = weakeSelf.itemsArray[idx];
        [button sizeToFit];
        CGFloat width = button.frame.size.width;
        if (self.sliderWidth != 20.f && idx == 0) {
            self.sliderWidth = width;
        }
        __block CGFloat x;
        if (idx == 0) {
           x = lastX + 20;
        }else
        {
            x = lastX + weakeSelf.padding;
        }
        button.frame = CGRectMake(x, 5, width, 34);
        lastX = CGRectGetMaxX(button.frame);
        totalWidth = totalWidth + width;
        if (button.selected) {
            if (self.havesliderBar) {
                
               CGFloat sliderwidth;
                if ((button.frame.size.width-30) < 20) {
                    if (self.sliderWidth) {
                        sliderwidth = self.sliderWidth;
                    } else {
                        sliderwidth = button.frame.size.width;
                    }
                   self.sliderBar.frame =
                    CGRectMake(button.frame.origin.x + (button.frame.size.width/2) - (sliderwidth/2), CGRectGetMaxY(button.frame) - 3,
                               sliderwidth, 3);
                }else
                {
                    if (self.sliderWidth) {
                        sliderwidth = self.sliderWidth;
                    } else {
                        sliderwidth = 20;
                    }
                    self.sliderBar.frame =
                    CGRectMake(button.frame.origin.x+(button.frame.size.width-sliderwidth)/2, CGRectGetMaxY(button.frame) - 3,
                               sliderwidth, 3);
                }
            }
        }
        if (idx == weakeSelf.itemsArray.count -1) {
            
            if (self.sliderType == menuAligenLeft) {
                weakeSelf.canScroll = NO;
            }else
            {
                //剩余的宽度是 总宽度 减去 间距 减去 item宽度总和
                CGFloat offWidth = self.frame.size.width - totalWidth - weakeSelf.padding*idx;
                // 如果项目较少的时候居中显示
                if (offWidth > 50) {
                    lastX = 0;
                    if (weakeSelf.fullCenter) {
                        x= weakeSelf.padding;
                        [weakeSelf.itemsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger jdx, BOOL * _Nonnull stop) {
                            UIButton * shoutItem = weakeSelf.itemsArray[jdx];
                            [shoutItem sizeToFit];
                            shoutItem.frame = CGRectMake(x, 5,shoutItem.frame.size.width, 34);
                            CGFloat  neWlastX = CGRectGetMaxX(shoutItem.frame);
                            x = neWlastX + offWidth/(weakeSelf.itemsArray.count-1);
                        }];
                    }else
                    {
                        __block CGFloat  neWlastX = 0;
                        x = offWidth/2  + neWlastX;
                        [weakeSelf.itemsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger jdx, BOOL * _Nonnull stop) {
                            
                            UIButton * shoutItem = weakeSelf.itemsArray[jdx];
                            [shoutItem sizeToFit];
                            shoutItem.frame = CGRectMake(x, 5, shoutItem.frame.size.width, 34);
                           neWlastX  = CGRectGetMaxX(shoutItem.frame);
                            if (self.havesliderBar) {
                                if (shoutItem.selected == YES) {
                                    CGFloat sliderwidth;
                                    if ((shoutItem.frame.size.width-30) < 30) {
                                        if (self.sliderWidth) {
                                            sliderwidth = self.sliderWidth;
                                        } else {
                                            sliderwidth = shoutItem.frame.size.width;
                                        }
                                       self.sliderBar.frame =
                                        CGRectMake(shoutItem.frame.origin.x + (shoutItem.frame.size.width/2) - (sliderwidth/2), CGRectGetMaxY(shoutItem.frame) - 3,
                                                   sliderwidth, 3);
                                    }else
                                    {
                                        if (self.sliderWidth) {
                                            sliderwidth = self.sliderWidth;
                                        } else {
                                            sliderwidth = shoutItem.frame.size.width-30;
                                        }
                                        self.sliderBar.frame =
                                        CGRectMake(shoutItem.frame.origin.x + (shoutItem.frame.size.width/2) - (sliderwidth/2), CGRectGetMaxY(shoutItem.frame) - 3,
                                                   sliderwidth, 3);
                                    }
                                }
                            }
                            x = neWlastX + weakeSelf.padding;
                        }];
                    }
                    
                    weakeSelf.canScroll = NO;
                }
            }
        }
    }];
    if (self.sliderRoundCorner) {
        self.sliderBar.layer.cornerRadius = _sliderRoundCorner;
    }
    [weakeSelf.scrollView setContentSize:CGSizeMake(lastX + weakeSelf.padding, 0)];
}

-(void)setSelectIndex:(NSInteger)selectIndex
{
    NSLog(@"______设置index:%ld", selectIndex);
    if (self.itemsArray.count==0 || selectIndex<0 || selectIndex >self.itemsArray.count-1) {
        return;
    }else
    {
        _selectIndex = selectIndex;
        UIButton * btn = self.itemsArray[selectIndex];
        [self setSelectIndexButton:btn];
    }
}

-(void)setSelectIndexButton:(UIButton*)button
{
    [self.selectButton.titleLabel setFont:self.normalFont];
        self.selectButton.selected = NO;
        button.selected = YES;
        self.selectButton = button;
        
        [self.selectButton setNeedsLayout];
        [self.selectButton layoutIfNeeded];
        CGRect buttonFrame = self.selectButton.bounds;
        self.sliderWidth = buttonFrame.size.width;
        [self.selectButton.titleLabel setFont:self.selectFont];
        if (self.havesliderBar) {
            [self.scrollView bringSubviewToFront:self.sliderBar];
    //        CGFloat x = button.frame.origin.x;
            //   底部滑条
            if (_sliderAnimation == YES) {
                [UIView animateWithDuration:.25
                                 animations:^{
                    CGFloat sliderwidth;
                    if ((button.frame.size.width-30) < 20) {
                        if (self.sliderWidth) {
                            sliderwidth = self.sliderWidth;
                        } else {
                            sliderwidth = button.frame.size.width;
                        }
                       self.sliderBar.frame =
                        CGRectMake(button.frame.origin.x + (button.frame.size.width/2) - (sliderwidth/2), CGRectGetMaxY(button.frame) - 3,
                                   sliderwidth, 3);
                    }else
                    {
                        if (self.sliderWidth) {
                            sliderwidth = self.sliderWidth;
                        } else {
                            sliderwidth = 20;
                        }
                        self.sliderBar.frame =
                        CGRectMake(button.frame.origin.x+(button.frame.size.width-sliderwidth)/2, CGRectGetMaxY(button.frame) - 3,
                                   sliderwidth, 3);
                    }
                    [self.sliderBar layoutIfNeeded];
                }];
            }else
            {
                CGFloat sliderwidth;
                if ((button.frame.size.width-30) < 20) {
                    if (self.sliderWidth) {
                        sliderwidth = self.sliderWidth;
                    } else {
                        sliderwidth = button.frame.size.width;
                    }
                   self.sliderBar.frame =
                    CGRectMake(button.frame.origin.x + (button.frame.size.width/2) - (sliderwidth/2), CGRectGetMaxY(button.frame) - 3,
                               sliderwidth, 3);
                }else
                {
                    if (self.sliderWidth) {
                        sliderwidth = self.sliderWidth;
                    } else {
                        sliderwidth = 20;
                    }
                    self.sliderBar.frame =
                    CGRectMake(button.frame.origin.x+(button.frame.size.width-sliderwidth)/2, CGRectGetMaxY(button.frame) - 3,
                               sliderwidth, 3);
                }
                [self.sliderBar layoutIfNeeded];
            }
        }
        if (self.canScroll) {
            [self adjustScrollView:button];
        }
}

-(void)buttonClick:(UIButton*)button
{
    [self.selectButton.titleLabel setFont:self.normalFont];
    self.selectButton.selected = NO;
    button.selected = YES;
    self.selectButton = button;
    
    [self.selectButton setNeedsLayout];
    [self.selectButton layoutIfNeeded];
    CGRect buttonFrame = self.selectButton.bounds;
    self.sliderWidth = buttonFrame.size.width;
    [self.selectButton.titleLabel setFont:self.selectFont];
    if (self.havesliderBar) {
        [self.scrollView bringSubviewToFront:self.sliderBar];
//        CGFloat x = button.frame.origin.x;
        //   底部滑条
        if (_sliderAnimation == YES) {
            [UIView animateWithDuration:.25
                             animations:^{
                CGFloat sliderwidth;
                if ((button.frame.size.width-30) < 20) {
                    if (self.sliderWidth) {
                        sliderwidth = self.sliderWidth;
                    } else {
                        sliderwidth = button.frame.size.width;
                    }
                   self.sliderBar.frame =
                    CGRectMake(button.frame.origin.x + (button.frame.size.width/2) - (sliderwidth/2), CGRectGetMaxY(button.frame) - 3,
                               sliderwidth, 3);
                }else
                {
                    if (self.sliderWidth) {
                        sliderwidth = self.sliderWidth;
                    } else {
                        sliderwidth = 20;
                    }
                    self.sliderBar.frame =
                    CGRectMake(button.frame.origin.x+(button.frame.size.width-sliderwidth)/2, CGRectGetMaxY(button.frame) - 3,
                               sliderwidth, 3);
                }
                [self.sliderBar layoutIfNeeded];
            }];
        }else
        {
            CGFloat sliderwidth;
            if ((button.frame.size.width-30) < 20) {
                if (self.sliderWidth) {
                    sliderwidth = self.sliderWidth;
                } else {
                    sliderwidth = button.frame.size.width;
                }
               self.sliderBar.frame =
                CGRectMake(button.frame.origin.x + (button.frame.size.width/2) - (sliderwidth/2), CGRectGetMaxY(button.frame) - 3,
                           sliderwidth, 3);
            }else
            {
                if (self.sliderWidth) {
                    sliderwidth = self.sliderWidth;
                } else {
                    sliderwidth = 20;
                }
                self.sliderBar.frame =
                CGRectMake(button.frame.origin.x+(button.frame.size.width-sliderwidth)/2, CGRectGetMaxY(button.frame) - 3,
                           sliderwidth, 3);
            }
            [self.sliderBar layoutIfNeeded];
        }
    }
    if (self.canScroll) {
        [self adjustScrollView:button];
    }
    if ([self.delegate respondsToSelector:@selector(sliderNavMenuSelectIndex:)]) {
        [self.delegate sliderNavMenuSelectIndex:button.tag];
    }
    
}


//计算偏移量
-(void)adjustScrollView:(UIButton*)button{
    //如果小于左半侧屏幕
    CGFloat offsetX = button.center.x - self.bounds.size.width * 0.5;
    if (offsetX < 0) {
        offsetX = 0;
    }
    //获取最大滚动范围
    CGFloat maxOffsetX = self.scrollView.contentSize.width - self.bounds.size.width;
    if (offsetX > maxOffsetX){
        offsetX = maxOffsetX;
    }
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}


-(CGFloat)getItemWidthWithTitlt:(NSString*)title
{
    CGFloat width = 0;
    
    NSDictionary *attributes =
    @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
    
    width = [title sizeWithAttributes:attributes].width;
    
    return width + 20;
}

- (UIImage*)createImageWithColor: (UIColor*) color{CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}



-(UIScrollView*)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

-(UIImage*)normalImage{
    if (!_normalImage) {
        _normalImage = [self createImageWithColor:self.selectItemBackGroundColor];
    }
    return _normalImage;
}

-(UIImage*)selectImage
{
    if (!_selectImage) {
        _selectImage = [self createImageWithColor:self.selectColor];
    }
    return _selectImage;
}

-(UIColor*)selectColor
{
    if (!_selectColor) {
        _selectColor = [UIColor colorWithHexString:@"#0189EF"];
    }
    return _selectColor;
}

- (UIView *)sliderBar {
    if (!_sliderBar) {
        _sliderBar = [UIView new];
        _sliderBar.backgroundColor = [UIColor colorWithHexString:@"#3F50B5"];
    }
    
    return _sliderBar;
}


-(NSMutableArray*)itemsArray
{
    if (!_itemsArray) {
        _itemsArray = [NSMutableArray array];
    }
    return _itemsArray;
}

-(void)setSliderType:(sliderMenuType)sliderType
{
    _sliderType = sliderType;
}

-(void)setHavesliderBar:(BOOL)havesliderBar
{
    _havesliderBar = havesliderBar;
    if (havesliderBar) {
        self.selectColor = [UIColor colorWithHexString:@"#FFFFFF"];
        
    }else
    {
        self.sliderBar.alpha = 0;
    }
}

-(void)setPadding:(CGFloat)padding
{
    _padding = padding;
}

-(void)setSelectFontColor:(UIColor *)selectFontColor
{
    _selectFontColor = selectFontColor;
}

-(void)setNormalFontColor:(UIColor *)normalFontColor
{
    _normalFontColor = normalFontColor;
}

@end
