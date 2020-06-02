//
//  zListTypeModel.h
//  ZhuangBei
//  列表通用模型 可以是城市，性别，学历，职位，公司 ，部门等
//  Created by aa on 2020/5/12.
//  Copyright © 2020 aa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface zListTypeModel : NSObject<NSCoding>

@property(strong,nonatomic)NSString * name;
@property(strong,nonatomic)NSString * typeId;

//@property(assign,nonatomic)BOOL checked;

@property(assign,nonatomic)BOOL select;
@end

NS_ASSUME_NONNULL_END
