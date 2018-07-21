//
//  WodeZhangHuViewController.m
//  ZhiLianQianZhang
//
//  Created by 李晓伟 on 2018/1/20.
//  Copyright © 2018年 李晓伟. All rights reserved.
//

#import "WodeZhangHuViewController.h"
#import "Zhanghu_KeYiDongView.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+AFNetworking.h"
#import "ZhangHu_ChongZhiViewController.h"
#import "AFHTTPSessionManager.h"
#import "Header.h"
#import "DataService.h"
#import "WoDeErWeiMaViewController.h"
@interface WodeZhangHuViewController () {
    
    UIScrollView *_Scrollview_Bg;
    
    Zhanghu_KeYiDongView *_NeiRong_View;
    
    NSInteger Int_Count_1_5;
    
    NSInteger Int_Count_14;
    
    NSInteger Int_Count_130;
    
    NSInteger Int_Count_1200;
    
    CGFloat Int_Z_1_5;
    
    CGFloat Int_Z_14;
    
    CGFloat Int_Z_130;
    
    CGFloat Int_Z_1200;
    
    CGFloat Int_JiaGe_1_5;
    
    CGFloat Int_JiaGe_14;
    
    CGFloat Int_JiaGe_130;
    
    CGFloat Int_JiaGe_1200;
    
    CGFloat Int_ZongJia;
    
    NSUserDefaults *User_Defaul_Q;
    
    NSDictionary *dic_User_Defaul;
    
    NSString *str_ZhangHao;
}

@end

@implementation WodeZhangHuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    Int_Count_1_5 = 0;
    
    Int_Count_14 = 0;
    
    Int_Count_130 = 0;
    
    Int_Count_1200 = 0;
    
    Int_Z_1_5 = 0;
    
    Int_Z_14 = 0;
    
    Int_Z_130 = 0;
    
    Int_Z_1200 = 0;
    
    User_Defaul_Q = [NSUserDefaults standardUserDefaults];
    
    dic_User_Defaul = [User_Defaul_Q objectForKey:@"User"];
    
    NSLog(@"%@",dic_User_Defaul);
    
    str_ZhangHao = [NSString stringWithFormat:@"%@",[dic_User_Defaul objectForKey:@"unionid"]];
    
    [self UI_Scrollview_Bg_Click];
}

