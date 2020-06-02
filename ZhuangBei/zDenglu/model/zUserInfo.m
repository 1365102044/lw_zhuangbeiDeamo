//
//  zUserInfo.m
//  ZhuangBei
//
//  Created by aa on 2020/4/28.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zUserInfo.h"
#import "LWClientManager.h"

static NSString * UserDefaultRemmberAccount = @"UserDefaultRemmberAccount";
static NSString * UserDefaultPassword = @"UserDefaultPassword";
static NSString * UserDefaultPhoneNum = @"UserDefaultPhoneNum";
static NSString * UserDefaultInfo = @"userInfo.archiver";

@implementation zUserInfo

+(zUserInfo*)shareInstance
{
    static zUserInfo *_userInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _userInfo = [[self alloc]init];
    });
    return _userInfo;
}

-(instancetype)init
{
    if (self = [super init]) {
//        NSUserDefaults * accountDefaults = [NSUserDefaults standardUserDefaults];
//        NSString *phonenum = [accountDefaults objectForKey:UserDefaultPhoneNum];
//        NSString *password = [accountDefaults objectForKey:UserDefaultPassword];
//        NSString *remmber = [accountDefaults objectForKey:UserDefaultRemmberAccount];
        
        NSString * temp  = NSTemporaryDirectory();
        NSString * filePath = [temp stringByAppendingPathComponent:UserDefaultInfo];
        zUserModel *userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        self.remmberAccount = userInfo.remmberPassword;
        self.userAccount = userInfo.username;
        self.userPassWord = userInfo.userPassWord;
        self.userInfo = userInfo;
    }
    return self;
}




-(void)setUserAccount:(NSString *)userAccount
{
    _userAccount = userAccount;

}

-(void)setUserPassWord:(NSString *)userPassWord
{
    _userPassWord = userPassWord;
}

-(void)deleate{
    self.userInfo = [[zUserModel alloc]init];
    self.userInfo.remmberPassword = self.remmberAccount;
    if ([self.remmberAccount isEqualToString:@"1"]) {
        self.userInfo.username = self.userAccount;
        self.userInfo.userPassWord = self.userPassWord;
    }else
    {
        //删除账号密码
    }
    NSString * temp  = NSTemporaryDirectory();
    NSString * filePath = [temp stringByAppendingPathComponent:UserDefaultInfo];
    [NSKeyedArchiver archiveRootObject:self.userInfo toFile:filePath];
    
    [LWClientManager.share userLogout];
    [LWClientManager removeLocalChatRecord];
}

-(void)saveUserInfo
{
    if (_userPassWord.length>0 && _userAccount.length>0) {
        NSLog(@"储存 账号:%@ \n密码:%@",_userAccount,_userPassWord);
//        NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
//        [accountDefaults setObject:self.remmberAccount forKey:UserDefaultRemmberAccount];
//        if ([self.remmberAccount isEqualToString:@"1"]) {
//            [accountDefaults setObject:self.userAccount forKey:UserDefaultPassword];
//            [accountDefaults setObject:self.userPassWord forKey:UserDefaultPhoneNum];
//        }else
//        {
//
//        }
        self.userInfo.userPassWord = self.userPassWord;
        self.userInfo.remmberPassword = self.remmberAccount;
        NSString * temp  = NSTemporaryDirectory();
        NSString * filePath = [temp stringByAppendingPathComponent:UserDefaultInfo];
        [NSKeyedArchiver archiveRootObject:self.userInfo toFile:filePath];
        
        [[LWClientManager share] configureUserId];
    }else
    {
        NSLog(@"账号或密码为空");
    }
    
//    读取本地存储
    
}


@end
