//
//  QuestionModel.h
//  chose
//
//  Created by aa on 2019/12/2.
//  Copyright © 2019 aa. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface QuestionModel : NSObject

@property(copy,nonatomic)NSString * questionName;//问题描述
@property(copy,nonatomic)NSString * questionType;//问题分类 danxt
@property(copy,nonatomic)NSString * createDate;
@property(copy,nonatomic)NSString * activeState;
@property(copy,nonatomic)NSString * questionId;
@property(strong,nonatomic)NSArray * optionList;//选项

@property(assign,nonatomic)NSInteger QuestionIndex;
@end

NS_ASSUME_NONNULL_END
