//
//  XuanZeTuPian_TuPianQianMing_ChuliViewController.m
//  ZhiLianQianZhang
//
//  Created by 李晓伟 on 2018/1/6.
//  Copyright © 2018年 李晓伟. All rights reserved.
//

#import "XuanZeTuPian_TuPianQianMing_ChuliViewController.h"
#import "ELCImagePickerController.h"
#import "AFHTTPSessionManager.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+AFNetworking.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "MBProgressHUD.h"
#import "BJTSignView.h"
#import "Header.h"
#import "XuanZeQianMingViewController.h"
#import "DataService.h"
#import "QianMing_YanSeBiCu_View.h"
@interface XuanZeTuPian_TuPianQianMing_ChuliViewController () <RegisterViewControl>{
    
    UIView *backView;
    
    UIImageView *image_view_s;
    
    NSString *str_User_Id;
    
    QianMing_YanSeBiCu_View *_QianMing_YanSe_View;
    
    UIView *_QianMing_SheZhi_View_BG;
    
    NSInteger Int_Pd_QianMing_DianJiCiShu;
    
    UIColor *color_With_Return;
    
    NSInteger Int_BiCu_Count_Next;
    
    NSUserDefaults *User_Defaul_Q;
    
    NSString *str_Button_PD_FanHui;
}

@property(nonatomic,strong) BJTSignView *signView;

@end

@implementation XuanZeTuPian_TuPianQianMing_ChuliViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Int_Pd_QianMing_DianJiCiShu = 0;
    
    Int_BiCu_Count_Next = 4;
    
    str_Button_PD_FanHui = @"0";
    
    User_Defaul_Q = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dic_User_Defaul = [User_Defaul_Q objectForKey:@"User"];
    
    str_User_Id = [NSString stringWithFormat:@"%@",[dic_User_Defaul objectForKey:@"id"]];
    
    NSString *str_int_Bifeng = [NSString stringWithFormat:@"%li",Int_BiCu_Count_Next];
    
    [User_Defaul_Q setObject:str_int_Bifeng forKey:@"bf"];
    
    [self UI_Image_ChuLi_Click];
}

-(void) UI_Image_ChuLi_Click {
    
    backView = [[UIView alloc]init];
    image_view_s  = [[UIImageView alloc]init];
    image_view_s.userInteractionEnabled = YES;
    image_view_s.image = self.image_Bg_image;
    [image_view_s setTranslatesAutoresizingMaskIntoConstraints:NO];
    [backView addSubview:image_view_s];
    [backView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[image_view_s]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"image_view_s" : image_view_s}]];
    [backView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[image_view_s]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"image_view_s" : image_view_s}]];
    [backView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.imageEditView addSubview:backView];
    [self.imageEditView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[backView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"backView" : backView}]];
    [self.imageEditView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[backView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"backView" : backView}]];
}

