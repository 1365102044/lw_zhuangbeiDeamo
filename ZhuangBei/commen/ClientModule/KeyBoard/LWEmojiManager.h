//
//  LWEmojiManager.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/19.
//  Copyright © 2020 aa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FaceThemeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LWEmojiManager : NSObject
@property (nonatomic, strong) NSMutableArray<FaceThemeModel *> * emojiMutableArray;

+ (instancetype)share;

- (void)replaceEmojiForAttributedString:(NSMutableAttributedString *)attributedString font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
