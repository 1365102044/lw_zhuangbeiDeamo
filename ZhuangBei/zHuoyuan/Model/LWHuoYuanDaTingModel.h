//
//  LWHuoYuanDaTingModel.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/6.
//  Copyright © 2020 aa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

//货源大厅 一级
@interface LWHuoYuanDaTingModel : BaseModel
//@property (nonatomic, strong) NSString * id;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * parentId;
@property (nonatomic, strong) NSString * imagesId;
@property (nonatomic, strong) NSString * orderNum;

@end



@interface gysListModel : BaseModel
//企业名称第一个字段
@property (nonatomic, strong) NSString * companyNameFirst;
//企业名称第二个字段
@property (nonatomic, strong) NSString * companyNameSecond;
//企业名称第三个字段
@property (nonatomic, strong) NSString * companyNameThird;

@property (nonatomic, strong) NSString * faRen;
@property (nonatomic, strong) NSString * phone;
@property (nonatomic, strong) NSString * gongSiUrl;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * imagesId;
@property (nonatomic, strong) NSString * gongSiJj;

@end

//货源大厅三级列表
@interface LWHuoYuanThreeLevelModel : BaseModel
//装备类型父名称
@property (nonatomic, strong) NSString * zblxPName;
//装备类型名称
@property (nonatomic, strong) NSString * zblxName;
//装备名称
@property (nonatomic, strong) NSString * zbName;
//装备图片
@property (nonatomic, strong) NSString * imgId;
@property (nonatomic, strong) NSArray <gysListModel *> * gysList;
////装备id
@property (nonatomic, strong) NSString * zbId;
//装备类型id
@property (nonatomic, strong) NSString * zblxId;
//装备类型父id
@property (nonatomic, strong) NSString * zblxPId;

@end

NS_ASSUME_NONNULL_END
