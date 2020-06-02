//
//  IFChatCell.h
//  IMDemo
//
//  Created by zhangtongle-Pro on 2018/4/10.
//  Copyright © 2018年  Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, IFChatCellStyle) {
    IFChatCellStyleLeft,
    IFChatCellStyleRight,
    IFChatCellStyleLeftAndNoBG,
    IFChatCellStyleRightAndNoBG
};

extern const int leadingSpace; //文本两端空白
typedef void(^clickImageMsgBlock)(void);

@interface IFChatCell : UITableViewCell
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UILabel *subTitleLabel;
@property (nonatomic, strong, readonly) UILabel *contentLabel;
@property (nonatomic, strong, readonly) UIImageView *iconIV;
@property (nonatomic, assign) BOOL isNotNeedBackground;
@property (nonatomic, strong) UIImageView * textBGIV;
@property (nonatomic, assign) IFChatCellStyle  layoutType;

@property (nonatomic, strong) UIImageView * contextImageView;
@property (nonatomic, copy) clickImageMsgBlock clickImgeBlock;

- (instancetype)initWithStyle:(IFChatCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

+ (CGFloat)caculateTextHeightWithMaxWidth:(CGFloat)maxWidth text:(NSString *)text;

+ (CGFloat)reserveWithForCell;

@end

@interface IFChatImageCell : IFChatCell


@end
