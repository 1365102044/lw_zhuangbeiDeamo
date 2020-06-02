
//
//  LWAddGroupDeatilViewController.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/15.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWAddGroupDeatilViewController.h"
#import "LWTool.h"
#import "IQTextView.h"
@interface LWAddGroupDeatilViewController ()<UITextViewDelegate>
@property (nonatomic, strong) IQTextView * tv;

@end

@implementation LWAddGroupDeatilViewController
//http://test.110zhuangbei.com:8105/app/app/appgroupapply/save
//{"fromUserId":1,"toGroupId":36,"remark":"啊啊啊"}
- (void)confir
{
    NSDictionary *param = @{@"fromUserId":LWDATA(_listModel.userId),@"toGroupId":LWDATA(_listModel.customId),@"remark":LWDATA(_tv.text)};
    NSString *body = [LWTool dictoryToString:param];
    [ServiceManager requestPostWithUrl:@"app/appgroupapply/save" body:body success:^(id  _Nonnull response) {
        if ([response[@"code"] integerValue] == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        [[zHud shareInstance] showMessage:LWDATA(response[@"msg"])];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)aTextfield {
    [aTextfield resignFirstResponder];//关闭键盘
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"申请加群";
    
    [self confiUI];
}

- (void)confiUI
{
    UIImageView *icon = [UIImageView new];
    icon.image = IMAGENAME(@"testtouxiang");
    UILabel *titleL = [LWLabel lw_lable:@"群聊资料" font:15 textColor:BASECOLOR_TEXTCOLOR];
    UILabel *groupnameL = [LWLabel lw_lable:@"平台总群" font:20 textColor:BASECOLOR_TEXTCOLOR];
    UILabel *timeL = [LWLabel lw_lable:@"创建人：admin" font:15 textColor:BASECOLOR_GREYCOLOR155];
    UILabel *creatrenL = [LWLabel lw_lable:@"创建时间：2020-10-10" font:15 textColor:BASECOLOR_GREYCOLOR155];
    UILabel *qunjianjieL = [LWLabel lw_lable:@"群简介" font:17 textColor:BASECOLOR_TEXTCOLOR];
    UILabel *qunjianjiedescL = [LWLabel lw_lable:@"群主很懒" font:15 textColor:BASECOLOR_GREYCOLOR155];
    UILabel *yanzhengL = [LWLabel lw_lable:@"请填写验证信息" font:17 textColor:BASECOLOR_TEXTCOLOR];
    IQTextView *tv = [IQTextView new];
    tv.placeholder = @"大家好...";
    tv.font = kFont(16);
    _tv = tv;
    tv.delegate = self;
    _tv.returnKeyType = UIReturnKeyDone;
    UIButton *surebtn = [UIButton new];
    [surebtn setTitle:@"申请加群" forState:UIControlStateNormal];
    [surebtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    surebtn.titleLabel.font = kFont(16);
    [surebtn addTarget:self action:@selector(confir) forControlEvents:UIControlEventTouchUpInside];
    surebtn.backgroundColor = BASECOLOR_BLUECOLOR;
    [surebtn setBoundWidth:0 cornerRadius:20];
    [tv setBoundWidth:0.5 cornerRadius:4 boardColor:BASECOLOR_BOARD];
    
    [self.view addSubviews:@[titleL,groupnameL,timeL,creatrenL,qunjianjieL,qunjianjiedescL,yanzhengL,tv,icon,surebtn]];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
        make.top.mas_equalTo(self.view.mas_top).mas_offset(20);
    }];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(70);
        make.left.mas_equalTo(titleL.mas_left).mas_offset(0);
        make.top.mas_equalTo(titleL.mas_bottom).mas_offset(10);
    }];
    [groupnameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(icon.mas_right).mas_offset(10);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-10);
        make.top.mas_equalTo(icon.mas_top).mas_offset(0);
    }];
    [creatrenL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(groupnameL.mas_left).mas_offset(0);
        make.right.mas_equalTo(groupnameL.mas_right).mas_offset(-0);
        make.top.mas_equalTo(groupnameL.mas_bottom).mas_offset(10);
    }];
    [timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(groupnameL.mas_left).mas_offset(0);
        make.right.mas_equalTo(groupnameL.mas_right).mas_offset(-0);
        make.top.mas_equalTo(creatrenL.mas_bottom).mas_offset(10);
    }];
    [qunjianjieL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleL.mas_left).mas_offset(0);
        make.right.mas_equalTo(groupnameL.mas_right).mas_offset(-0);
        make.top.mas_equalTo(icon.mas_bottom).mas_offset(20);
    }];
    [qunjianjiedescL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleL.mas_left).mas_offset(0);
        make.right.mas_equalTo(groupnameL.mas_right).mas_offset(-0);
        make.top.mas_equalTo(qunjianjieL.mas_bottom).mas_offset(10);
    }];
    [yanzhengL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleL.mas_left).mas_offset(0);
        make.right.mas_equalTo(groupnameL.mas_right).mas_offset(-0);
        make.top.mas_equalTo(qunjianjiedescL.mas_bottom).mas_offset(20);
    }];
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleL.mas_left).mas_offset(0);
        make.right.mas_equalTo(groupnameL.mas_right).mas_offset(-0);
        make.top.mas_equalTo(yanzhengL.mas_bottom).mas_offset(10);
        make.height.mas_offset(150);
    }];
    
    [surebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-20);
        make.top.mas_equalTo(tv.mas_bottom).mas_offset(40);
        make.height.mas_offset(40);
    }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
