//
//  LWJiaoLiuModel.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/11.
//  Copyright © 2020 aa. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface imGroupListModel : BaseModel
@property (nonatomic, strong) NSString * avatar;
@property (nonatomic, strong) NSString * userId;
@property (nonatomic, strong) NSString * appBackgroundImage;
@property (nonatomic, strong) NSString * groupName;

@end

//联系人items
@interface friendItemModel : BaseModel
@property (nonatomic, strong) NSString * username;
@property (nonatomic, strong) NSString * corporateName;
@property (nonatomic, strong) NSString * sign;
@property (nonatomic, strong) NSString * avatar;
@property (nonatomic, strong) NSString * mainProducts;
//id
@property (nonatomic, strong) NSString * avatarID;

@property (nonatomic, strong) NSString * chatNickName;
@property (nonatomic, strong) NSString * sectionName;
@property (nonatomic, strong) NSString * userId;
@property (nonatomic, strong) NSString * portrait; //avatarID

@end

//联系人 组列表
@interface friendListModel : BaseModel
@property (nonatomic, strong) NSString * groupname;
@property (nonatomic, strong) NSString * online;
//id
@property (nonatomic, strong) NSArray<friendItemModel *> * list;
@property (nonatomic, assign) BOOL  isShow;
@end


@interface LWJiaoLiuModel : BaseModel
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * userId;
@property (nonatomic, strong) NSArray<imGroupListModel *> * imGroupList;
@property (nonatomic, strong) NSArray<imGroupListModel *> * group;
@property (nonatomic, strong) NSString * avatar;

//@property (nonatomic, strong) NSArray<friendListModel *> * friend;
@end

NS_ASSUME_NONNULL_END

/*
 {
     "code": 0,
     "msg": "success",
     "data": {
         "mine": {
             "id": 695,
             "username": "北京真格lw1000-销售部-总经理",
             "avatar": "/app/app/appfujian/download?attID=3379",
             "sign": null,
             "corporateName": null
         },
         "friend": [{
             "id": 620,
             "groupname": "默认",
             "online": null,
             "list": [{
                 "id": 688,
                 "username": "【未认证用户】 -lwq",
                 "avatar": "/app/app/appfujian/download?attID=3379",
                 "sign": null,
                 "corporateName": null
             }]
         }, {
             "id": 625,
             "groupname": "测试",
             "online": null,
             "list": [{
                 "id": 696,
                 "username": "【未认证用户】 -刘文",
                 "avatar": "/app/app/appfujian/download?attID=3379",
                 "sign": null,
                 "corporateName": null
             }]
         }],
         "group": [{
             "id": 36,
             "groupname": "平台总群",
             "avatar": "/app/app/appfujian/download?attID=/app/app/appfujian/download?attID=/app/app/appfujian/download?attID=3379"
         }, {
             "id": 45,
             "groupname": "特巡警装备/软件交流群",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 46,
             "groupname": "警保装备/软件交流群",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 47,
             "groupname": "刑侦装备/软件交流群",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 48,
             "groupname": "禁毒装备/软件交流群",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 49,
             "groupname": "交警装备/软件交流群",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 50,
             "groupname": "监所装备/软件交流群",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 51,
             "groupname": "法制装备/软件交流群",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 52,
             "groupname": "东北地区交流群",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 53,
             "groupname": "华北地区交流群",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 54,
             "groupname": "华中地区交流群",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 55,
             "groupname": "华东地区交流群",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 56,
             "groupname": "东南地区交流群",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 57,
             "groupname": "华南地区交流群",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 61,
             "groupname": "新产品申报",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 62,
             "groupname": "爆款申请",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 63,
             "groupname": "投诉建议",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 64,
             "groupname": "西北地区交流群",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 65,
             "groupname": "西南地区交流群",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }]
     }
 }

 */


/*
 {
     "code": 0,
     "msg": "success",
     "list": {
         "userId": 747,
         "userBh": null,
         "userDm": 688,
         "userName": "lwq",
         "minsummary": "哈哈哈哈",
         "birth": null,
         "isShowBirth": 0,
         "jobYear": null,
         "isShowJobYear": 0,
         "nativePlace": null,
         "headSet": null,
         "mobile": "18801040890",
         "isShowMobile": 0,
         "email": "42253@163.com",
         "jobName": null,
         "wordShow": null,
         "sex": 0,
         "education": null,
         "isShowEducation": 0,
         "nation": null,
         "provinceId": null,
         "provinceName": null,
         "cityId": null,
         "cityName": null,
         "marriagestatus": null,
         "politicalstatus": null,
         "height": null,
         "weight": null,
         "portrait": 3379,
         "chaungJianRq": "2020-05-06 08:00:00",
         "chuangJianR": null,
         "xiuGaiRq": null,
         "xiuGaiR": null,
         "suoShuGs": 626,
         "suoShuGsName": "北京真格科技",
         "suoShuGsCompanyType": null,
         "suoShuGsCreditCodeState": null,
         "status": null,
         "post": 1,
         "jobId": null,
         "rankDm": null,
         "buMen": 1,
         "quanXianDm": null,
         "quanXianMc": null,
         "shiFouGly": 0,
         "followStatus": null,
         "district": null,
         "districtIdList": null,
         "quJson": null,
         "xmJson": null,
         "jyJson": null,
         "gzJson": null,
         "userName2": null,
         "email2": null,
         "mobile2": null,
         "jobName2": null,
         "companyType": null,
         "companyNameFirst": "北京",
         "companyNameSecond": "真格",
         "companyNameThird": "科技",
         "regLocation": 110000,
         "chatNickName": "北京真格lwq-销售部-总经理",
         "mainProduct": null,
         "sexName": "女",
         "sectionName": "销售部",
         "rankName": null
     },
     "provinceList": []
 }
 
 */