-(void) URL_TuPianSHangChuan_And_JiePing_Click {
    
    UIGraphicsBeginImageContext(backView.bounds.size);
    
    [backView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image= UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageView *imaView = [[UIImageView alloc] initWithImage:image];
    
    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    
    NSString *str_dateStringss_time = @"xxxxx.png";
    
    NSDictionary *Dic_Data_mgcon = [NSDictionary dictionaryWithObjectsAndKeys:str_User_Id,@"id",str_dateStringss_time,@"filename", nil];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer.timeoutInterval = 50;
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    
    // 在parameters里存放照片以外的对象
    [manager POST:URL_ShangChuanTuPian parameters:Dic_Data_mgcon constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
        // 这里的_photoArr是你存放图片的数组
        
        for (int i = 0; i < 1; i++) {
            
            NSData *imageData = UIImageJPEGRepresentation(imaView.image, 0.5);
            
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            
            NSString *fileName = str_dateStringss_time;
            /*
             *该方法的参数
             1. appendPartWithFileData：要上传的照片[二进制流]
             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
             3. fileName：要保存在服务器上的文件名
             4. mimeType：上传的文件的类型
             */
            
            NSString *str_name_i = [NSString stringWithFormat:@"upload%i",i];
            
            [formData appendPartWithFileData:imageData name:str_name_i fileName:fileName mimeType:@"image/jpeg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"---上传进度--- %@",uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"```上传成功``` %@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"上传失败: %@", error);
    }];
}
#pragma mark - 代理传值
-(void)sendValues:(UIImage *)Image_ChuanZhi {
    
    [self.signView removeFromSuperview];
    [self.imageEditView addWatermarkImage:[self imageToTransparent:Image_ChuanZhi]];
}
#pragma mark - 发送
- (IBAction)Self_Button_FaSong_Click:(id)sender {
    
    [self URL_TuPianSHangChuan_And_JiePing_Click];
}

#pragma mark - 选择签名
- (IBAction)Self_Button_XuanZe_QianMing_Click:(id)sender {
    
    NSLog(@"选择签名");
    
    XuanZeQianMingViewController *_XuanZe_Controller = [[XuanZeQianMingViewController alloc]init];
    
    _XuanZe_Controller.delegate = self;
    
    [self.navigationController pushViewController:_XuanZe_Controller animated:YES];
}

#pragma mark - 擦除签名
- (IBAction)Self_Button_QingChu_QianMing_Click:(id)sender {
    
    [self.signView clearSignature];
    
}

#pragma mark - 签名字号 - 颜色
- (IBAction)Self_Button_QianMing_ZiHao_Click:(id)sender {
  
    Int_Pd_QianMing_DianJiCiShu ++;
    
    if (Int_Pd_QianMing_DianJiCiShu %2 == 0) {
        
        [_QianMing_YanSe_View removeFromSuperview];
        
        [_QianMing_SheZhi_View_BG removeFromSuperview];
        
        str_Button_PD_FanHui = @"0";

        self.Self_Image_FanHui_Image.image = [UIImage imageNamed:@"返回箭头.png"];
        
        self.Self_Image_BianJiWanCheng_Image.image = [UIImage imageNamed:@""];
        
    }else {
        
        self.Self_Image_FanHui_Image.image = [UIImage imageNamed:@""];
        
        self.Self_Image_BianJiWanCheng_Image.image = [UIImage imageNamed:@"goubai.png"];
        
        NSLog(@"33");
        
        str_Button_PD_FanHui= @"1";
        
        _QianMing_SheZhi_View_BG = [[UIView alloc]init];
        
        _QianMing_SheZhi_View_BG.frame = CGRectMake(0, 110,[UIScreen mainScreen].bounds.size.width,181);
        
        _QianMing_SheZhi_View_BG.backgroundColor = [UIColor whiteColor];
        
        NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"QianMing_YanSeBiCu_View" owner:nil options:nil];
        
        _QianMing_YanSe_View = [nibContents lastObject];
        
        _QianMing_YanSe_View.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 181);
        
        [_QianMing_YanSe_View.View_Button_YanSe_1 addTarget:self action:@selector(View_Button_YanSe_1_Click) forControlEvents:UIControlEventTouchUpInside];
        
        [_QianMing_YanSe_View.View_Button_YanSe_2 addTarget:self action:@selector(View_Button_YanSe_2_Click) forControlEvents:UIControlEventTouchUpInside];
        
        [_QianMing_YanSe_View.View_Button_YanSe_3 addTarget:self action:@selector(View_Button_YanSe_3_Click) forControlEvents:UIControlEventTouchUpInside];
        
        [_QianMing_YanSe_View.View_Button_YanSe_4 addTarget:self action:@selector(View_Button_YanSe_4_Click) forControlEvents:UIControlEventTouchUpInside];
        
        [_QianMing_YanSe_View.View_Button_YanSe_5 addTarget:self action:@selector(View_Button_YanSe_5_Click) forControlEvents:UIControlEventTouchUpInside];
        
        [_QianMing_YanSe_View.View_Button_YanSe_6 addTarget:self action:@selector(View_Button_YanSe_6_Click) forControlEvents:UIControlEventTouchUpInside];
        
        [_QianMing_YanSe_View.View_Button_YanSe_7 addTarget:self action:@selector(View_Button_YanSe_7_Click) forControlEvents:UIControlEventTouchUpInside];
        
        [_QianMing_YanSe_View.View_Button_YanSe_8 addTarget:self action:@selector(View_Button_YanSe_8_Click) forControlEvents:UIControlEventTouchUpInside];
        
        _QianMing_YanSe_View.View_YanSe_1.layer.masksToBounds = YES;
        
        _QianMing_YanSe_View.View_YanSe_1.layer.cornerRadius = 15.0;
        
        _QianMing_YanSe_View.View_YanSe_2.layer.masksToBounds = YES;
        
        _QianMing_YanSe_View.View_YanSe_2.layer.cornerRadius = 15.0;
        
        _QianMing_YanSe_View.View_YanSe_3.layer.masksToBounds = YES;
        
        _QianMing_YanSe_View.View_YanSe_3.layer.cornerRadius = 15.0;
        
        _QianMing_YanSe_View.View_YanSe_4.layer.masksToBounds = YES;
        
        _QianMing_YanSe_View.View_YanSe_4.layer.cornerRadius = 15.0;
        
        _QianMing_YanSe_View.View_YanSe_5.layer.masksToBounds = YES;
        
        _QianMing_YanSe_View.View_YanSe_5.layer.cornerRadius = 15.0;
        
        _QianMing_YanSe_View.View_YanSe_6.layer.masksToBounds = YES;
        
        _QianMing_YanSe_View.View_YanSe_6.layer.cornerRadius = 15.0;
        
        _QianMing_YanSe_View.View_YanSe_7.layer.masksToBounds = YES;
        
        _QianMing_YanSe_View.View_YanSe_7.layer.cornerRadius = 15.0;
        
        _QianMing_YanSe_View.View_YanSe_8.layer.masksToBounds = YES;
        
        _QianMing_YanSe_View.View_YanSe_8.layer.cornerRadius = 15.0;
        
        _QianMing_YanSe_View.View_Label_BICu_1.layer.masksToBounds = YES;
        
        _QianMing_YanSe_View.View_Label_BICu_1.layer.cornerRadius = 10.0;
        
        _QianMing_YanSe_View.View_Label_BICu_2.layer.masksToBounds = YES;
        
        _QianMing_YanSe_View.View_Label_BICu_2.layer.cornerRadius = 10.0;
        
        _QianMing_YanSe_View.View_Label_BICu_3.layer.masksToBounds = YES;
        
        _QianMing_YanSe_View.View_Label_BICu_3.layer.cornerRadius = 10.0;
        
        _QianMing_YanSe_View.View_Label_BICu_4.layer.masksToBounds = YES;
        
        _QianMing_YanSe_View.View_Label_BICu_4.layer.cornerRadius = 10.0;
        
        [_QianMing_YanSe_View.View_Button_BiCu_1 addTarget:self action:@selector(View_Button_BiCu_1_Click) forControlEvents:UIControlEventTouchUpInside];
        
        [_QianMing_YanSe_View.View_Button_BiCu_2 addTarget:self action:@selector(View_Button_BiCu_2_Click) forControlEvents:UIControlEventTouchUpInside];
        
        [_QianMing_YanSe_View.View_Button_BiCu_3 addTarget:self action:@selector(View_Button_BiCu_3_Click) forControlEvents:UIControlEventTouchUpInside];
        
        [_QianMing_YanSe_View.View_Button_BiCu_4 addTarget:self action:@selector(View_Button_BiCu_4_Click) forControlEvents:UIControlEventTouchUpInside];
        
        [_QianMing_SheZhi_View_BG addSubview:_QianMing_YanSe_View];
        
        [self.view addSubview:_QianMing_SheZhi_View_BG];
    }
}