-(void) UI_Scrollview_Bg_Click {
    
    _Scrollview_Bg = [[UIScrollView alloc]init];
    
    _Scrollview_Bg.frame = CGRectMake(0, 91, [UIScreen mainScreen].bounds.size.width, 550);
    
    _Scrollview_Bg.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width,667);
    
    _Scrollview_Bg.backgroundColor = [UIColor clearColor];
        
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"Zhanghu_KeYiDongView" owner:nil options:nil];
    
    _NeiRong_View = [nibContents lastObject];
    
    _NeiRong_View.frame = CGRectMake(0, 0, _Scrollview_Bg.bounds.size.width, _Scrollview_Bg.bounds.size.height);
    
    _NeiRong_View.View_BG_1.layer.masksToBounds = YES;
    
    _NeiRong_View.View_BG_1.layer.cornerRadius = 10;
    
    _NeiRong_View.View_BG_2.layer.masksToBounds = YES;
    
    _NeiRong_View.View_BG_2.layer.cornerRadius = 10;
    
    _NeiRong_View.View_BG_3.layer.masksToBounds = YES;
    
    _NeiRong_View.View_BG_3.layer.cornerRadius = 10;
    
    _NeiRong_View.View_YiQian_ZhangHao.text = str_ZhangHao;
    
    [_NeiRong_View.View_Button_ChongZhi_ShiYong addTarget:self action:@selector(View_Button_ChongZhi_ShiYong_CLick) forControlEvents:UIControlEventTouchUpInside];
    
    [_NeiRong_View.View_Button_ChongZhi_YueFei addTarget:self action:@selector(View_Button_ChongZhi_YueFei_click) forControlEvents:UIControlEventTouchUpInside];
    
    [_NeiRong_View.View_Button_ChongZhi_NianFei addTarget:self action:@selector(View_Button_ChongZhi_NianFei_Click) forControlEvents:UIControlEventTouchUpInside];
    
    [_NeiRong_View.View_Button_1_5_Jian addTarget:self action:@selector(View_Button_1_5_Jian_Click) forControlEvents:UIControlEventTouchUpInside];
    
    [_NeiRong_View.View_Button_1_5_jia addTarget:self action:@selector(View_Button_1_5_jia_Click) forControlEvents:UIControlEventTouchUpInside];
    
    [_NeiRong_View.View_Button_1_5_Yue addTarget:self action:@selector(View_Button_1_5_Yue_click) forControlEvents:UIControlEventTouchUpInside];
    
    [_NeiRong_View.View_Button_1_5_Nian addTarget:self action:@selector(View_Button_1_5_Nian_Click) forControlEvents:UIControlEventTouchUpInside];
    
    [_NeiRong_View.View_Button_14_Jian addTarget:self action:@selector(View_Button_14_Jian_Click) forControlEvents:UIControlEventTouchUpInside];
    
    [_NeiRong_View.View_Button_15_Jia addTarget:self action:@selector(View_Button_14_jia_Click) forControlEvents:UIControlEventTouchUpInside];
    
    [_NeiRong_View.View_Button_14_Yue addTarget:self action:@selector(View_Button_14_Yue_Click) forControlEvents:UIControlEventTouchUpInside];
    
    [_NeiRong_View.View_Button_14_Nian addTarget:self action:@selector(View_Button_14_Nian_Clicks) forControlEvents:UIControlEventTouchUpInside];
    
    [_NeiRong_View.View_Button_10_Jian addTarget:self action:@selector(View_Button_10_Jian_Clickss) forControlEvents:UIControlEventTouchUpInside];
    
    [_NeiRong_View.View_Button_Jia addTarget:self action:@selector(View_Button_10_jia_Clickss) forControlEvents:UIControlEventTouchUpInside];
    
    [_NeiRong_View.View_Button_130_Yue addTarget:self action:@selector(View_Button_130_Yue_Click) forControlEvents:UIControlEventTouchUpInside];
    
    [_NeiRong_View.View_Button_130_Nian addTarget:self action:@selector(View_Button_130_Nian_click) forControlEvents:UIControlEventTouchUpInside];
    
    [_NeiRong_View.View_Button_1200_Jian addTarget:self action:@selector(View_Button_1200_Jian_Click) forControlEvents:UIControlEventTouchUpInside];
    
    [_NeiRong_View.View_Button_1200_Jia addTarget:self action:@selector(View_Button_1200_Jia_Click) forControlEvents:UIControlEventTouchUpInside];
    
    [_NeiRong_View.View_Button_1200_Yue addTarget:self action:@selector(View_Button_1200_Yue_Click) forControlEvents:UIControlEventTouchUpInside];
    
    [_NeiRong_View.View_Button_1200_Nian addTarget:self action:@selector(View_Button_1200_Nian_Click) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *str_image_Url = [NSString stringWithFormat:@"%@",[dic_User_Defaul objectForKey:@"image"]];
    
    NSString *str_Name_ing = [NSString stringWithFormat:@"%@",[dic_User_Defaul objectForKey:@"name"]];
    
    [_NeiRong_View.View_image_TouXiang setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",str_image_Url]]];
    
    _NeiRong_View.View_Label_MingCheng.text = [NSString stringWithFormat:@"%@",str_Name_ing];
    
    _NeiRong_View.View_image_TouXiang.layer.masksToBounds = YES;
    
    _NeiRong_View.View_image_TouXiang.layer.cornerRadius = 70/2;
    
    [_Scrollview_Bg addSubview:_NeiRong_View];
    
    [self.view addSubview:_Scrollview_Bg];
}

- (IBAction)Self_Button_Pop_Click:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) View_Button_ChongZhi_ShiYong_CLick{
    
    NSLog(@"试用版");
    
    _NeiRong_View.View_Image_ShiYong_image.image = [UIImage imageNamed:@"bg充值.png"];
    
    _NeiRong_View.View_Image_YueFei_Image.image = [UIImage imageNamed:@""];
    
    _NeiRong_View.View_image_NianFei_image.image = [UIImage imageNamed:@""];
}

