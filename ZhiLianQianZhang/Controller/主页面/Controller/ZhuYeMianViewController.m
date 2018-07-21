//
//  ZhuYeMianViewController.m
//  ZhiLianQianZhang
//
//  Created by 李晓伟 on 2018/1/2.
//  Copyright © 2018年 李晓伟. All rights reserved.
//

#import "ZhuYeMianViewController.h"
#import "BenDiWeiJianQianShuViewController.h"
#import "CeHua_ZhuYe_View.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+AFNetworking.h"
#import "WoDeLianXiRenViewController.h"
#import "WodeZhangHuViewController.h"
#import "MuBanQianPiViewController.h"
#import "RenLianRenZhengViewController.h"
#import "DaiZiJiQian_DaiTaRenQianViewController.h"
#import "DaiTaRenQian_aViewController.h"

@interface ZhuYeMianViewController () {
    
    CeHua_ZhuYe_View *_CeHua_View;
    
    UIView *_view_CeHua_Bg;
    
    NSDictionary *dic_User_Defaul;
    
    NSString *str_Name;
}

@property (strong ,nonatomic) UIView *Myview;

@end

@implementation ZhuYeMianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.Self_View_Qian_Pi_BG.layer.masksToBounds = YES;
   
    self.Self_View_Qian_Pi_BG.layer.cornerRadius = 15.0;
    
    NSUserDefaults *User_Defaul_Q = [NSUserDefaults standardUserDefaults];
    
    dic_User_Defaul = [User_Defaul_Q objectForKey:@"User"];
    
    str_Name = [NSString stringWithFormat:@"%@",[dic_User_Defaul objectForKey:@"name"]];
    
    self.Self_View_JiLu_Bg.frame = CGRectMake(0, 0, self.Self_View_Qian_Pi_BG.bounds.size.width, 35);
    
    self.Self_View_ZhuShou_BG.layer.masksToBounds = YES;

    self.Self_View_ZhuShou_BG.layer.cornerRadius = 15.0;
}

#pragma mark - 扫一扫
- (IBAction)Self_Button_SaoYiSao_Click:(id)sender {
    
    NSLog(@"扫一扫");
}

#pragma mark - 右滑
- (IBAction)Self_Button_YouHua:(id)sender {
    
    NSLog(@"右滑");
    
    if (self.Myview == nil) {
        
        _view_CeHua_Bg = [[UIView alloc]init];
        
        _view_CeHua_Bg.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
        _view_CeHua_Bg.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.7];
      
        NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"CeHua_ZhuYe_View" owner:nil options:nil];
        
        _CeHua_View = [nibContents lastObject];
        
        _CeHua_View.frame = CGRectMake(133, 0, [UIScreen mainScreen].bounds.size.width - 133, [UIScreen mainScreen].bounds.size.height);
        
        _CeHua_View.View_Image_YongHu_Image.layer.masksToBounds = YES;
        
        _CeHua_View.View_Image_YongHu_Image.layer.cornerRadius = 30;
        
        if ([str_Name isEqualToString:@"(null)"]) {
            
            _CeHua_View.View_CeHua_Name.text = @"未认证用户";
            
        }else {
            
//            _CeHua_View.View_CeHua_Name.text = str_Name;
        }
        
        NSString *str_url_image = [NSString stringWithFormat:@"%@",[dic_User_Defaul objectForKey:@"image"]];
        
        [_CeHua_View.View_Image_YongHu_Image setImageWithURL:[NSURL URLWithString:str_url_image]];
        
        [_CeHua_View.View_Button_RenLian_RenZheng addTarget:self action:@selector(View_Button_RenLian_RenZheng_Click) forControlEvents:UIControlEventTouchUpInside];
        
        [_CeHua_View.View_Button_WoDeZhangHu addTarget:self action:@selector(View_Button_WoDeZhangHu_Click) forControlEvents:UIControlEventTouchUpInside];
        
        [_CeHua_View.View_Button_AnQuan_SheZhi addTarget:self action:@selector(View_Button_AnQuan_SheZhi_Click) forControlEvents:UIControlEventTouchUpInside];
        
        [_CeHua_View.View_Button_BangZhu addTarget:self action:@selector(View_Button_BangZhu_Click) forControlEvents:UIControlEventTouchUpInside];
        
        [_CeHua_View.View_Button_FenXiang_BianQian addTarget:self action:@selector(View_Button_FenXiang_BianQian_Click) forControlEvents:UIControlEventTouchUpInside];
        
        [_CeHua_View.View_Button_QuRenZheng addTarget:self action:@selector(View_Button_QuRenZheng_Click) forControlEvents:UIControlEventTouchUpInside];
        
        [_view_CeHua_Bg addSubview:_CeHua_View];
        
        [self.view addSubview:_view_CeHua_Bg];
    }
    
    CGRect Temp = _CeHua_View.frame;
    
    Temp.origin.x = [UIScreen mainScreen].bounds.size.width - 133;
    
    _CeHua_View.frame = Temp;
    
    Temp.origin.x = 133;
    
    [UIView animateWithDuration:0.8 animations:^{
        
        _CeHua_View.frame = Temp;
    }];
}