#pragma mark - 返回
- (IBAction)Self_Button_FanHui_Click:(id)sender {
    
//    goubai.png
//    返回箭头.png
    
    if ([str_Button_PD_FanHui isEqualToString:@"0"]) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else {
        
        str_Button_PD_FanHui = @"0";
        
        self.Self_Image_FanHui_Image.image = [UIImage imageNamed:@"返回箭头.png"];
        
        self.Self_Image_BianJiWanCheng_Image.image = [UIImage imageNamed:@""];
        
        [_QianMing_YanSe_View removeFromSuperview];
        
        [_QianMing_SheZhi_View_BG removeFromSuperview];
    }
}

#pragma mark - ********************
#pragma mark - 颜色
-(void) View_Button_YanSe_1_Click {
    
    NSLog(@"颜色1");
    
    [self.signView removeFromSuperview];
    
    Int_Pd_QianMing_DianJiCiShu = 0;

    color_With_Return = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1];

    [self UI_YanSe_Button_DianJi_XiuGai_Click];
}

-(void) UI_YanSe_Button_DianJi_XiuGai_Click {
    
    [_QianMing_YanSe_View removeFromSuperview];
    
    [_QianMing_SheZhi_View_BG removeFromSuperview];
    
    self.signView = [[BJTSignView alloc] initWithFrame:CGRectMake(0, 0, backView.bounds.size.width, backView.bounds.size.height )];
    
    self.signView.Color_with_Next = color_With_Return;
    
    [image_view_s addSubview:self.signView];
    
}

