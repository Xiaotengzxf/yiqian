//
//  ZhangHu_ChongZhiViewController.m
//  ZhiLianQianZhang
//
//  Created by 李晓伟 on 2018/1/26.
//  Copyright © 2018年 李晓伟. All rights reserved.
//

#import "ZhangHu_ChongZhiViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "Header.h"
#import "DataService.h"
#import <AlipaySDK/AlipaySDK.h>
#import <UIKit/UIKit.h>
@interface ZhangHu_ChongZhiViewController () {
    
    NSUserDefaults *User_Defaul_Q;
    
    NSString *str_User_Id;
    
    NSString *str_User_unionid;
    
    NSString *str_Pd_Wx_ZFB;
}

@end

@implementation ZhangHu_ChongZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    User_Defaul_Q  = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dic_User_Defaul = [User_Defaul_Q objectForKey:@"User"];
    
    NSLog(@"%@",dic_User_Defaul);
    
    str_User_Id = [NSString stringWithFormat:@"%@",[dic_User_Defaul objectForKey:@"id"]];
    
    str_User_unionid = [NSString stringWithFormat:@"%@",[dic_User_Defaul objectForKey:@"unionid"]];
    
    str_Pd_Wx_ZFB = @"0";
    
    self.Self_Button_QueRen_Zhifu.layer.masksToBounds = YES;
    
    self.Self_Button_QueRen_Zhifu.layer.cornerRadius = 10;
}

#pragma mark - 选择微信
- (IBAction)Self_Button_WeiXin_Click:(id)sender {
    
    str_Pd_Wx_ZFB = @"10";
    
    self.Self_Image_ZhiFuBao.image = [UIImage imageNamed:@"weitaren.png"];
    
    self.Self_Image_Weixin.image = [UIImage imageNamed:@"weiziji.png"];
}

#pragma mark - 选择支付宝
- (IBAction)Self_Button_ZhiFuBao_Click:(id)sender {
    
    str_Pd_Wx_ZFB = @"20";
    
    self.Self_Image_ZhiFuBao.image = [UIImage imageNamed:@"weiziji.png"];
    
    self.Self_Image_Weixin.image = [UIImage imageNamed:@"weitaren.png"];

}

#pragma mark - 确认支付
- (IBAction)Self_Button_QueRen_ZhiFu_Click:(id)sender {
    
    if ([str_Pd_Wx_ZFB isEqualToString:@"20"]) {
        
        //  支付宝
        
        [self URL_ZhiFuBao_ZhiFu_Click];
        
    }else {
        
//        str_Pd_Wx_ZFB = @"10";  微信

        
    }
}

-(void) URL_ZhiFuBao_ZhiFu_Click {
    
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"30m",@"timeout_express",@"QUICK_MSECURITY_PAY",@"product_code",@"0.01",@"total_amount",@"易签支付订单",@"subject",@"易签支付",@"body",self.str_orderNo_ing,@"out_trade_no", nil];
    
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:str_User_Id,@"id",str_User_unionid,@"unionid",self.str_orderNo_ing,@"orderNo",@"0.1",@"totalPrice",@"",@"goodsType",@"20",@"typePrice",@"10G",@"memory",@"10",@"term",@"1G",@"expansion",@"0",@"expansionPrice",@"20",@"expansionTerm",@"10",@"payMent", nil];
    
    NSLog(@"%@",dic);

    NSError *error;

    NSString *jsonString;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];

    if (!jsonData) {

        NSLog(@"%@",error);

    }else{

        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:str_User_Id,@"id",jsonString,@"biz", nil];
    
    NSLog(@"%@",dict);
    
    [DataService requestDataWithURL:URL_ZhiFuBao_MiYao withMethod:@"POST" withParames:dict withResult:^(id result) {
        
        NSLog(@"%@",result);
        
        NSString *str_orderinfo = [NSString stringWithFormat:@"%@",[result objectForKey:@"orderInfo"]];

        NSLog(@"%@",str_orderinfo);
        
        [[AlipaySDK defaultService] payOrder:str_orderinfo fromScheme:@"QianZhang" callback:^(NSDictionary *resultDic) {
            
            NSLog(@"reslut = %@",resultDic); // 网页支付跳转到该block
            
            NSString *resultStatus = [NSString stringWithFormat:@"%@",resultDic[@"resultStatus"]];
            
            if ([resultStatus isEqualToString:@"9000"]) {
   
            }
        }];
        
    }];
}


#pragma mark - 返回
- (IBAction)Self_Pop_Button_Click:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
