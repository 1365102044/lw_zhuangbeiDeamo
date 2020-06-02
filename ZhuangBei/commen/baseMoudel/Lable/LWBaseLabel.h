//
//  LWBaseLabel.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/9.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWBaseLabel : UILabel
/**
 创建基础Label
 
 @HYBaseLabel               字体
 @param text                文字内容（视具体情况而定，YBDefaultLabel子类需要传入文字的Key）
 @param textColor           文字颜色
 @return                    label
 */
+ (instancetype)labelWithFont:(UIFont *)font
                         text:(NSString *)text
                    textColor:(UIColor *)textColor;

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

- (void)setAttributedStringWithContentArray:(NSArray *)array;

@end