-(void) View_Button_ChongZhi_YueFei_click {
  
    NSLog(@"月费版");
    
    _NeiRong_View.View_Image_ShiYong_image.image = [UIImage imageNamed:@""];
    
    _NeiRong_View.View_Image_YueFei_Image.image = [UIImage imageNamed:@"bg充值.png"];
    
    _NeiRong_View.View_image_NianFei_image.image = [UIImage imageNamed:@""];
}

-(void) View_Button_ChongZhi_NianFei_Click {
    
    NSLog(@"年费版");
    
    _NeiRong_View.View_Image_ShiYong_image.image = [UIImage imageNamed:@""];
    
    _NeiRong_View.View_Image_YueFei_Image.image = [UIImage imageNamed:@""];
    
    _NeiRong_View.View_image_NianFei_image.image = [UIImage imageNamed:@"bg充值.png"];
}

-(void) View_Button_1_5_Jian_Click {
    
    Int_Count_1_5 --;
    
    if (Int_Count_1_5 < 0) {
        
        Int_Count_1_5 = 0;
    }
    
    CGFloat Float_Int_JiaGe_1_5 = Int_Count_1_5;
    
    Int_Z_1_5  = Float_Int_JiaGe_1_5 * Int_JiaGe_1_5;
    
    Int_ZongJia = Int_Z_1_5 + Int_Z_14 + Int_Z_130 + Int_Z_1200;
    
    _NeiRong_View.View_Button_1_5_GeShu.text = [NSString stringWithFormat:@"%li",Int_Count_1_5];

    self.Self_Label_GongJi.text = [NSString stringWithFormat:@"%.2f",Int_ZongJia];
    
    NSLog(@"%f",Int_ZongJia);
    
}

-(void) View_Button_1_5_jia_Click {
    
    Int_Count_1_5 ++;
    
    CGFloat Float_Int_JiaGe_1_5 = Int_Count_1_5;
    
    Int_Z_1_5  = Float_Int_JiaGe_1_5 * Int_JiaGe_1_5;
    
    Int_ZongJia = Int_Z_1_5 + Int_Z_14 + Int_Z_130 + Int_Z_1200;
    
    _NeiRong_View.View_Button_1_5_GeShu.text = [NSString stringWithFormat:@"%li",Int_Count_1_5];
    
    self.Self_Label_GongJi.text = [NSString stringWithFormat:@"%.2f",Int_ZongJia];

    NSLog(@"%f",Int_ZongJia);
}

-(void) View_Button_1_5_Yue_click {
    
    Int_JiaGe_1_5 = 1.5;
    
    CGFloat Float_Int_JiaGe_1_5 = Int_Count_1_5;
    
    Int_Z_1_5  = Int_Count_1_5 * Float_Int_JiaGe_1_5;
    
    NSLog(@"%.2f",Int_Z_1_5);
    
    Int_ZongJia = Int_Z_1_5 + Int_Z_14 + Int_Z_130 + Int_Z_1200;
    
    self.Self_Label_GongJi.text = [NSString stringWithFormat:@"%.2f",Int_ZongJia];
    
    _NeiRong_View.View_image_1_5_Yue.image = [UIImage imageNamed:@"签章2-29(2).png"];
    
    _NeiRong_View.View_image_1_5_Nian.image = [UIImage imageNamed:@"签章2-30(3).png"];
    
    NSLog(@"%f",Int_ZongJia);
}

