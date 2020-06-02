//
//  LWGroupMemberListModel.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/19.
//  Copyright © 2020 aa. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LWGroupMemberListModel : BaseModel
@property (nonatomic, strong) NSString * username;
@property (nonatomic, strong) NSString * avatar;
@property (nonatomic, strong) NSString * sign;
@property (nonatomic, strong) NSString * corporateName;

@end

NS_ASSUME_NONNULL_END