#pragma mark - 待自己签
- (IBAction)Self_Button_DaiZiJiQian_Click:(id)sender {
    
    
    DaiZiJiQian_DaiTaRenQianViewController *_D_Q_Controller = [[DaiZiJiQian_DaiTaRenQianViewController alloc]init];
    
    [self.navigationController pushViewController:_D_Q_Controller animated:YES];
}

#pragma mark - 待他人签
- (IBAction)Self_Button_DaiTaRenQian_Click:(id)sender {
    
    DaiTaRenQian_aViewController *_D_Q_Controller = [[DaiTaRenQian_aViewController alloc]init];
    
    
    [self.navigationController pushViewController:_D_Q_Controller animated:YES];
}

#pragma mark - 扫描拍照
- (IBAction)Self_Button_SaoMiaoPaiZhao_Click:(id)sender {
    
    NSLog(@"扫描拍照");
}

#pragma mark - 本地文件签批
- (IBAction)Self_Button_BenDiWenJianQianPi_Click:(id)sender {
    
    NSLog(@"本地文件签批");
    
    BenDiWeiJianQianShuViewController *BenDiWeiJian_QianSHu_Controller = [[BenDiWeiJianQianShuViewController alloc]init];
    
    [self.navigationController pushViewController:BenDiWeiJian_QianSHu_Controller animated:YES];
}

#pragma mark - 模板签批
- (IBAction)Self_Button_MuBanQianPi_Click:(id)sender {

    MuBanQianPiViewController *_MuBan_Controller = [[MuBanQianPiViewController alloc]init];
    
    [self.navigationController pushViewController:_MuBan_Controller animated:YES];
}

#pragma mark - 实名认证
- (IBAction)Self_Button_ShiMingRenZheng_Click:(id)sender {
    
    NSLog(@"实名认证");
    
    RenLianRenZhengViewController *_Renzheng_Controller = [[RenLianRenZhengViewController alloc]init];
    
    [self.navigationController pushViewController:_Renzheng_Controller animated:YES];
}

#pragma mark - 我的签名
- (IBAction)Self_Button_WoDeQianMing_Click:(id)sender {
    
    NSLog(@"我的签名");
}

#pragma mark - 我的消息
- (IBAction)Self_Button_WoDeXiaoXi_Click:(id)sender {
    
    NSLog(@"我的消息");
}

#pragma mark - 我的联系人
- (IBAction)Self_Button_WoDeLianXiRen_Click:(id)sender {
    
    NSLog(@"我的联系人");
    
    WoDeLianXiRenViewController *LianXiRen_Controller = [[WoDeLianXiRenViewController alloc]init];
    
    [self.navigationController pushViewController:LianXiRen_Controller animated:YES];
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [_view_CeHua_Bg removeFromSuperview];
}

#pragma mark - 侧滑 - 人脸认证
-(void) View_Button_RenLian_RenZheng_Click {
    
    NSLog(@"侧滑");
    
}

#pragma mark - 侧滑 我的账户
-(void) View_Button_WoDeZhangHu_Click {
    
    NSLog(@"我的账户");
    
    WodeZhangHuViewController *_zhanghu_Controller = [[WodeZhangHuViewController alloc]init];
    
    [self.navigationController pushViewController:_zhanghu_Controller animated:YES];
}

#pragma mark - 侧滑 安全设置
-(void) View_Button_AnQuan_SheZhi_Click {
    
    NSLog(@"安全设置");
    
}

#pragma mark - 侧滑 - 帮助
-(void) View_Button_BangZhu_Click {
    
    NSLog(@"帮助");
    
}
#pragma mark - 分享
-(void) View_Button_FenXiang_BianQian_Click {
    
    NSLog(@"分享");
}
#pragma mark - 去认证
-(void) View_Button_QuRenZheng_Click {
    
    NSLog(@"去认证");
}

@end
