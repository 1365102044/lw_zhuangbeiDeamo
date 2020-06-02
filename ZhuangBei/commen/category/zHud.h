//
//  zHud.h
//  ZhuangBei
//
//  Created by aa on 2020/4/25.
//  Copyright © 2020 aa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface zHud : NSObject

+(zHud*)shareInstance;

-(void)showMessage:(NSString*)message;

-(void)show;

-(void)hild;

+ (void)showMessage:(NSString*)message;
+(void)hild;
+(void)show;

@end

NS_ASSUME_NONNULL_END
