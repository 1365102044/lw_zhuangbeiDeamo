//
//  LWPhotoPicker.h
//  cs_weihai
//
//  Created by LWQ on 2019/8/15.
//  Copyright © 2019 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^PhotoOrAlbumImagePickerBlock)(UIImage *image);

@interface LWPhotoPicker : NSObject

// 必须创建一个对象才行，才不会释放指针
// 必须先在使用该方法的控制器中初始化 创建这个属性，然后在对象调用如下方法

// 调用下面方法之前设置 才有效 (默认NO)
@property (nonatomic, assign) BOOL  allowsEditing;
@property (nonatomic,weak) UIViewController  *viewController; //-> 一定是weak 避免循环引用
/**
 公共方法 选择图片后的图片回掉
 
 @param controller 使用这个工具的控制器
 @param photoBlock 选择图片后的回掉
 */
- (void)getPhotoAlbumOrTakeAPhotoWithController:(UIViewController *)controller photoBlock:(PhotoOrAlbumImagePickerBlock)photoBlock;

/// 选择照片 通过c相册
/// @param allowsEditing 是否裁剪
- (void)photoPickerWithPhotoLibrary:(BOOL)allowsEditing photoBlock:(PhotoOrAlbumImagePickerBlock)photoBlock;

/// 选择照片 通过c相机
/// @param allowsEditing 是否裁剪
- (void)photoPickerWithCamera:(BOOL)allowsEditing photoBlock:(PhotoOrAlbumImagePickerBlock)photoBlock;

@end

NS_ASSUME_NONNULL_END
