//
//  LWJiaoLiuContatcsListTableViewCell.m
//  ZhuangBei
//
//  Created by LWQ on 2020/4/27.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWJiaoLiuContatcsListTableViewCell.h"

//联系人 cell
@implementation LWJiaoLiuContatcsListTableViewCell

- (void)clickBtn:(UIButton *)sender
{
    if (self.block) {
        self.block(sender.tag);
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _icon = [UIImageView new];
        _icon.image = IMAGENAME(@"testtouxiang");
        _nameL = [LWLabel lw_lable:@"admin" font:15 textColor:BASECOLOR_TEXTCOLOR];
        _descL = [LWLabel lw_lable:@"在么？这个问题在么解决？" font:12 textColor:BASECOLOR_GREYCOLOR155];
        _timelL = [LWLabel lw_lable:@"2020/04/22  18:20" font:12 textColor:BASECOLOR_TEXTCOLOR];
        _sendApplyStatusL = [LWLabel lw_lable:@"" font:15 textColor:BASECOLOR_BLUECOLOR];
        _unreadnumL = [LWLabel lw_lable:@"" font:10 textColor:UIColor.whiteColor];
        _unreadnumL.backgroundColor = UIColor.redColor;
        [_unreadnumL setBoundWidth:0 cornerRadius:8 boardColor:UIColor.whiteColor];
        
        UIView *line = [UIView new];
        line.backgroundColor = BASECOLOR_BOARD;
        _leftBtn = [LWButton lw_button:@"同意" font:14 textColor:UIColor.whiteColor backColor:BASECOLOR_BLUECOLOR target:self acction:@selector(clickBtn:)];
        _rightBtn = [LWButton lw_button:@"拒绝" font:14 textColor:UIColor.whiteColor backColor:BASECOLOR_BLUECOLOR target:self acction:@selector(clickBtn:)];
        _leftBtn.tag = 1;
        _rightBtn.tag = 2;
        [self.contentView addSubviews:@[_icon,_nameL,_timelL,_descL,line,_leftBtn,_rightBtn,_unreadnumL,self.sendApplyStatusL]];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
            make.height.width.mas_offset(50);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_icon.mas_right).mas_offset(10);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
            make.centerY.mas_equalTo(self.contentView.mas_centerY).mas_offset(-0);
        }];

        _descL.hidden = _timelL.hidden = YES;
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(0);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-0);
            make.height.mas_offset(0.5);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(0);
        }];
        [_icon setBoundWidth:0 cornerRadius:25];
        [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-10);
            make.width.mas_offset(60);
            make.height.mas_offset(30);
        }];
        [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_rightBtn.mas_left).mas_offset(-10);
            make.centerY.mas_equalTo(_rightBtn.mas_centerY);
            make.width.mas_offset(60);
            make.height.mas_offset(30);
        }];
        [_sendApplyStatusL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-10);
        }];
        _sendApplyStatusL.hidden = YES;
        _leftBtn.hidden = _rightBtn.hidden = YES;
        _line = line;
        [_leftBtn setBoundWidth:0 cornerRadius:4];
        [_rightBtn setBoundWidth:0 cornerRadius:4];
        
        [_unreadnumL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_offset(16);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        _unreadnumL.hidden = YES;
        _unreadnumL.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}
- (void)updateForVerifiCell;
{
    _descL.hidden = _timelL.hidden = NO;
    [_nameL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_icon.mas_right).mas_offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-5);
        make.centerY.mas_equalTo(self.contentView.mas_centerY).mas_offset(-15);
    }];
    [_timelL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
//        make.centerY.mas_equalTo(_nameL.mas_centerY);
//        make.width.mas_greaterThanOrEqualTo(125);
        make.top.mas_equalTo(_nameL.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(_nameL.mas_left);
    }];
    [_descL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameL.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
//        make.centerY.mas_equalTo(self.contentView.mas_centerY).mas_offset(15);
        make.top.mas_equalTo(_timelL.mas_bottom).mas_offset(5);
    }];
}

- (void)setBottomLine:(NSInteger)tag;
{
    [_line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(self.contentView);
        make.height.mas_offset(1);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(0);
    }];
    _leftBtn.hidden = _rightBtn.hidden = NO;
}

