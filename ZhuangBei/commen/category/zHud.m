//
//  zHud.m
//  ZhuangBei
//
//  Created by aa on 2020/4/25.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zHud.h"
#import "MBProgressHUD.h"
@interface zHud ()

@property(strong,nonatomic)MBProgressHUD *hud;

@end

@implementation zHud

+(zHud*)shareInstance
{
    static zHud *_zHud = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _zHud = [[super allocWithZone:NULL] init];
    });
    return _zHud;
}

-(UIWindow *)mainWindow
{
    UIApplication *app = [UIApplication sharedApplication];
    return [app keyWindow];
    
}

-(void)showMessage:(NSString*)message{
    UIView * view = [self mainWindow];
    self.hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    self.hud.mode = MBProgressHUDModeText;
    self.hud.label.text = message;
    [self.hud hideAnimated:YES afterDelay:1.f];
}

-(void)show{
//     UIView * view = [self mainWindow];
//     self.hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//     self.hud.mode = MBProgressHUDModeIndeterminate;
//     self.hud.label.text = @"";
    UIView * view = [self mainWindow];
    MBProgressHUD * hudView = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [hudView showAnimated:YES];
}

-(void)hild{
    
//    [self.hud hideAnimated:YES];
    UIView * view = [self mainWindow];
//    MBProgressHUD * hudView = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    [hudView showAnimated:YES];
    [MBProgressHUD hideHUDForView:view animated:YES];
}


+(void)show
{
    [[zHud shareInstance] show];
}
+(void)hild
{
    [[zHud shareInstance] hild];
}
+ (void)showMessage:(NSString*)message{
    [[zHud shareInstance] showMessage:message];
}

@end
