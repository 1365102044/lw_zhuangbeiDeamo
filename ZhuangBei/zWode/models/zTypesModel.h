//
//  zTypesModel.h
//  ZhuangBei
//  性别，学历，工作年限等模型
//  Created by aa on 2020/5/12.
//  Copyright © 2020 aa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface zTypesModel : NSObject<NSCoding>

@property(strong,nonatomic)NSArray * citys;//城市

@property(strong,nonatomic)NSArray * sex;//性别

@property(strong,nonatomic)NSArray * education;//学历

@property(strong,nonatomic)NSArray * rank;//职务

@property(strong,nonatomic)NSArray * companyType;//公司类型

@property(strong,nonatomic)NSArray * jobYear;//工作年限

@property(strong,nonatomic)NSArray * section;//部门

@end

NS_ASSUME_NONNULL_END
