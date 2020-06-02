//
//  LWUserGroupModel.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/15.
//  Copyright © 2020 aa. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LWUserGroupModel : BaseModel
@property (nonatomic, strong) NSString * typeName;
@property (nonatomic, strong) NSString * userId;
@property (nonatomic, strong) NSString * buildTime;
@property (nonatomic, strong) NSString * isDefault;
@property (nonatomic, strong) NSString * isDefaultShow;
@end

NS_ASSUME_NONNULL_END

/*
 http://test.110zhuangbei.com:8105/app/app/appfriendtype/list
 {
     "code": 0,
     "msg": "success",
     "page": {
         "totalCount": 2,
         "pageSize": 10,
         "totalPage": 1,
         "currPage": 1,
         "list": [{
             "id": 612,
             "typeName": "默认",
             "userId": 688,
             "buildTime": "2020-05-06 11:24:16",
             "isDefault": 1,
             "isDefaultShow": "是"
         }, {
             "id": 624,
             "typeName": "测试",
             "userId": 688,
             "buildTime": "2020-05-14 11:13:08",
             "isDefault": 2,
             "isDefaultShow": "否"
         }]
     }
 }
 */
