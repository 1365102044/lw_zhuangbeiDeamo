//
//  ShowMsgElem.h
//  IMDemo
//
//  Created by  Admin on 2018/1/9.
//  Copyright © 2018年  Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**  判断文字中是否包含表情 */
#define MessageIsImage(text) [text hasPrefix:@"img["] && [text containsString:@"img["] &&  [text containsString:@"]"] && [[text substringFromIndex:text.length - 1] isEqualToString:@"]"]

typedef NS_ENUM(NSUInteger, LWMsgType) {
    LWMsgTypeText,
    LWMsgTypeImage,
};

@interface ShowMsgElem : NSObject
@property (nonatomic, strong) NSString * username;
//@property (nonatomic, assign) NSInteger  uid;
@property (nonatomic, strong) NSString * time;
@property (nonatomic, strong) NSString * groupId;
@property (nonatomic, strong) NSString * groupName;
@property (nonatomic, strong) NSString * uavatar;

@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *content;
//@property (nonatomic, assign) BOOL isMySelf; //是否是自己消息
// 1 self; 0 other
@property (nonatomic, assign) NSInteger mine;

@property (nonatomic, strong) NSString * toAvatar;

@property (nonatomic, assign) CGFloat rowHeight;

@property (nonatomic, assign) LWMsgType  msgType;
//如果是图片类型的 则获取图片地址
@property (nonatomic, strong) NSString * imagePath;

@property (nonatomic, strong) NSString * mainProduct;

@end
