//
//  XinJianQianMingViewController.m
//  ZhiLianQianZhang
//
//  Created by 李晓伟 on 2018/1/8.
//  Copyright © 2018年 李晓伟. All rights reserved.
//

#import "XinJianQianMingViewController.h"
#import "BJTSignView.h"
#import "AFHTTPSessionManager.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+AFNetworking.h"
#import "Header.h"
#import "PopSignUtil.h"
#import "BJTSignView.h"
#import "QianMing_YanSeBiCu_View.h"
#import "DataService.h"

@interface XinJianQianMingViewController () {
    NSString *str_User_Id;
    QianMing_YanSeBiCu_View *_QianMing_YanSe_View;
    NSInteger Int_Pd_QianMing_DianJiCiShu;
    UIColor *color_With_Return;
    NSInteger Int_BiCu_Count_Next;
    NSUserDefaults *User_Defaul_Q;
    UIButton *button_BianJi;
    UIButton *button_QingChu;
}

@property(nonatomic,strong) BJTSignView *signView;



@end

@implementation XinJianQianMingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib. Int_BiCu_Count_Next = 4;

    User_Defaul_Q  = [NSUserDefaults standardUserDefaults];

    NSDictionary *dic_User_Defaul = [User_Defaul_Q objectForKey:@"User"];
    str_User_Id = [NSString stringWithFormat:@"%@",[dic_User_Defaul objectForKey:@"id"]];
    NSString *str_int_Bifeng = [NSString stringWithFormat:@"%li",Int_BiCu_Count_Next];
    [User_Defaul_Q setObject:str_int_Bifeng forKey:@"bf"];
    Int_Pd_QianMing_DianJiCiShu = 0;
    [self defaultSettings];
    [self UI_YanSe_Button_DianJi_XiuGai_Click];
}

- (void)defaultSettings {
    Int_BiCu_Count_Next = 2;
    NSString *str_int_Bifeng = [NSString stringWithFormat:@"%li",Int_BiCu_Count_Next];
    [User_Defaul_Q setObject:str_int_Bifeng forKey:@"bf"];
    
    color_With_Return = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1];
}

//支持旋转
-(BOOL)shouldAutorotate {
    return YES;
}

//支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeLeft;
}

-(void)UI_YanSe_Button_DianJi_XiuGai_Click {
    button_BianJi = [UIButton buttonWithType:UIButtonTypeSystem];
    [button_BianJi setBackgroundImage:[UIImage imageNamed:@"tianjiaQianMing.png"] forState:UIControlStateNormal];
    button_QingChu = [UIButton buttonWithType:UIButtonTypeSystem];
    [button_QingChu setTitle:@"清除" forState:UIControlStateNormal];
    [button_QingChu addTarget:self action:@selector(Self_Button_QingChu_QianMing_Click:) forControlEvents:UIControlEventTouchUpInside];
    [button_BianJi addTarget:self action:@selector(Self_Button_BianJI_QianMing_Click:) forControlEvents:UIControlEventTouchUpInside];

    self.signView = [[BJTSignView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.signView.Color_with_Next = color_With_Return;
    [self.Self_View_QianMing_Bg addSubview:self.signView];
    [button_QingChu setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.Self_View_QianMing_Bg addSubview:button_QingChu];
    [button_BianJi setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.Self_View_QianMing_Bg addSubview:button_BianJi];
    
    [self.Self_View_QianMing_Bg addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(40)]-(20)-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views: @{@"view": button_BianJi}]];
    [self.Self_View_QianMing_Bg addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(100)-[view(40)]" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views: @{@"view": button_BianJi}]];
    
    [self.Self_View_QianMing_Bg addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(40)]-(20)-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views: @{@"view": button_QingChu}]];
    [self.Self_View_QianMing_Bg addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[view(40)]-(100)-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views: @{@"view": button_QingChu}]];
}

-(void) UI_QianZi_Click {
    [PopSignUtil getSignWithVC:self withOk:^(UIImage *image) {
        [PopSignUtil closePop];
        self.image_QianMing_Image = image; } withCancel:^{
        NSLog(@"");
        [PopSignUtil closePop];
    }];
}