-(void) View_Button_YanSe_2_Click {
    
    NSLog(@"颜色2");
    
    Int_Pd_QianMing_DianJiCiShu = 0;
    
    [self.signView removeFromSuperview];
    
    color_With_Return = [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1];
}

-(void) View_Button_YanSe_3_Click {
    
    NSLog(@"颜色3");
    
    Int_Pd_QianMing_DianJiCiShu = 0;
    
    [self.signView removeFromSuperview];
    
    color_With_Return = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1];
    
    [self UI_YanSe_Button_DianJi_XiuGai_Click];

}
-(void)View_Button_YanSe_4_Click {
    
    NSLog(@"颜色4");
    
    Int_Pd_QianMing_DianJiCiShu = 0;

    [self.signView removeFromSuperview];
    
    color_With_Return = [UIColor colorWithRed:102/255.0f green:45/255.0f blue:145/255.0f alpha:1];
    
    [self UI_YanSe_Button_DianJi_XiuGai_Click];
}

-(void) View_Button_YanSe_5_Click {
    
    NSLog(@"颜色5");
    
    Int_Pd_QianMing_DianJiCiShu = 0;
    
    [self.signView removeFromSuperview];
    
    color_With_Return = [UIColor colorWithRed:41/255.0f green:171/255.0f blue:226/255.0f alpha:1];

    [self UI_YanSe_Button_DianJi_XiuGai_Click];
}

-(void) View_Button_YanSe_6_Click {
    
    NSLog(@"颜色6");
    
    Int_Pd_QianMing_DianJiCiShu = 0;

    [self.signView removeFromSuperview];
    
    color_With_Return = [UIColor colorWithRed:57/255.0f green:181/255.0f blue:74/255.0f alpha:1];
    
    [self UI_YanSe_Button_DianJi_XiuGai_Click];
}

-(void) View_Button_YanSe_7_Click {
    
    NSLog(@"颜色7");
    
    Int_Pd_QianMing_DianJiCiShu = 0;

    [self.signView removeFromSuperview];
    
    color_With_Return = [UIColor colorWithRed:247/255.0f green:147/255.0f blue:30/255.0f alpha:1];
    
    [self UI_YanSe_Button_DianJi_XiuGai_Click];
}

-(void) View_Button_YanSe_8_Click {
    
    NSLog(@"颜色8");
    
    Int_Pd_QianMing_DianJiCiShu = 0;

    [self.signView removeFromSuperview];
    
    color_With_Return = [UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:1];
    
    UILabel *label_lab = [[UILabel alloc]init];
    
    label_lab.font = [UIFont boldSystemFontOfSize:13];
    
    [self UI_YanSe_Button_DianJi_XiuGai_Click];

}
#pragma mark - 颜色
#pragma mark - *************************
#pragma mark - 笔粗
-(void) View_Button_BiCu_1_Click {
    
    NSLog(@"极细");
    
    [self.signView removeFromSuperview];
    
    Int_Pd_QianMing_DianJiCiShu = 0;
    
    Int_BiCu_Count_Next = 2;
    
    NSString *str_int_Bifeng = [NSString stringWithFormat:@"%li",Int_BiCu_Count_Next];
    
    [User_Defaul_Q setObject:str_int_Bifeng forKey:@"bf"];
    
    [self UI_YanSe_Button_DianJi_XiuGai_Click];

}

