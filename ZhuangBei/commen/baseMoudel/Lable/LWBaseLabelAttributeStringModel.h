//
//  LWBaseLabelAttributeStringModel.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/9.
//  Copyright © 2020 aa. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LWBaseLabelAttributeStringModel : NSObject
/**
 文字颜色
 */
@property (nonatomic, strong) UIColor *color;

/**
 文字字体
 */
@property (nonatomic, strong) UIFont *size;

/**
 文字内容
 */
@property (nonatomic, copy) NSString *content;

/**
 行间距
 */
@property (nonatomic, strong) NSNumber *lineSpacing;

/**
 显示是否居中
 */
@property (nonatomic, copy) NSString *alignment;

@end
