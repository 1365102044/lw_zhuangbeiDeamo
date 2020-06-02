//
//  QuestionFootView.h
//  ZhuangBei
//  //提交答案
//  Created by aa on 2020/4/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^addAnswerTapBack)(void);

@interface QuestionFootView : UIView

@property(copy,nonatomic)addAnswerTapBack addAnswerBack;
@end

NS_ASSUME_NONNULL_END
