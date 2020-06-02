//
//  LWHuoYuanDeatilModel.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/8.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWHuoYuanDeatilModel.h"

@implementation productInformationModel

@end

@implementation supplierModel

@end

@implementation modelListModel

@end

@implementation productPictureListModel

@end

@implementation productIntroductionModel

@end

@implementation productParameterListModel

@end

@implementation productEnclosureListModel

@end
@implementation LWHuoYuanDeatilModel

// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"productInformation":productInformationModel.class,
             @"supplier":supplierModel.class,
             @"modelList":modelListModel.class,
             @"productPictureList":productPictureListModel.class,
             @"productIntroduction":productIntroductionModel.class,
             @"productParameterList":productParameterListModel.class,
             @"productEnclosureList":productEnclosureListModel.class,
    };
}
@end
