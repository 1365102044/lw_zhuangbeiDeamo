//
//  HeaderManager.m
//  guoziyunparent
//
//  Created by LIU JIA on 2020/4/8.
//  Copyright © 2020 xuxianwang. All rights reserved.
//

#import "HeaderManager.h"
#import "ActionSheetView.h"
#import "TZImagePickerController.h"
#import "PermissionKit.h"
//#import "OSSApp.h"
//#import "NetworkMediaTool.h"
#import <AFNetworking.h>

@interface HeaderManager() <TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic, weak)UIViewController *controller;
@property(strong,nonatomic)TZImagePickerController *imagePickController;
@property(nonatomic, copy)HeaderManagerChange changeHandle;
@property(nonatomic, copy)HeaderManagerAction startUploadHandle;
@property(nonatomic, copy)HeaderManagerAction failHandle;
@end

@implementation HeaderManager

+ (instancetype)inst {
    static id inst;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = [HeaderManager new];
    });
    return inst;
}

- (void)showMenuWithController:(UIViewController *)controller startUpload:(nonnull HeaderManagerAction)startHandle change:(nonnull HeaderManagerChange)changeHandle fail:(nonnull HeaderManagerAction)failHandle {
    self.controller = controller;
    _startUploadHandle = startHandle;
    _changeHandle = changeHandle;
    _failHandle = failHandle;
    self.imagePickController = nil;
    __weak typeof(self)weakSelf = self;
    ActionSheetView *alert = [[ActionSheetView alloc]initWithTitleArray:@[@"相册",@"相机拍摄"] andShowCancel: YES];
    alert.ClickIndex = ^(NSInteger index) {
        if (index == 2){
            [weakSelf openCamera];
        }if (index == 1){
            [weakSelf openAlbum];
        }
    };
    [alert show];
}

#pragma mark - private

#pragma mark - picker dele
// 打印图片名字
- (NSString*)printAssetsName:(NSArray *)assets {
    NSString *fileName;
    for (PHAsset *asset in assets) {
        fileName = [asset valueForKey:@"filename"];
    }
    return fileName;
}

//获取照片后的d回调
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    
    UIImage  * image = photos[0];
    
    __weak typeof(self)welf = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString * urlString = [NSString stringWithFormat:@"%@%@",kApiPrefix,kupLoadUserImage];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
    
    //post请求
    [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat   = @"YYYY-MM-dd-hh:mm:ss:SSS";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        /*
         此方法参数
         1. 要上传的[二进制数据]
         2. 我这里的imgFile是对应后台给你url里面的图片参数，别瞎带。
         3. 要保存在服务器上的[文件名]
         4. 上传文件的[mimeType]
         */
        [formData appendPartWithFileData:imageData name:@"mfile" fileName:fileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        float progress =  1.0 * uploadProgress.completedUnitCount/uploadProgress.totalUnitCount;
        NSLog(@"上传图片进度%f",progress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *errmsg = [responseObject objectForKey:@"msg"];
        NSString *mediaID = [responseObject objectForKey:@"code"];
        
        if (mediaID && [errmsg isEqualToString:@"success"]) {
            NSLog(@"上传成功");
        }
        NSString * imageID = responseObject[@"data"][@"id"];
        welf.changeHandle(image, imageID);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[zHud shareInstance]showMessage:@"上传失败"];
        NSLog(@"请求失败：%@",error);
    }];
}

///拍照、选视频图片、录像 后的回调（这种方式选择视频时，会自动压缩，但是很耗时间）
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    __weak typeof(self)welf = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString * urlString = [NSString stringWithFormat:@"%@%@",kApiPrefix,kupLoadUserImage];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
    
    //post请求
    [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat   = @"YYYY-MM-dd-hh:mm:ss:SSS";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        /*
         此方法参数
         1. 要上传的[二进制数据]
         2. 我这里的imgFile是对应后台给你url里面的图片参数，别瞎带。
         3. 要保存在服务器上的[文件名]
         4. 上传文件的[mimeType]
         */
        [formData appendPartWithFileData:imageData name:@"mfile" fileName:fileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        float progress =  1.0 * uploadProgress.completedUnitCount/uploadProgress.totalUnitCount;
        NSLog(@"上传图片进度%f",progress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *errmsg = [responseObject objectForKey:@"msg"];
        NSString *mediaID = [responseObject objectForKey:@"code"];
        
        if (mediaID && [errmsg isEqualToString:@"success"]) {
            NSLog(@"上传成功");
        }
        NSString * imageID = responseObject[@"data"][@"id"];
        welf.changeHandle(image, imageID);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[zHud shareInstance]showMessage:@"上传失败"];
        NSLog(@"请求失败：%@",error);
    }];
}

