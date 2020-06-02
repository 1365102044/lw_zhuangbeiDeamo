//
//  zEducationRankTypeInfo.h
//  ZhuangBei
//
//  Created by aa on 2020/5/12.
//  Copyright © 2020 aa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "zTypesModel.h"
#import "zUserCenterModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface zEducationRankTypeInfo : NSObject

+(zEducationRankTypeInfo*)shareInstance;

@property(strong,nonatomic)NSArray * citys;

@property(strong,nonatomic)zUserCenterModel * userInfoModel;

@property(strong,nonatomic)zTypesModel * typesModel;//sex 性别 education 学历，rank职务，companyType 公司类型 jobYear工作年限 section 部门

-(void)saveTypeInfo;
-(void)deleate;

@end

NS_ASSUME_NONNULL_END
