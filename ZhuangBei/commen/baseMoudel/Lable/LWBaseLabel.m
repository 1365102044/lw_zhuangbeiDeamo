//
//  LWBaseLabel.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/9.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWBaseLabel.h"
#import "LWBaseLabelAttributeStringModel.h"

@implementation LWBaseLabel

/**
 创建基础Label
 
 @param font                字体
 @param text                文字内容
 @param textColor           文字颜色
 @return                    label
 */
+ (instancetype)labelWithFont:(UIFont *)font
                         text:(NSString *)text
                    textColor:(UIColor *)textColor
{
    LWBaseLabel *label              = [[self alloc] init];
    label.font                      = font;
    label.text                      = text;
    label.textColor                 = textColor;
    return label;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        /**
         *  项目统一设置
         */
        self.backgroundColor        = UIColor.whiteColor;
        
    }
    return self;
}

/**
 [
 {
 "color" : color,
 "content" : "文字内容",
 "size" : 文字大小,
 "lineSpacing": 行间距
 },
 {
 "color" : color,
 "content" : "文字内容",
 "size" : 文字大小,
 "lineSpacing": 行间距
 },
 .......
 ]
 */

- (void)setAttributedStringWithContentArray:(NSArray *)array
{
    NSMutableParagraphStyle *paragraphStyle                 = [[NSMutableParagraphStyle alloc] init];
    NSMutableAttributedString *attrM                        = [[NSMutableAttributedString alloc] init];
    [array enumerateObjectsUsingBlock:^(LWBaseLabelAttributeStringModel *  _Nonnull obj,
                                        NSUInteger idx,
                                        BOOL * _Nonnull stop) {
        if (!obj.content) return;
        
        NSMutableAttributedString *tempAttrM                = [[NSMutableAttributedString alloc] initWithString:obj.content];
        [paragraphStyle setLineSpacing:obj.lineSpacing.floatValue];
        if (!obj.alignment) {
            paragraphStyle.alignment = obj.alignment.integerValue;
        }else{
            
        }
        [tempAttrM addAttribute:NSForegroundColorAttributeName
                          value:obj.color
                          range:NSMakeRange(0,
                                            obj.content.length)];
        [tempAttrM addAttribute:NSFontAttributeName
                          value:obj.size
                          range:NSMakeRange(0,
                                            obj.content.length)];
        [tempAttrM addAttribute:NSParagraphStyleAttributeName
                          value:paragraphStyle
                          range:NSMakeRange(0,
                                            obj.content.length)];
        [attrM appendAttributedString:tempAttrM.copy];
    }];
    
    self.attributedText                                     = attrM;
}

@end