#pragma mark - act
-(void)openCamera{
    [PermissionKit checkCameraPermission:^(BOOL enable) {
        if (enable) {
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            
            if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                    picker.delegate = self;
                    //设置拍照后的图片可被编辑
                    picker.allowsEditing = YES;
                    picker.sourceType = sourceType;
                    
                    [picker setModalPresentationStyle:(UIModalPresentationFullScreen)];
                    [self.controller presentViewController:picker animated:YES completion:nil];
                });
                
            }else{
                NSLog(@"不支持拍照");
            }
        }
    }];
}

-(void)openAlbum
{
    [self.imagePickController setModalPresentationStyle:(UIModalPresentationFullScreen)];
    [self.controller presentViewController:self.imagePickController animated:YES completion:nil];
}

-(void)cancelCrop:(id)sender{
    
    [self.imagePickController dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - getters and setters
-(TZImagePickerController*)imagePickController
{
    if (!_imagePickController) {
        TZImagePickerController *imagePickController = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        _imagePickController = imagePickController;
        imagePickController.preferredLanguage = @"zh-Hans";
        [imagePickController setPhotoPreviewPageUIConfigBlock:^(UICollectionView *collectionView, UIView *naviBar, UIButton *backButton, UIButton *selectButton, UILabel *indexLabel, UIView *toolBar, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel) {
            
            [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
            [doneButton setTitleColor:[UIColor colorWithHexString:@"FE5E5E"] forState:UIControlStateNormal];
            [doneButton setTitle:@"确定" forState:UIControlStateNormal];
            originalPhotoLabel.alpha = 0;
            numberLabel.alpha = 0;
            numberImageView.alpha= 0;
            naviBar.backgroundColor = [UIColor whiteColor];
            UILabel * titleLabel = [[UILabel alloc]init];
            titleLabel.text = @"裁剪头像";
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.font = [UIFont systemFontOfSize:18];
            
            [naviBar addSubview:titleLabel];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(-20);
                make.width.mas_equalTo(100);
                make.height.mas_equalTo(20);
                make.centerX.mas_equalTo(naviBar.mas_centerX).offset(0);
            }];
            toolBar.backgroundColor = [UIColor blackColor];
            
            UIButton * cancleBtn = [[UIButton alloc]init];
            [cancleBtn addTarget:self action:@selector(cancelCrop:) forControlEvents:UIControlEventTouchUpInside];
            [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
            [cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            cancleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
            [toolBar addSubview:cancleBtn];
            [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15);
                make.top.mas_equalTo(10);
                make.width.mas_equalTo(50);
                make.height.mas_equalTo(20);
            }];
            indexLabel.backgroundColor = [UIColor redColor];
            numberLabel.backgroundColor = [UIColor greenColor];
            
        }];
        
        NSInteger top = (SCREEN_HEIGHT - SCREEN_WIDTH)/2;
        imagePickController.cropRect = CGRectMake(0, top, SCREEN_WIDTH, SCREEN_WIDTH);
        imagePickController.allowCrop = YES;
        imagePickController.allowPickingImage = YES;
        imagePickController.scaleAspectFillCrop = YES;
        //是否 在相册中显示拍照按钮
        imagePickController.allowTakePicture = NO;
        //是否可以选择显示原图
        imagePickController.allowPickingOriginalPhoto = NO;
        //是否 在相册中可以选择视频
        imagePickController.allowPickingVideo = NO;
        
    }
    return _imagePickController;
}


-(void)upLoadImage:(UIImage*)image
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    
    //        NSString *urlString = @"http://test.110zhuangbei.com:8105/app/app/appfujian/upload";
    NSString * urlString = [NSString stringWithFormat:@"%@%@",kApiPrefix,kupLoadUserImage];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
    
    //post请求
    [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat   = @"YYYY-MM-dd-hh:mm:ss:SSS";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        /*
         此方法参数
         1. 要上传的[二进制数据]
         2. 我这里的imgFile是对应后台给你url里面的图片参数，别瞎带。
         3. 要保存在服务器上的[文件名]
         4. 上传文件的[mimeType]
         */
        [formData appendPartWithFileData:imageData name:@"mfile" fileName:fileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        float progress =  1.0 * uploadProgress.completedUnitCount/uploadProgress.totalUnitCount;
        NSLog(@"上传图片进度%f",progress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *errmsg = [responseObject objectForKey:@"msg"];
        NSString *mediaID = [responseObject objectForKey:@"code"];
        
        if (mediaID && [errmsg isEqualToString:@"success"]) {
            NSLog(@"上传成功");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败：%@",error);
    }];
}

@end
