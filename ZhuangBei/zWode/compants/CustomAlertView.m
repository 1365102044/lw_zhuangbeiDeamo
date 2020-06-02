//
//  CustomAlertView.m
//  xxsdu
//
//  Created by LIU JIA on 2019/1/30.
//  Copyright © 2019 LIU JIA. All rights reserved.
//  

#import "CustomAlertView.h"


@interface CustomAlertView()
/** 记忆之前的按钮样式 */
@property(nonatomic, retain)UIColor *colorButtonBefore;
@end

@implementation CustomAlertView
- (instancetype)initWithTitle:(NSString *)title descr:(NSString* _Nullable)descr buttonNames:(NSArray *)buttonNames {
    return [self initWithTitle:title descr:descr buttonNames:buttonNames icon:@""];
}

- (instancetype)initWithTitle:(NSString *)title descr:(NSString *)descr buttonNames:(NSArray *)buttonNames icon:(NSString *)iconName {
    self = [super init];
        if (self) {
            // 前提
            CGFloat containerWidth = 270;
            CGFloat contentHeight = 76; // 无描述无icon的情况
            CGFloat contentWidth = 245;
            CGFloat computeHeight = 0;
    //        CGFloat contentMargin = 15;
            
            UIView *containerView = [UIView new];
            // 图标
            BOOL hasIcon = iconName && ![@"" isEqualToString:iconName];
            BOOL hasTitle = title && ![@"" isEqualToString:title];
            BOOL hasDescr = descr && ![@"" isEqualToString:descr];
            
            UIImageView *icon = nil;
            if (hasIcon) {
                icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
                [containerView addSubview:icon];
                [icon setFrame:CGRectMake((containerWidth - icon.bounds.size.width) / 2, 15, icon.bounds.size.width, icon.bounds.size.height)];
            }
            
            // 标题
            UILabel *labTitle = nil;
            if (hasTitle) {
                labTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, contentWidth, CGFLOAT_MAX)];
                [labTitle setTextColor:[UIColor colorWithHexString:@"#333333"]];
                [labTitle setFont:[UIFont systemFontOfSize:15]];
                [labTitle setTextAlignment:(NSTextAlignmentCenter)];
                labTitle.numberOfLines = 0;
                labTitle.text = title;
                [labTitle sizeToFit];
                [containerView addSubview:labTitle];
                if (hasIcon) {
                    [labTitle setFrame:CGRectMake((containerWidth - labTitle.bounds.size.width) / 2, CGRectGetMaxY(icon.frame) + 10, labTitle.bounds.size.width, labTitle.bounds.size.height)];
                } else {
                    if (hasDescr) {
                        [labTitle setFrame:CGRectMake((containerWidth - labTitle.bounds.size.width) / 2, 20, labTitle.bounds.size.width, labTitle.bounds.size.height)];
                    } else {
                        [labTitle setFrame:CGRectMake((containerWidth - labTitle.bounds.size.width) / 2, (contentHeight / 2 - labTitle.frame.size.height / 2), labTitle.bounds.size.width, labTitle.bounds.size.height)];
                    }
                }
                computeHeight = CGRectGetMaxY(labTitle.frame) + 20;
            }
            
            // 描述
            if (hasDescr) {
                // 非空
                UILabel *labDescr = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, contentWidth, CGFLOAT_MAX)];
                [containerView addSubview:labDescr];
                [labDescr setTextColor:[UIColor darkGrayColor]];
                [labDescr setFont:[UIFont systemFontOfSize:12]];
                [labDescr setTextAlignment:(NSTextAlignmentCenter)];
                [labDescr setLineBreakMode:(NSLineBreakByCharWrapping)];
                [labDescr setNumberOfLines:0];
                labDescr.text = descr;
                [labDescr sizeToFit];
                if (hasTitle) {
                    [labDescr setFrame:CGRectMake((containerWidth - CGRectGetWidth(labDescr.frame)) / 2, CGRectGetMaxY(labTitle.frame) + 10, CGRectGetWidth(labDescr.frame), CGRectGetHeight(labDescr.frame))];
                } else {
                    [labDescr setFrame:CGRectMake((containerWidth - CGRectGetWidth(labDescr.frame)) / 2, (contentHeight / 2 - labDescr.frame.size.height / 2), CGRectGetWidth(labDescr.frame), CGRectGetHeight(labDescr.frame))];
                }
                computeHeight = CGRectGetMaxY(labDescr.frame) + 20;
            }
            
            if (computeHeight > contentHeight) {
                contentHeight = computeHeight;
            }
            
            [containerView setFrame:CGRectMake(0, 0, containerWidth, contentHeight)];
            
            [self setContainerView:containerView];
            [self setButtonTitles:buttonNames];
        }
        return self;
}

- (void)show {
    [super show];
    // 其他样式
    UIButton *btn = nil;
    int btnCount = 0;
    for (int i=0; i<self.dialogView.subviews.count; i++) {
        UIView *view = self.dialogView.subviews[i];
        if ([view.class isEqual:UIButton.class]) {
            btn = (UIButton*)view;
            // 按钮默认色
            [btn setTitleColor:[UIColor colorWithHexString:@"#4A4A4A"] forState:(UIControlStateNormal)];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            btnCount ++;
        }
    }
    if (btn) {
        // 最后一个颜色
        [btn setTitleColor:[UIColor colorWithHexString:@"#007AFF"] forState:(UIControlStateNormal)];
    }
    if (btnCount == 2) {
        UIView *viewSplit = [[UIView alloc] initWithFrame:CGRectMake(self.dialogView.bounds.size.width / 2 - 1, self.dialogView.bounds.size.height - 50, 1, 50)];
//        [viewSplit setBackgroundColor:[UIColor colorWithHexString:@"#000000"];
        [self.dialogView addSubview:viewSplit];
    }
    
    // 背景
    UIView *viewbg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.dialogView.bounds.size.width, self.dialogView.bounds.size.height)];
    [viewbg setBackgroundColor:[UIColor whiteColor]];
    [self.dialogView insertSubview:viewbg atIndex:1];
    [self.dialogView.layer setMasksToBounds:YES];
    [self.dialogView.layer setCornerRadius:14];
//    [self.dialogView setBorderWithColor:0 width:0];
}

- (void)close {
    [super close];
}

- (void)showTextField {
    if (_tf == nil) {
        _tf = [UITextField new];
        _tf.font = [UIFont systemFontOfSize:13];
//        [_tf setBorderWithColor:0x999999 width:0.5];
        [_tf setLeftViewMode:(UITextFieldViewModeAlways)];
        [_tf setRightViewMode:UITextFieldViewModeAlways];
        [_tf setLeftView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 6, 0)]];
        [_tf setRightView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 6, 0)]];
        _tf.backgroundColor = UIColor.whiteColor;
    }
    [self.containerView addSubview:_tf];
    [_tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.bottom.mas_equalTo(-25);
        make.height.mas_equalTo(24);
    }];
}

@end