#pragma mark - 返回
- (IBAction)Self_Button_Pop_Click:(id)sender {
    [self dismissViewControllerAnimated:true completion:^{
        
    }];
}

- (NSString *)getCacheFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES); return paths.firstObject;
}


#pragma mark - 保存
- (IBAction)Self_Button_BaoCun_Click:(id)sender { // 本地保存，不上传服务器
    [button_BianJi setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [button_QingChu setTitle:@"" forState:UIControlStateNormal];
    [button_QingChu removeFromSuperview];
    [button_BianJi removeFromSuperview];
    
    UIGraphicsBeginImageContext(self.Self_View_QianMing_Bg.bounds.size);
    [self.Self_View_QianMing_Bg.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *imaView = [[UIImageView alloc] initWithImage:image];
    UIImageWriteToSavedPhotosAlbum(imaView.image, self, nil, nil);

    NSString *str_dateStringss_time = @"3333333.png";

    NSDictionary *Dic_Data_mgcon = [NSDictionary dictionaryWithObjectsAndKeys:str_User_Id, @"userId", str_dateStringss_time, @"name", nil];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    manager.requestSerializer.timeoutInterval = 50;

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];

    // 在parameters里存放照片以外的对象
    [manager POST:URL_ADD_SIGN parameters:Dic_Data_mgcon constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < 1; i++) {
            NSData *imageData = UIImageJPEGRepresentation(imaView.image, 0.5);
            NSString *fileName = str_dateStringss_time;
            NSString *str_name_i = [NSString stringWithFormat:@"upload%i",i];
            [formData appendPartWithFileData:imageData name:str_name_i fileName:fileName mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"---上传进度--- %@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self dismissViewControllerAnimated:true completion:^{
            
        }];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败: %@", error);
    }];
}

#pragma mark - 编辑
- (void)Self_Button_BianJI_QianMing_Click:(id)sender {

    [self.signView removeFromSuperview];
    
//    [self.Self_View_QianMing_Bg removeFromSuperview];
    [button_BianJi removeFromSuperview];
    [button_QingChu removeFromSuperview];
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"QianMing_YanSeBiCu_View" owner:nil options:nil];
    _QianMing_YanSe_View = [nibContents lastObject];
    _QianMing_YanSe_View.frame = CGRectMake(0, 0, self.Self_View_BianJi_BG.bounds.size.width, 181);
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
    [self.Self_View_BianJi_BG addSubview:_QianMing_YanSe_View];
}


#pragma mark - ********************
#pragma mark - 颜色
-(void) View_Button_YanSe_1_Click {
    NSLog(@"颜色1");
    [_QianMing_YanSe_View removeFromSuperview];
    [self.signView removeFromSuperview];
    Int_Pd_QianMing_DianJiCiShu = 0;
    color_With_Return = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1];
    [self UI_YanSe_Button_DianJi_XiuGai_Click];
    
}

-(void) View_Button_YanSe_2_Click {
    NSLog(@"颜色2");
    Int_Pd_QianMing_DianJiCiShu = 0;
    [_QianMing_YanSe_View removeFromSuperview];
    [self.signView removeFromSuperview];
    color_With_Return = [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1];
    [self UI_YanSe_Button_DianJi_XiuGai_Click];
}

-(void) View_Button_YanSe_3_Click {
    NSLog(@"颜色3");
    Int_Pd_QianMing_DianJiCiShu = 0;
    [_QianMing_YanSe_View removeFromSuperview];
    [self.signView removeFromSuperview];
    color_With_Return = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1];
    [self UI_YanSe_Button_DianJi_XiuGai_Click];
}

-(void)View_Button_YanSe_4_Click {
    NSLog(@"颜色4");
    Int_Pd_QianMing_DianJiCiShu = 0;
    [_QianMing_YanSe_View removeFromSuperview];
    [self.signView removeFromSuperview];

    color_With_Return = [UIColor colorWithRed:102/255.0f green:45/255.0f blue:145/255.0f alpha:1];
    [self UI_YanSe_Button_DianJi_XiuGai_Click];
}

