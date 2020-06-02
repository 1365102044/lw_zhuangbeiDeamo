//
//  zUserCenterModel.h
//  ZhuangBei
//  个人中心获取到的用户数据
//  Created by aa on 2020/5/13.
//  Copyright © 2020 aa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//有些冗余
@interface zUserCenterModel : NSObject<NSCoding>

@property(assign,nonatomic)NSInteger  userId;
@property(copy,nonatomic)NSString * userBh;
@property(assign,nonatomic)NSInteger userDm;
@property(copy,nonatomic)NSString * userName;
@property(copy,nonatomic)NSString * minsummary;
@property(copy,nonatomic)NSString * birth;
@property(assign,nonatomic)NSInteger  isShowBirth;
@property(assign,nonatomic)NSInteger  isShowJobYear;
@property(copy,nonatomic)NSString * nativePlace;
@property(copy,nonatomic)NSString * headSet;
@property(copy,nonatomic)NSString * mobile;
@property(assign,nonatomic)NSInteger isShowMobile;
@property(copy,nonatomic)NSString * email;
@property(copy,nonatomic)NSString * jobYear;
@property(copy,nonatomic)NSString * jobName;
@property(copy,nonatomic)NSString * sex;
@property(copy,nonatomic)NSString * education;
@property(assign,nonatomic)NSInteger isShowEducation;
@property(copy,nonatomic)NSString * nation;
@property(copy,nonatomic)NSString * provinceId;
@property(copy,nonatomic)NSString * provinceName;
@property(copy,nonatomic)NSString * cityId;
@property(copy,nonatomic)NSString * cityName;
@property(copy,nonatomic)NSString * marriagestatus;
@property(copy,nonatomic)NSString * politicalstatus;
@property(copy,nonatomic)NSString * height;
@property(copy,nonatomic)NSString * weight;
@property(copy,nonatomic)NSString * portrait;
@property(copy,nonatomic)NSString * chaungJianRq;
@property(copy,nonatomic)NSString * chuangJianR;
@property(copy,nonatomic)NSString * xiuGaiRq;
@property(copy,nonatomic)NSString * xiuGaiR;
@property(copy,nonatomic)NSString * suoShuGs;
@property(copy,nonatomic)NSString * suoShuGsName;
@property(copy,nonatomic)NSString * suoShuGsCompanyType;
@property(copy,nonatomic)NSString * suoShuGsCreditCodeState;
@property(copy,nonatomic)NSString * status;
@property(copy,nonatomic)NSString * post;
@property(copy,nonatomic)NSString * jobId;
@property(copy,nonatomic)NSString * rankDm;
@property(copy,nonatomic)NSString * buMen;
@property(copy,nonatomic)NSString * quanXianDm;
@property(copy,nonatomic)NSString * quanXianMc;
@property(copy,nonatomic)NSString * shiFouGly;
@property(copy,nonatomic)NSString * followStatus;
@property(copy,nonatomic)NSString * district;
@property(copy,nonatomic)NSString * districtIdList;
@property(copy,nonatomic)NSString * quJson;
@property(copy,nonatomic)NSString * xmJson;
@property(copy,nonatomic)NSString * jyJson;
@property(copy,nonatomic)NSString * gzJson;
@property(copy,nonatomic)NSString * userName2;
@property(copy,nonatomic)NSString * email2;
@property(copy,nonatomic)NSString * mobile2;
@property(copy,nonatomic)NSString * jobName2;
@property(copy,nonatomic)NSString * companyType;
@property(copy,nonatomic)NSString * companyNameFirst;
@property(copy,nonatomic)NSString * companyNameSecond;
@property(copy,nonatomic)NSString * companyNameThird;
@property(copy,nonatomic)NSString * regLocation;

@end

NS_ASSUME_NONNULL_END