-(void) View_Button_BiCu_2_Click {
    
    NSLog(@"细");
    
    [self.signView removeFromSuperview];
    
    Int_Pd_QianMing_DianJiCiShu = 0;
    
    Int_BiCu_Count_Next = 5;
    
    NSString *str_int_Bifeng = [NSString stringWithFormat:@"%li",Int_BiCu_Count_Next];

    [User_Defaul_Q setObject:str_int_Bifeng forKey:@"bf"];
    
    [self UI_YanSe_Button_DianJi_XiuGai_Click];
}

-(void) View_Button_BiCu_3_Click {
    
    NSLog(@"中");
    
    [self.signView removeFromSuperview];
    
    Int_Pd_QianMing_DianJiCiShu = 0;
    
    Int_BiCu_Count_Next = 8;
    
    NSString *str_int_Bifeng = [NSString stringWithFormat:@"%li",Int_BiCu_Count_Next];
    
    [User_Defaul_Q setObject:str_int_Bifeng forKey:@"bf"];
    
    [self UI_YanSe_Button_DianJi_XiuGai_Click];
}

-(void) View_Button_BiCu_4_Click {
    
    NSLog(@"粗");
    
    [self.signView removeFromSuperview];
    
    Int_Pd_QianMing_DianJiCiShu = 0;
    
    Int_BiCu_Count_Next = 10;
    
    NSString *str_int_Bifeng = [NSString stringWithFormat:@"%li",Int_BiCu_Count_Next];
        
    [User_Defaul_Q setObject:str_int_Bifeng forKey:@"bf"];
    
    [self UI_YanSe_Button_DianJi_XiuGai_Click];
}

- (UIImage *) imageToTransparent:(UIImage*) image {
    
    // 分配内存
    const int imageWidth = image.size.width;
    
    const int imageHeight = image.size.height;
    
    size_t bytesPerRow = imageWidth * 4;
    
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    
    // 创建context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    
    uint32_t* pCurPtr = rgbImageBuf;
    
    for (int i = 0; i < pixelNum; i++, pCurPtr++)
    {
        //        //去除白色...将0xFFFFFF00换成其它颜色也可以替换其他颜色。
        //        if ((*pCurPtr & 0xFFFFFF00) >= 0xffffff00) {
        //
        //            uint8_t* ptr = (uint8_t*)pCurPtr;
        //            ptr[0] = 0;
        //        }
        //接近白色
        //将像素点转成子节数组来表示---第一个表示透明度即ARGB这种表示方式。ptr[0]:透明度,ptr[1]:R,ptr[2]:G,ptr[3]:B
        
        //分别取出RGB值后。进行判断需不需要设成透明。
        uint8_t* ptr = (uint8_t*)pCurPtr;
        
        if (ptr[1] > 240 && ptr[2] > 240 && ptr[3] > 240) {
            
            //当RGB值都大于240则比较接近白色的都将透明度设为0.-----即接近白色的都设置为透明。某些白色背景具有杂质就会去不干净，用这个方法可以去干净
            
            ptr[0] = 0;
        }
    }
    
    // 将内存转成image
    CGDataProviderRef dataProvider =CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, nil);
    
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight,8, 32, bytesPerRow, colorSpace,kCGImageAlphaLast |kCGBitmapByteOrder32Little, dataProvider,NULL, true,kCGRenderingIntentDefault);
    
    CGDataProviderRelease(dataProvider);
    
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    
    // 释放
    CGImageRelease(imageRef);
    
    CGContextRelease(context);
    
    CGColorSpaceRelease(colorSpace);
    
    return resultUIImage;
}

@end