-(void) View_Button_1_5_Nian_Click {
    
    Int_JiaGe_1_5 = 18;
    
    CGFloat Float_Int_JiaGe_1_5 = Int_Count_1_5;
    
    Int_Z_1_5  = Float_Int_JiaGe_1_5 * Float_Int_JiaGe_1_5;
    
    NSLog(@"%.2f",Int_Z_1_5);
    
    Int_ZongJia = Int_Z_1_5 + Int_Z_14 + Int_Z_130 + Int_Z_1200;
    
    _NeiRong_View.View_image_1_5_Yue.image = [UIImage imageNamed:@"签章2-30(3).png"];
    
    _NeiRong_View.View_image_1_5_Nian.image = [UIImage imageNamed:@"签章2-29(2).png"];
    
    self.Self_Label_GongJi.text = [NSString stringWithFormat:@"%.2f",Int_ZongJia];

    NSLog(@"%f",Int_ZongJia);
}

-(void) View_Button_14_Jian_Click {
    
    Int_Count_14 --;
    
    if (Int_Count_14 < 0) {
        
        Int_Count_14 = 0;
    }
    
    CGFloat Float_Int_Count_14 = Int_Count_14;
    
    Int_Z_14  = Float_Int_Count_14 * Int_JiaGe_14;
    
    Int_ZongJia = Int_Z_1_5 + Int_Z_14 + Int_Z_130 + Int_Z_1200;
    
    _NeiRong_View.View_Label_14_ShuLiang.text = [NSString stringWithFormat:@"%li",Int_Count_14];
    
    self.Self_Label_GongJi.text = [NSString stringWithFormat:@"%.2f",Int_ZongJia];

    
    NSLog(@"%f",Int_ZongJia);
}

-(void) View_Button_14_jia_Click {
    
    Int_Count_14 ++;
    
    CGFloat Float_Int_Count_14 = Int_Count_14;

    Int_Z_14  = Float_Int_Count_14 * Int_JiaGe_14;
    
    Int_ZongJia = Int_Z_1_5 + Int_Z_14 + Int_Z_130 + Int_Z_1200;
    
    _NeiRong_View.View_Label_14_ShuLiang.text = [NSString stringWithFormat:@"%li",Int_Count_14];
    
    self.Self_Label_GongJi.text = [NSString stringWithFormat:@"%.2f",Int_ZongJia];

    NSLog(@"%f",Int_ZongJia);
}

-(void) View_Button_14_Yue_Click {
    
    Int_JiaGe_14 = 14;
    
    CGFloat Float_Int_Count_14 = Int_Count_14;

    Int_Z_14  = Float_Int_Count_14 * Int_JiaGe_14;
    
    Int_ZongJia = Int_Z_1_5 + Int_Z_14 + Int_Z_130 + Int_Z_1200;
    
    _NeiRong_View.View_image_14_yue.image = [UIImage imageNamed:@"签章2-29(2).png"];
    
    _NeiRong_View.View_image_14_Nian.image = [UIImage imageNamed:@"签章2-30(3).png"];
    
    self.Self_Label_GongJi.text = [NSString stringWithFormat:@"%.2f",Int_ZongJia];

    NSLog(@"%f",Int_ZongJia);
}

-(void) View_Button_14_Nian_Clicks {
    
    Int_JiaGe_14 = 168;
    
    CGFloat Float_Int_Count_14 = Int_Count_14;

    Int_Z_14  = Float_Int_Count_14 * Int_JiaGe_14;
    
    Int_ZongJia = Int_Z_1_5 + Int_Z_14 + Int_Z_130 + Int_Z_1200;
    
    _NeiRong_View.View_image_14_yue.image = [UIImage imageNamed:@"签章2-30(3).png"];
    
    _NeiRong_View.View_image_14_Nian.image = [UIImage imageNamed:@"签章2-29(2).png"];
    
    self.Self_Label_GongJi.text = [NSString stringWithFormat:@"%.2f",Int_ZongJia];
    
    NSLog(@"%f",Int_ZongJia);
}

