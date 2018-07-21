//
//  HomeViewController.m
//  ZhiLianQianZhang
//
//  Created by 李晓伟 on 2017/11/28.
//  Copyright © 2017年 李晓伟. All rights reserved.
//

#import "HomeViewController.h"
#import "WXApi.h"
#import "AppDelegate.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "ZhuYeMianViewController.h"
@interface HomeViewController () <WXApiDelegate,QQApiInterfaceDelegate,TencentSessionDelegate> {
    
    AppDelegate *appdelegate;
    TencentOAuth *_tencentOAuth;
    NSArray *_permissionArray;
    NSDictionary *dic_User_Defaul;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillAppear:(BOOL)animated {
    
    NSUserDefaults *User_Defaul_Q = [NSUserDefaults standardUserDefaults];
    
    dic_User_Defaul = [User_Defaul_Q objectForKey:@"User"];
    
    NSLog(@"%@",dic_User_Defaul);
}

- (IBAction)Self_Button_WeiXin_Click:(id)sender {
        
    if ([WXApi isWXAppInstalled]) {
        
        SendAuthReq *req = [[SendAuthReq alloc] init];
        
        req.scope = @"snsapi_userinfo";
        
        req.state = @"App";
        
        req.openID = @"wxff10f21436f38794";
        
        [WXApi sendReq:req];
        
        ZhuYeMianViewController *ZhuYe_Countroller = [[ZhuYeMianViewController alloc]init];
        
        [self.navigationController pushViewController:ZhuYe_Countroller animated:YES];
        
    }else {
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请安装微信客户端" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        
        [alert show];
        
        ZhuYeMianViewController *ZhuYe_Countroller = [[ZhuYeMianViewController alloc]init];
        
        [self.navigationController pushViewController:ZhuYe_Countroller animated:YES];
    }
}

- (IBAction)Self_Button_QQ_Click:(id)sender {
    
    NSLog(@"qq");
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请安装QQ客户端" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    
    [alert show];
    
//    _tencentOAuth=[[TencentOAuth alloc]initWithAppId:@"1106491533" andDelegate:self];k
    
//    _permissionArray= [NSArray arrayWithObjects:@"get_user_info", @"get_simple_userinfo", @"add_t", nil];
    
}

- (void)tencentDidLogin
{
    [_tencentOAuth getUserInfo];
}

- (void)isOnlineResponse:(NSDictionary *)response{
    
    NSLog(@"%@",response);
}

-(void)getUserInfoResponse:(APIResponse *)response
{
    NSLog(@"respons:%@",response.jsonResponse);
}

#pragma mark - 体验一下
- (IBAction)Self_Button_TiYanYiXia_Click:(id)sender {
}

#pragma mark - 服务条款
- (IBAction)Self_FuWu_TiaoKuan:(id)sender {
}

#pragma mark - 隐私条款
- (IBAction)Self_Button_YinSiTiaoKuan_Click:(id)sender {
}


@end
