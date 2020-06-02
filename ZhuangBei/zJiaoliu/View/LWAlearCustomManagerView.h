//
//  LWBaseAlearView.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/17.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^clikBtntfBlock)(NSString * text,BOOL isslect);
@interface LWAlearCustomManagerView : UIView

@property (nonatomic, strong) UIView * mainView;

+ (instancetype)showAlearView:(UIView *)mainview;

- (void)dimiss;

+ (instancetype)showAddNewUserGroupView:(clikBtntfBlock)block;

@end

typedef void(^clikBtnBlock)(NSInteger tag);

@interface LWAddNewUserGroupView : UIView

@property (weak, nonatomic) IBOutlet UITextField *tf;

@property (weak, nonatomic) IBOutlet UIButton *isDeflutBtn;
@property (nonatomic, copy) clikBtnBlock block;

@end
NS_ASSUME_NONNULL_END