-(void) View_Button_10_Jian_Clickss {
    
    Int_Count_130 --;
    
    if (Int_Count_130 < 0) {
        
        Int_Count_130 = 0;
    }
    CGFloat Float_Int_Count_130 = Int_Count_130;
    
    Int_Z_130  = Float_Int_Count_130 * Int_JiaGe_130;
    
    Int_ZongJia = Int_Z_1_5 + Int_Z_14 + Int_Z_130 + Int_Z_1200;
    
    _NeiRong_View.View_Label_10_ShuLiang.text = [NSString stringWithFormat:@"%li",Int_Count_130];
    
    self.Self_Label_GongJi.text = [NSString stringWithFormat:@"%.2f",Int_ZongJia];

    NSLog(@"%f",Int_ZongJia);
}

-(void) View_Button_10_jia_Clickss {
    
    Int_Count_130 ++;
    
    CGFloat Float_Int_Count_130 = Int_Count_130;
    
    Int_Z_130  = Float_Int_Count_130 * Int_JiaGe_130;
    
    Int_ZongJia = Int_Z_1_5 + Int_Z_14 + Int_Z_130 + Int_Z_1200;
    
    _NeiRong_View.View_Label_10_ShuLiang.text = [NSString stringWithFormat:@"%li",Int_Count_130];
    
    self.Self_Label_GongJi.text = [NSString stringWithFormat:@"%.2f",Int_ZongJia];

    NSLog(@"%f",Int_ZongJia);

}

-(void) View_Button_130_Yue_Click {
    
    Int_JiaGe_130 = 130;
    
    CGFloat Float_Int_Count_130 = Int_Count_130;
    
    Int_Z_130  = Float_Int_Count_130 * Int_JiaGe_130;
    
    Int_ZongJia = Int_Z_1_5 + Int_Z_14 + Int_Z_130 + Int_Z_1200;

    _NeiRong_View.View_image_130_Yue.image = [UIImage imageNamed:@"签章2-29(2).png"];
    
    _NeiRong_View.View_image_130_Nian.image = [UIImage imageNamed:@"签章2-30(3).png"];
    
    self.Self_Label_GongJi.text = [NSString stringWithFormat:@"%.2f",Int_ZongJia];

    NSLog(@"%f",Int_ZongJia);
}

-(void) View_Button_130_Nian_click {
    
    Int_JiaGe_130 = 1560;
    
    CGFloat Float_Int_Count_130 = Int_Count_130;
    
    Int_Z_130  = Float_Int_Count_130 * Int_JiaGe_130;
    
    Int_ZongJia = Int_Z_1_5 + Int_Z_14 + Int_Z_130 + Int_Z_1200;

    _NeiRong_View.View_image_130_Yue.image = [UIImage imageNamed:@"签章2-30(3).png"];
    
    _NeiRong_View.View_image_130_Nian.image = [UIImage imageNamed:@"签章2-29(2).png"];
    
    self.Self_Label_GongJi.text = [NSString stringWithFormat:@"%.2f",Int_ZongJia];

    NSLog(@"%f",Int_ZongJia);

}

-(void) View_Button_1200_Jian_Click {
    
    Int_Count_1200 --;
    
    if (Int_Count_1200 < 0) {
        
        Int_Count_1200 = 0;
    }
    
    CGFloat Float_Int_Count_1200 = Int_Count_1200;
    
    Int_Z_1200  = Float_Int_Count_1200 * Int_JiaGe_1200;
    
    Int_ZongJia = Int_Z_1_5 + Int_Z_14 + Int_Z_130 + Int_Z_1200;
    
    _NeiRong_View.View_Label_1200_ShuLiang.text = [NSString stringWithFormat:@"%li",Int_Count_1200];

    self.Self_Label_GongJi.text = [NSString stringWithFormat:@"%.2f",Int_ZongJia];

    NSLog(@"%f",Int_ZongJia);
}

