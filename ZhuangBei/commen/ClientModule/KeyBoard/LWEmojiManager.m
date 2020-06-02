//
//  LWEmojiManager.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/19.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWEmojiManager.h"
#import "PPUtil.h"

@interface PPStickerMatchingResult : NSObject
@property (nonatomic, assign) NSRange range;                    // 匹配到的表情包文本的range
@property (nonatomic, strong) UIImage *emojiImage;              // 如果能在本地找到emoji的图片，则此值不为空
@property (nonatomic, strong) NSString *showingDescription;     // 表情的实际文本(形如：[哈哈])，不为空
@end

@implementation PPStickerMatchingResult

@end

@implementation LWEmojiManager

+ (instancetype)share
{
    static LWEmojiManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [LWEmojiManager new];
        [instance loadFaceEmoji];
    });
    return instance;
}

- (void)loadFaceEmoji
{
    NSMutableArray *subjectArray = [NSMutableArray array];
    NSArray *sources = @[@"face"];
       
       for (int i = 0; i < sources.count; ++i)
       {
           NSString *plistName = sources[i];
           NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
           NSArray *faceArr =  [NSArray arrayWithContentsOfFile:plistPath];
           FaceThemeModel *themeM = [[FaceThemeModel alloc] init];
           themeM.themeStyle = FaceThemeStyleCustomEmoji;
           themeM.themeDecribe = @"Emoji";
           
           NSMutableArray *modelsArr = [NSMutableArray array];
           for (NSDictionary *dict in faceArr) {
               NSString *name = dict[@"desc"];
               FaceModel *fm = [[FaceModel alloc] init];
               fm.faceTitle = name;
               fm.faceIcon = dict[@"image"];
               [modelsArr addObject:fm];
           }
           themeM.faceModels = modelsArr;
           [subjectArray addObject:themeM];
       }
    self.emojiMutableArray = subjectArray;
}
#pragma mark - public method

- (void)replaceEmojiForAttributedString:(NSMutableAttributedString *)attributedString font:(UIFont *)font
{
    if (!attributedString || !attributedString.length || !font) {
        return;
    }

    NSArray<PPStickerMatchingResult *> *matchingResults = [self matchingEmojiForString:attributedString.string];

    if (matchingResults && matchingResults.count) {
        NSUInteger offset = 0;
        for (PPStickerMatchingResult *result in matchingResults) {
            if (result.emojiImage) {
                CGFloat emojiHeight = font.lineHeight;
                NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
                attachment.image = result.emojiImage;
                attachment.bounds = CGRectMake(0, font.descender, emojiHeight, emojiHeight);
                NSMutableAttributedString *emojiAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
                [emojiAttributedString pp_setTextBackedString:[PPTextBackedString stringWithString:result.showingDescription] range:NSMakeRange(0, emojiAttributedString.length)];
                if (!emojiAttributedString) {
                    continue;
                }
                NSRange actualRange = NSMakeRange(result.range.location - offset, result.showingDescription.length);
                [attributedString replaceCharactersInRange:actualRange withAttributedString:emojiAttributedString];
                offset += result.showingDescription.length - emojiAttributedString.length;
            }
        }
    }
}

#pragma mark - private method

- (NSArray<PPStickerMatchingResult *> *)matchingEmojiForString:(NSString *)string
{
    if (!string.length) {
        return nil;
    }
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"face\\[.+?\\]" options:0 error:NULL];
    NSArray<NSTextCheckingResult *> *results = [regex matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    if (results && results.count) {
        NSMutableArray *emojiMatchingResults = [[NSMutableArray alloc] init];
        for (NSTextCheckingResult *result in results) {
            NSString *showingDescription = [string substringWithRange:result.range];
//            NSString *emojiSubString = [showingDescription substringFromIndex:1];       // 去掉[
//            emojiSubString = [emojiSubString substringWithRange:NSMakeRange(0, emojiSubString.length - 1)];    // 去掉]
            FaceModel *emoji = [self emojiWithEmojiDescription:showingDescription];
            if (emoji) {
                PPStickerMatchingResult *emojiMatchingResult = [[PPStickerMatchingResult alloc] init];
                emojiMatchingResult.range = result.range;
                emojiMatchingResult.showingDescription = showingDescription;
                emojiMatchingResult.emojiImage = [UIImage imageNamed:[@"emoji.bundle" stringByAppendingPathComponent:emoji.faceIcon]];
                [emojiMatchingResults addObject:emojiMatchingResult];
            }
        }
        return emojiMatchingResults;
    }
    return nil;
}

- (FaceModel *)emojiWithEmojiDescription:(NSString *)emojiDescription
{
    for (FaceThemeModel *sticker in self.emojiMutableArray) {
        for (FaceModel *emoji in sticker.faceModels) {
            if ([emoji.faceTitle isEqualToString:emojiDescription]) {
                return emoji;
            }
        }
    }
    return nil;
}


@end
