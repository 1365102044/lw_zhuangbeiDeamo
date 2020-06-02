//
//  zPersonalHeader.h
//  ZhuangBei
//
//  Created by aa on 2020/5/3.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^zPersonalHeaderTap)(void);

@interface zPersonalHeader : UIView


@property(copy,nonatomic)zPersonalHeaderTap personalTap;

@property(assign,nonatomic)NSInteger canEdit;

@property(copy,nonatomic)NSString * imageID;

@end

NS_ASSUME_NONNULL_END
