//
//  zXieYiController.m
//  ZhuangBei
//
//  Created by aa on 2020/5/8.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zXieYiController.h"
#import "BAKit_WebView.h"
//#import "WebVIewModel.h"

#define  khtmlUrl @"http://www.110zhuangbei.com/app/app/appagreement/agreementTypeFirst?agreementType="

@interface zXieYiController ()

//@property(nonatomic, strong) WebVIewModel *model;
@property(nonatomic, strong) WKWebView *webView;

@end

@implementation zXieYiController

- (WKWebView *)webView
{
    if (!_webView)
    {
        _webView = [WKWebView new];
//        _webView.ba_web_isAutoHeight = YES;
        //  添加 WKWebView 的代理，注意：用此方法添加代理
        BAKit_WeakSelf
        [_webView ba_web_initWithDelegate:weak_self.webView uIDelegate:weak_self.webView];
        
        _webView.backgroundColor = [UIColor colorWithHexString:@"#FAFAFA"];
        self.webView.ba_web_getCurrentHeightBlock = ^(CGFloat currentHeight) {
            BAKit_StrongSelf
//            self.cell_height = currentHeight;
            NSLog(@"html 高度2：%f", currentHeight);
        };

        _webView.ba_web_isLoadingBlock = ^(BOOL isLoading, CGFloat progress) {
            if (isLoading) {
//                [[PHud hud]progressingShowWithView:weak_self.view];
            }else
            {
//                [[PHud hud]progressingHide];
            }
        };
        
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#FAFAFA"];
    [self.view addSubview:self.webView];
    [self getDataurl:[NSString stringWithFormat:@"%@%ld",khtmlUrl,(long)self.type] withParam:@{}];
    
//    [self.webView ba_web_loadURLString:self.htmlStr];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.webView.frame = CGRectMake(0,1,self.view.bounds.size.width,self.view.bounds.size.height-1);
}

-(void)setHtmlStr:(NSString *)htmlStr
{
    [self.webView ba_web_loadURLString:htmlStr];
}


-(void)RequsetFileWithUrl:(NSString*)url WithError:(NSError*)err
{
    if ([url containsString:khtmlUrl]) {
        [[zHud shareInstance]showMessage:@"获取验协议失败"];
        return;
    }
}

-(void)RequsetSuccessWithData:(id)data AndUrl:(NSString*)url
{
    if ([url containsString:khtmlUrl]) {
        NSDictionary * dic = data;
//        NSLog(@"验证码成功%@",dic);
        NSString * msg = dic[@"msg"];
        NSString * code = dic[@"code"];
        if ([code integerValue] == 0) {
            NSString * htmlContent = dic[@"appAgreement"][@"agreementContent"];
            [self.webView loadHTMLString:htmlContent baseURL:nil];
        }else
        {
            [[zHud shareInstance]showMessage:msg];
        }
        
    }
}



@end
