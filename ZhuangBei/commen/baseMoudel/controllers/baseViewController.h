//
//  baseViewController.h
//  ZhuangBei
//
//  Created by aa on 2020/4/22.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zInterfacedConst.h"
#import "zNoContentView.h"
#import "zNothingView.h"
#import "zNetWorkManger.h"
NS_ASSUME_NONNULL_BEGIN
/**
 请求成功的block
 @param response 响应体数据
 */

typedef void(^RequestSuccess)(id response);
/**
 请求失败的block
 */
typedef void(^RequestFailure)(NSError *error);

//网络请求的参数传递方式
typedef NS_ENUM(NSUInteger, LWRequestParamType) {
    LWRequestParamTypeDict,       //字典方式
    LWRequestParamTypeString,     //字符串拼接方式
    LWRequestParamTypeBody,           // body
};

@interface baseViewController : UIViewController

@property (nonatomic, assign) NSInteger  currPage;
@property (nonatomic, assign) NSInteger  totalPage;

@property(strong,nonatomic)zNothingView * nothingView;
@property(strong,nonatomic)zNoContentView * noContentView;


- (void)getDataurl:(NSString *)url withParam:(id)para;

-(void)postDataWithUrl:(NSString*)url WithParam:(id)param;

//-(void)RequsetSuccessWithData:(id)data AndUrl:(NSString*)url;
//
//-(void)RequsetFileWithUrl:(NSString*)url WithError:(NSError*)err;

- (void)requestPostWithUrl:(NSString *)url Parameters:(id)parameters success:(RequestSuccess)success failure:(RequestFailure)failure;

/// POST  网络请求 内部拼接参数
/// @param url 地址
/// @param paraString 参数字典，内部转拼接参数
/// @param success 成功
/// @param failure 失败
- (void)requestPostWithUrl:(NSString *)url paraString:(id)paraString success:(RequestSuccess)success failure:(RequestFailure)failure;

/**
 *  异步POST请求:以body方式,字符串、字典
 *
 *  @param url     请求的url
 *  @param body    body数据 字符串、字典
 *  @param success 成功回调
 *  @param failure 失败回调
 */
- (void)requestPostWithUrl:(NSString *)url
                      body:(id)body
                   success:(RequestSuccess)success
                   failure:(RequestFailure)failure;

//- (void)requestDatas;

/// post网络请求
/// @param url url
/// @param para 参数 字符串。字段，
/// @param paratype 参数上传方式
/// @param success 成功
/// @param failure 失败
- (void)requestPostWithUrl:(NSString *)url para:(id)para paraType:(LWRequestParamType)paratype success:(RequestSuccess)success failure:(RequestFailure)failure;



@end

NS_ASSUME_NONNULL_END
