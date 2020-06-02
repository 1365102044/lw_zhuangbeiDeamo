//
//  LWSystemListModel.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/14.
//  Copyright © 2020 aa. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface userModel : BaseModel
@property (nonatomic, strong) NSString * username;
@property (nonatomic, strong) NSString * avatar;
@property (nonatomic, strong) NSString * corporateName;
@property (nonatomic, strong) NSString * sign;
@end

@interface LWSystemListModel : BaseModel
//id
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * remark;
@property (nonatomic, strong) NSString * time;
@property (nonatomic, strong) userModel * toUser;
@property (nonatomic, strong) NSString * uid;
@property (nonatomic, strong) NSString * from;
//0等待验证  1同意 2拒绝
@property (nonatomic, assign) NSInteger  status;

@property (nonatomic, assign) NSInteger  read;

//----sys---------
@property (nonatomic, strong) NSString * fromUserId;
@property (nonatomic, strong) NSString * groupApplyId;
@property (nonatomic, strong) NSString * fromUserName;
@property (nonatomic, strong) NSString * fromUserImagesId;
@property (nonatomic, strong) NSString * toGroupId;
@property (nonatomic, strong) NSString * toGroupName;
//@property (nonatomic, strong) NSString * remark;
@property (nonatomic, strong) NSString * applyTime;
@property (nonatomic, strong) NSString * readOrNot;


@end

NS_ASSUME_NONNULL_END

/*
 {
     "code": 0,
     "msg": "success",
     "data": {
         "totalCount": 1,
         "pageSize": 10,
         "totalPage": 1,
         "currPage": 1,
         "list": [
             {
                 "id": 271,
                 "content": "申请添加你为好友",
                 "uid": 696,
                 "from": 688,
                 "from_group": 0,
                 "type": null,
                 "remark": "688 请求添加好友",
                 "href": null,
                 "read": 1,
                 "time": "2020-05-14 11:13:24",
                 "user": {
                     "id": 688,
                     "username": "lwq",
                     "avatar": "/app/app/appfujian/download?attID=3379",
                     "sign": null,
                     "corporateName": null
                 },
                 "status": 1
             }
         ]
     },
     "pages": 1
 }
 */

/*
 系统
 {
     "code": 0,
     "msg": "success",
     "data": {
         "totalCount": 5,
         "pageSize": 1,
         "totalPage": 5,
         "currPage": 10,
         "list": [{
             "groupApplyId": 66,
             "fromUserId": 696,
             "fromUserName": "18820002000",
             "fromUserImagesId": 3379,
             "toGroupId": 77,
             "toGroupName": "测试群",
             "remark": "1 请求入群",
             "applyTime": "2020-05-15 15:45:43",
             "status": 0,
             "readOrNot": 0
         }, {
             "groupApplyId": 65,
             "fromUserId": 435,
             "fromUserName": "13126596191",
             "fromUserImagesId": 3379,
             "toGroupId": 77,
             "toGroupName": "测试群",
             "remark": "1 请求入群",
             "applyTime": "2020-04-28 17:53:07",
             "status": 1,
             "readOrNot": 0
         }, {
             "groupApplyId": 63,
             "fromUserId": 525,
             "fromUserName": "18526061161",
             "fromUserImagesId": 3379,
             "toGroupId": 58,
             "toGroupName": "杨健顾问群",
             "remark": "1 请求入群",
             "applyTime": "2020-04-14 18:19:29",
             "status": 0,
             "readOrNot": 0
         }, {
             "groupApplyId": 64,
             "fromUserId": 525,
             "fromUserName": "18526061161",
             "fromUserImagesId": 3379,
             "toGroupId": 58,
             "toGroupName": "杨健顾问群",
             "remark": "1 请求入群",
             "applyTime": "2020-04-14 18:19:29",
             "status": 0,
             "readOrNot": 0
         }, {
             "groupApplyId": 62,
             "fromUserId": 525,
             "fromUserName": "18526061161",
             "fromUserImagesId": 3379,
             "toGroupId": 58,
             "toGroupName": "杨健顾问群",
             "remark": "1 请求入群",
             "applyTime": "2020-04-14 18:19:27",
             "status": 0,
             "readOrNot": 0
         }]
     },
     "pages": 1
 }
 */