-(void) View_Button_1200_Jia_Click {
    
    Int_Count_1200 ++;
    
    CGFloat Float_Int_Count_1200 = Int_Count_1200;
    
    Int_Z_1200  = Float_Int_Count_1200 * Int_JiaGe_1200;
    
    Int_ZongJia = Int_Z_1_5 + Int_Z_14 + Int_Z_130 + Int_Z_1200;
    
    _NeiRong_View.View_Label_1200_ShuLiang.text = [NSString stringWithFormat:@"%li",Int_Count_1200];

    self.Self_Label_GongJi.text = [NSString stringWithFormat:@"%.2f",Int_ZongJia];

    NSLog(@"%f",Int_ZongJia);
}

-(void) View_Button_1200_Yue_Click {
    
    Int_JiaGe_1200 = 1200;
    
    CGFloat Float_Int_Count_1200 = Int_Count_1200;
    
    Int_Z_1200  = Float_Int_Count_1200 * Int_JiaGe_1200;
    
    Int_ZongJia = Int_Z_1_5 + Int_Z_14 + Int_Z_130 + Int_Z_1200;
    
    _NeiRong_View.View_image_1200_Yue.image = [UIImage imageNamed:@"签章2-29(2).png"];
    
    _NeiRong_View.View_image_1200_Nian.image = [UIImage imageNamed:@"签章2-30(3).png"];
    
    self.Self_Label_GongJi.text = [NSString stringWithFormat:@"%.2f",Int_ZongJia];

    NSLog(@"%f",Int_ZongJia);
}

-(void) View_Button_1200_Nian_Click {
    
    Int_JiaGe_1200 = 14400;
    
    CGFloat Float_Int_Count_1200 = Int_Count_1200;
    
    Int_Z_1200  = Float_Int_Count_1200 * Int_JiaGe_1200;
    
    Int_ZongJia = Int_Z_1_5 + Int_Z_14 + Int_Z_130 + Int_Z_1200;

    _NeiRong_View.View_image_1200_Yue.image = [UIImage imageNamed:@"签章2-30(3).png"];
    
    _NeiRong_View.View_image_1200_Nian.image = [UIImage imageNamed:@"签章2-29(2).png"];
    
    self.Self_Label_GongJi.text = [NSString stringWithFormat:@"%.2f",Int_ZongJia];

    NSLog(@"%f",Int_ZongJia);
}

- (IBAction)self_button_WeiTaRen_Click:(id)sender {
    
    self.Self_image_WeiTaRen.image = [UIImage imageNamed:@"weiziji.png"];
    
    self.Self_Image_WeiZiji.image = [UIImage imageNamed:@"weitaren.png"];
}

- (IBAction)self_Button_Wei_ZiJi_Click:(id)sender {
    
    self.Self_image_WeiTaRen.image = [UIImage imageNamed:@"weitaren.png"];
    
    self.Self_Image_WeiZiji.image = [UIImage imageNamed:@"weiziji.png"];
}

- (IBAction)Self_Button_ZhiFu_Click:(id)sender {
    
    [DataService requestDataWithURL:URL_HuoQu_ZhiFu_DianHao withMethod:@"POST" withParames:nil withResult:^(id result) {

        NSDictionary *dic_result = result;
        
        NSString *str_orderNo = [NSString stringWithFormat:@"%@",[dic_result objectForKey:@"orderNo"]];
        
        ZhangHu_ChongZhiViewController *_ZhiFu_Controller = [[ZhangHu_ChongZhiViewController alloc]init];
        
        _ZhiFu_Controller.str_orderNo_ing = str_orderNo;
        
        [self.navigationController pushViewController:_ZhiFu_Controller animated:YES];
    }];

}

#pragma mark - 我的二维码
- (IBAction)Self_Button_WoDeErWeiMa_Click:(id)sender {
    
    WoDeErWeiMaViewController *woDeErWeiMa = [[WoDeErWeiMaViewController alloc]init];
    
    [self.navigationController pushViewController:woDeErWeiMa animated:YES];
}


@end