- (void)setunreadNumber:(NSInteger)num;
{
    _unreadnumL.hidden = (num <= 0);
    _unreadnumL.text = [NSString stringWithFormat:@"%ld",num];
}

@end

// 消息列表 cell
@implementation LWJiaoLiuMessageListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _icon = [UIImageView new];
        _icon.image = IMAGENAME(@"icon_into");
        _icon.contentMode = UIViewContentModeScaleAspectFit;
        _nameL = [UILabel new];
        _nameL.font = kFont(15);
        UIView *line = [UIView new];
          line.backgroundColor = BASECOLOR_BOARD;
        [self.contentView addSubviews:@[_icon,_nameL,line]];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
            make.width.mas_offset(20);
            make.height.mas_offset(20);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(20);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentView.mas_left).mas_offset(0);
                make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-0);
                make.height.mas_offset(0.5);
                make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(0);
            }];
    }
    return self;
}

@end


// 联系人组头
@implementation LWJiaoLiuContatcsSeactionView

- (void)clickPullBtn:(UIButton *)sender
{
    _rightBtn.selected = !_rightBtn.selected;
    if (self.block) {
        self.block(_rightBtn.selected);
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _leftIcon = [UIImageView new];
        _leftIcon.image = IMAGENAME(@"jiaoliufenzu");
        _leftL = [UILabel new];
        _rightBtn = [UIButton new];
        [_rightBtn setImage:IMAGENAME(@"pull_on") forState:UIControlStateNormal];
        [_rightBtn setImage:IMAGENAME(@"pull_down") forState:UIControlStateSelected];
        [_rightBtn addTarget:self action:@selector(clickPullBtn:) forControlEvents:UIControlEventTouchUpInside];
        UIView *line = [UIView new];
               line.backgroundColor = BASECOLOR_BOARD;
        [self addSubviews:@[_leftIcon,_leftL,_rightBtn,line]];
        [_leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(10);
            make.width.mas_offset(30);
            make.height.mas_offset(30);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        [_leftL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_leftIcon.mas_right).mas_offset(10);
            make.right.mas_equalTo(_rightBtn.mas_right).mas_offset(-20);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).mas_offset(-10);
            make.width.mas_offset(40);
            make.height.mas_offset(40);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(0);
            make.right.mas_equalTo(self.mas_right).mas_offset(-0);
            make.height.mas_offset(0.5);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(0);
        }];
    }
    return self;
}

@end


// 群消息cell
@implementation LWSystemGroupMessageCell

- (void)clickSeeBtn
{
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self confiCellUI];
    }
    return self;
}

- (void)confiCellUI
{
    _nameL = [LWLabel lw_lable:@"系统消息" font:16 textColor:BASECOLOR_TEXTCOLOR];
    _timeL = [LWLabel lw_lable:@"2020/04/22  18:20:16" font:12 textColor:BASECOLOR_GREYCOLOR155];
    _descL = [LWLabel lw_lable:@"今日更新了交流大厅模块…今日更新了交流大厅模块.今日更新了交流大厅模块今日更新了交流大厅模块今日更新了交流大厅模块" font:14 textColor:BASECOLOR_GREYCOLOR155];
    _descL.numberOfLines = 3;
    _seeBtn = [LWButton lw_button:@"读取" font:14 textColor:UIColor.whiteColor backColor:BASECOLOR_BLUECOLOR target:self acction:@selector(clickSeeBtn)];
    UIView *line = [UIView new];
    line.backgroundColor = BASECOLOR_BOARD;
    [self.contentView addSubviews:@[_nameL,_timeL,_descL,_seeBtn,line]];
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(20);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-20);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(15);
    }];
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-20);
        make.centerY.mas_equalTo(_nameL.mas_centerY);
    }];
    [_seeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_timeL.mas_right);
        make.width.mas_offset(60);
        make.height.mas_offset(25);
        make.centerY.mas_equalTo(_descL.mas_centerY);
    }];
    [_descL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameL.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(_nameL.mas_left);
        make.right.mas_equalTo(_seeBtn.mas_left).mas_offset(-10);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-15);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
        make.height.mas_offset(1);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(0);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [_seeBtn setBoundWidth:0 cornerRadius:4];
}
@end
