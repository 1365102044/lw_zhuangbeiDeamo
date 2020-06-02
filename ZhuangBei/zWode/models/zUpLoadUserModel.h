//
//  zUpLoadUserModel.h
//  ZhuangBei
//
//  Created by aa on 2020/5/12.
//  Copyright © 2020 aa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface zUpLoadUserModel : NSObject

@property(copy,nonatomic)NSString * birth;//1991-05-12
@property(copy,nonatomic)NSString * buMen;
@property(copy,nonatomic)NSString * education;//学历

@property(copy,nonatomic)NSString * companyNameFirst;
@property(copy,nonatomic)NSString * companyNameSecond;
@property(copy,nonatomic)NSString * companyNameThird;
//@property(assign,nonatomic)NSInteger suoShuGs;//公司id
//@property(copy,nonatomic)NSString * suoShuGsName;//公司名
@property(copy,nonatomic)NSString * companyType;//公司类型


@property(copy,nonatomic)NSString * district; //管辖区域 多个用，分割 “100，110，120”
@property(copy,nonatomic)NSString * email;
@property(assign,nonatomic)NSInteger  isShowBirth;
@property(assign,nonatomic)NSInteger isShowEducation;
@property(assign,nonatomic)NSInteger isShowJobYear;
@property(assign,nonatomic)NSInteger isShowMobile;
@property(assign,nonatomic)NSInteger shiFouGly;
@property(copy,nonatomic)NSString * mobile;
@property(copy,nonatomic)NSString * portrait;//从user里面取
@property(copy,nonatomic)NSString * post;//职务
@property(copy,nonatomic)NSString * regLocation;//公司所在地
@property(copy,nonatomic)NSString * nativePlace;//籍贯 410000
@property(copy,nonatomic)NSString * jobYear;//工作年限
@property(copy,nonatomic)NSString * sex;
@property(assign,nonatomic)NSInteger userDm;//从user里面获取
@property(assign,nonatomic)NSInteger  userId;
@property(copy,nonatomic)NSString * userName;


@end

NS_ASSUME_NONNULL_END
