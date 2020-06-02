//
//  LWBaseAlearView.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/17.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWAlearCustomManagerView.h"


@interface LWAlearCustomManagerView()

@property (nonatomic, strong) UIView * bgview;

@end

@implementation LWAlearCustomManagerView

+ (instancetype)showAlearView:(UIView *)mainview
{
    LWAlearCustomManagerView *v = [LWAlearCustomManagerView new];
    v.mainView = mainview;
    [v confiUI];
    return v;
}

- (void)confiUI
{
    _bgview = [UIView new];
    _bgview.backgroundColor = UIColor.blackColor;
    _bgview.alpha = 0.3;
    [_bgview ex_addTapAction:self selector:@selector(dimiss)];
    
//    NSAssert(!_mainView, @"主体视图不能为空");
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubviews:@[_bgview,_mainView]];
    
    [_bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(window);
    }];
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(250);
        make.width.mas_offset(300);
        make.centerX.mas_equalTo(window.mas_centerX);
        make.centerY.mas_equalTo(window.mas_centerY);
    }];
    
    [_mainView setBoundWidth:0 cornerRadius:4];
}

- (void)dimiss
{
    [_mainView removeFromSuperview];
    [_bgview removeFromSuperview];
    _mainView = nil;
    _bgview = nil;
}

+ (instancetype)showAddNewUserGroupView:(clikBtntfBlock)block
{
    LWAddNewUserGroupView *temview = [[NSBundle mainBundle] loadNibNamed:@"LWAddNewUserGroupView" owner:self options:nil].firstObject;
    LWAlearCustomManagerView *view = [LWAlearCustomManagerView showAlearView:temview];
    temview.block = ^(NSInteger tag) {
        [view dimiss];
        if(tag == 2){
            if (block) {
                block(temview.tf.text,temview.isDeflutBtn.selected);
            }
        }
    };
    return view;
}

@end


@interface LWAddNewUserGroupView()
@property (nonatomic, strong) UIView * bgview;
@end
@implementation LWAddNewUserGroupView

- (IBAction)clickCancleBtn:(id)sender {
    if (self.block) {
        self.block(1);
    }
}

- (IBAction)clickSure:(id)sender {
    if (self.block) {
        self.block(2);
    }
}

- (IBAction)clickdeflutBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self =[[NSBundle mainBundle] loadNibNamed:@"LWAddNewUserGroupView" owner:self options:nil].firstObject;
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];

    [self.isDeflutBtn setImage:IMAGENAME(@"chose_select") forState:UIControlStateSelected];
    [self.isDeflutBtn setImage:IMAGENAME(@"chose_normal") forState:UIControlStateNormal];
}
@end
