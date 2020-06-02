//
//  zGoodsContentModel.h
//  ZhuangBei
//
//  Created by aa on 2020/5/18.
//  Copyright © 2020 aa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface zGoodsContentModel : NSObject

@property(assign,nonatomic)NSInteger response;
@property(copy,nonatomic)NSString * mainProduct;
@property(copy,nonatomic)NSString * zhuangbeiNames;
@property(assign,nonatomic)NSInteger  jiBieBc;
@property(assign,nonatomic)NSInteger  gysFuJianId;
@property(assign,nonatomic)NSInteger  goodsid;//

@property(strong,nonatomic)NSArray *  zhuangbeiEntityList;//goodsid
@property(copy,nonatomic)NSString * approveText;
@property(assign,nonatomic)NSInteger  shiFouZx;
@property(assign,nonatomic)NSInteger  isHot;
@property(copy,nonatomic)NSString * companyNameThird;
@property(copy,nonatomic)NSString * gongSiJj;
@property(copy,nonatomic)NSString * qiYeDz;
@property(copy,nonatomic)NSString * gongSiUrl;
@property(copy,nonatomic)NSString * jiBieBcMc;
@property(copy,nonatomic)NSString * strLocationName;
@property(copy,nonatomic)NSString * companyTypeStr;
@property(copy,nonatomic)NSString * zhuangbeiIds;
@property(copy,nonatomic)NSString * mainPoliceClassification;
@property(copy,nonatomic)NSString * yingYeQx;
@property(assign,nonatomic)NSInteger  creditCode;
@property(copy,nonatomic)NSString * companyNameFirst;
@property(assign,nonatomic)NSInteger  jiBie;
@property(copy,nonatomic)NSString * isGuanzhu;
@property(copy,nonatomic)NSString * duiGongZh;
@property(copy,nonatomic)NSString * name;
@property(copy,nonatomic)NSString * jiBieMc;
@property(copy,nonatomic)NSString * creditCodeStateName;
@property(copy,nonatomic)NSString * zhuceDi;
@property(copy,nonatomic)NSString * kaihuYinhang;
@property(copy,nonatomic)NSString * email;
@property(copy,nonatomic)NSString * createDate;
@property(copy,nonatomic)NSString * userName;
@property(copy,nonatomic)NSString * faRen;
@property(copy,nonatomic)NSString * phone;
@property(copy,nonatomic)NSString * companyNameSecond;

@property(copy,nonatomic)NSString * regLocation;

@property(copy,nonatomic)NSString * companyType;




@end

NS_ASSUME_NONNULL_END
