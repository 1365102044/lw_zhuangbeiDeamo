//
//  zEducationRankTypeInfo.m
//  ZhuangBei
//
//  Created by aa on 2020/5/12.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zEducationRankTypeInfo.h"


static NSString * typeInfo = @"typeInfo.archiver";

@implementation zEducationRankTypeInfo

+(zEducationRankTypeInfo*)shareInstance
{
    static zEducationRankTypeInfo *_userInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _userInfo = [[self alloc]init];
    });
    return _userInfo;
}

-(instancetype)init
{
    if (self = [super init]) {
        NSString * temp  = NSTemporaryDirectory();
        NSString * filePath = [temp stringByAppendingPathComponent:typeInfo];
        zTypesModel *types = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        self.typesModel = types;
    }
    return self;
}


-(void)deleate{
    self.typesModel = nil;
    NSString * temp  = NSTemporaryDirectory();
    NSString * filePath = [temp stringByAppendingPathComponent:typeInfo];
    [NSKeyedArchiver archiveRootObject:self.typesModel toFile:filePath];
}

-(void)saveTypeInfo
{

    NSString * temp  = NSTemporaryDirectory();
    NSString * filePath = [temp stringByAppendingPathComponent:typeInfo];
    [NSKeyedArchiver archiveRootObject:self.typesModel toFile:filePath];
//    读取本地存储
    
}


@end
