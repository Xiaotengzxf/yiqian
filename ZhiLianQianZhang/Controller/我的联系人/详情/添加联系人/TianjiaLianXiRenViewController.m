//
//  TianjiaLianXiRenViewController.m
//  ZhiLianQianZhang
//
//  Created by 李晓伟 on 2018/1/30.
//  Copyright © 2018年 李晓伟. All rights reserved.
//

#import "TianjiaLianXiRenViewController.h"
#import "DataService.h"
#import "Header.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+AFNetworking.h"
#import "XYMScanView.h"

@interface TianjiaLianXiRenViewController ()<XYMScanViewDelegate> {
    
    NSString *str_unionid;
    
    XYMScanView *scanV;
}

@end

@implementation TianjiaLianXiRenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSUserDefaults *User_Defaul_Q = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dic_User_Defaul = [User_Defaul_Q objectForKey:@"User"];
    
    NSLog(@"%@",dic_User_Defaul);
    
    str_unionid = [NSString stringWithFormat:@"%@",[dic_User_Defaul objectForKey:@"unionid"]];

    NSLog(@"%@",str_unionid);
    
}

- (IBAction)Self_Button_BaoCun_Click:(id)sender {
    
    NSDictionary *dic_S_T = [NSDictionary dictionaryWithObjectsAndKeys:self.Self_Text_LianXiRen.text,@"linkname",str_unionid,@"sunionid",self.Self_Text_ZhangHao.text,@"funionid", nil];
    
    [DataService requestDataWithURL:URL_TianJiaLianXiRen withMethod:@"POST" withParames:dic_S_T withResult:^(id result) {
        
        NSDictionary *dic_Re = result;
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (IBAction)Self_Button_Pop_Click:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)Self_Button_SaoyiSao_Click:(id)sender {
    
    scanV = [[XYMScanView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    scanV.delegate = self;
    
    scanV.scanW = [UIScreen mainScreen].bounds.size.width;
    
    [self.view addSubview:scanV];
}

-(void)getScanDataString:(NSString*)scanDataString{
    
    self.Self_Text_LianXiRen.text = [NSString stringWithFormat:@"%@",scanDataString];
    
    self.Self_Text_ZhangHao.text = scanDataString;
    
    [scanV removeFromSuperview];
}

@end
