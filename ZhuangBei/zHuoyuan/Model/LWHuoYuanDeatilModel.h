//
//  LWHuoYuanDeatilModel.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/8.
//  Copyright © 2020 aa. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface productInformationModel : BaseModel
//装备名
@property (nonatomic, strong) NSString * zbName;
  //别称
@property (nonatomic, strong) NSString * zbBieMing;
//供应来源
@property (nonatomic, strong) NSString * productSourceName;
@end

// 公司信息
@interface supplierModel : BaseModel
//公司名
@property (nonatomic, strong) NSString * name;
//n北京
@property (nonatomic, strong) NSString * companyNameFirst;
@end

//型号
@interface modelListModel : BaseModel
// //产品型号
@property (nonatomic, strong) NSString * model;
//@property (nonatomic, strong) NSString * id;
//供应商产品关联id
@property (nonatomic, strong) NSString * providerProductId;
@end


//图片
@interface productPictureListModel : BaseModel
//// 下载地址
//@property (nonatomic, strong) NSString * src;
//// OSS服务器下载地址
//@property (nonatomic, strong) NSString * ossDownloadSrc;
//主键
@property (nonatomic, strong) NSString * tuPianDm;
@property (nonatomic, strong) NSString * fuJianDm;

@end

//产品介绍
@interface productIntroductionModel : BaseModel
@property (nonatomic, strong) NSString * jianJieNr;

@end

//参数列表
@interface productParameterListModel : BaseModel
//参数名称
@property (nonatomic, strong) NSString * canShuMc;
//参数值
@property (nonatomic, strong) NSString * canShuZhi;
@property (nonatomic, assign) NSInteger  canShuLx;

@end
//操作手册
@interface productEnclosureListModel : BaseModel
@property (nonatomic, strong) NSString * name;
//@property (nonatomic, strong) NSString * <#name#>;

@end

@interface LWHuoYuanDeatilModel : BaseModel
//选中产品型号id
@property (nonatomic, strong) NSString * modelId;
//关注状态: 1:已关注(展示"取消关注")2:未关注(展示"关注货源")3:无需关注(是自己公司的产品不需要展示相关按钮)
@property (nonatomic, assign) NSInteger  isFollow;
@property (nonatomic, strong) productInformationModel * productInformation;
@property (nonatomic, strong) supplierModel * supplier;
@property (nonatomic, strong) NSArray<modelListModel *> * modelList;
@property (nonatomic, strong) NSArray<productPictureListModel *> * productPictureList;
@property (nonatomic, strong) productIntroductionModel * productIntroduction;
@property (nonatomic, strong) NSArray<productParameterListModel *> * productParameterList;
@property (nonatomic, strong) NSArray<productEnclosureListModel *> * productEnclosureList;

@end


NS_ASSUME_NONNULL_END
