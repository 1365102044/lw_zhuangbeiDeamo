//
//  zCityEditFooter.h
//  ZhuangBei
//
//  Created by aa on 2020/5/3.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^buttonTapBack)(NSInteger type);

@interface zCityEditFooter : UIView

@property(copy,nonatomic)buttonTapBack tapBack;

@property(assign,nonatomic)BOOL canEdit;

@end

NS_ASSUME_NONNULL_END