-(void) View_Button_YanSe_5_Click { NSLog(@"颜色5");
    Int_Pd_QianMing_DianJiCiShu = 0;
    [_QianMing_YanSe_View removeFromSuperview];
    [self.signView removeFromSuperview];
    color_With_Return = [UIColor colorWithRed:41/255.0f green:171/255.0f blue:226/255.0f alpha:1];
    [self UI_YanSe_Button_DianJi_XiuGai_Click];
    
}

-(void) View_Button_YanSe_6_Click {
    NSLog(@"颜色6");
    Int_Pd_QianMing_DianJiCiShu = 0;
    [_QianMing_YanSe_View removeFromSuperview];
    [self.signView removeFromSuperview];

    color_With_Return = [UIColor colorWithRed:57/255.0f green:181/255.0f blue:74/255.0f alpha:1]; [self UI_YanSe_Button_DianJi_XiuGai_Click];
    
}

-(void) View_Button_YanSe_7_Click {
    NSLog(@"颜色7");
    Int_Pd_QianMing_DianJiCiShu = 0;
    [_QianMing_YanSe_View removeFromSuperview];
    [self.signView removeFromSuperview];
    color_With_Return = [UIColor colorWithRed:247/255.0f green:147/255.0f blue:30/255.0f alpha:1];
    [self UI_YanSe_Button_DianJi_XiuGai_Click];
    
}

-(void) View_Button_YanSe_8_Click {
    NSLog(@"颜色8");
    Int_Pd_QianMing_DianJiCiShu = 0;
    [_QianMing_YanSe_View removeFromSuperview];
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
    [_QianMing_YanSe_View removeFromSuperview];
    Int_Pd_QianMing_DianJiCiShu = 0;
    Int_BiCu_Count_Next = 2;
    NSString *str_int_Bifeng = [NSString stringWithFormat:@"%li",Int_BiCu_Count_Next];
    [User_Defaul_Q setObject:str_int_Bifeng forKey:@"bf"];
    [self UI_YanSe_Button_DianJi_XiuGai_Click];
    
}

-(void) View_Button_BiCu_2_Click {
    NSLog(@"细");
    [self.signView removeFromSuperview];
    [_QianMing_YanSe_View removeFromSuperview];
    Int_Pd_QianMing_DianJiCiShu = 0;
    Int_BiCu_Count_Next = 5;
    NSString *str_int_Bifeng = [NSString stringWithFormat:@"%li",Int_BiCu_Count_Next];
    [User_Defaul_Q setObject:str_int_Bifeng forKey:@"bf"];
    [self UI_YanSe_Button_DianJi_XiuGai_Click];
}

-(void) View_Button_BiCu_3_Click {
    NSLog(@"中");
    [self.signView removeFromSuperview];
    [_QianMing_YanSe_View removeFromSuperview];

    Int_Pd_QianMing_DianJiCiShu = 0;
    Int_BiCu_Count_Next = 8;
    NSString *str_int_Bifeng = [NSString stringWithFormat:@"%li",Int_BiCu_Count_Next];
    [User_Defaul_Q setObject:str_int_Bifeng forKey:@"bf"];
    [self UI_YanSe_Button_DianJi_XiuGai_Click];
}

-(void) View_Button_BiCu_4_Click {
    [self.signView removeFromSuperview];
    [_QianMing_YanSe_View removeFromSuperview];
    Int_Pd_QianMing_DianJiCiShu = 0;
    Int_BiCu_Count_Next = 10;
    NSString *str_int_Bifeng = [NSString stringWithFormat:@"%li",Int_BiCu_Count_Next];
    [User_Defaul_Q setObject:str_int_Bifeng forKey:@"bf"];
    [self UI_YanSe_Button_DianJi_XiuGai_Click];
}

#pragma mark - 清除
- (void)Self_Button_QingChu_QianMing_Click:(id)sender { NSLog(@"清除");
    [self.signView removeFromSuperview];
    [_QianMing_YanSe_View removeFromSuperview];
    [button_BianJi removeFromSuperview];
    [button_QingChu removeFromSuperview];
    [self UI_YanSe_Button_DianJi_XiuGai_Click];

}

@end
