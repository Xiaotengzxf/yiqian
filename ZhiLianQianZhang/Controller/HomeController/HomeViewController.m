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
#import "ZhuYeMianViewController.h"

@interface HomeViewController () <WXApiDelegate,TencentSessionDelegate> {
    NSArray *_permissionArray;
    NSDictionary *dic_User_Defaul;
}

@end

@implementation HomeViewController

@synthesize tencentOAuth;

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
    isQQNotWeixin = NO;
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
        
    }
}

- (IBAction)Self_Button_QQ_Click:(id)sender {
    isQQNotWeixin = YES;
    self.tencentOAuth=[[TencentOAuth alloc]initWithAppId:@"1106491533" andDelegate:self];
    if ([TencentOAuth iphoneQQInstalled]) {
        _permissionArray= [NSArray arrayWithObjects:@"get_user_info", @"get_simple_userinfo", nil];
        [self.tencentOAuth authorize:_permissionArray inSafari:NO];
    } else {
        _permissionArray= [NSArray arrayWithObjects:@"get_user_info", @"get_simple_userinfo", nil];
        [self.tencentOAuth authorize:_permissionArray inSafari:NO];
    }
    
}

- (void)tencentDidLogin
{
    if ([self.tencentOAuth accessToken]) {
        //[self.tencentOAuth getUserInfo];
        
        ZhuYeMianViewController *ZhuYe_Countroller = [[ZhuYeMianViewController alloc]init];
        [self.navigationController pushViewController:ZhuYe_Countroller animated:YES];
        
    } else {
        NSLog(@"qq登录失败");
    }
    
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

- (void)tencentDidNotLogin:(BOOL)cancelled {
    NSLog(@"用户取消登录");
}

- (void)tencentDidNotNetWork {
    NSLog(@"没有网络登录不了");
}


- (BOOL)tencentNeedPerformIncrAuth:(TencentOAuth *)tencentOAuth withPermissions:(NSArray *)permissions{
    [tencentOAuth incrAuthWithPermissions:permissions];
    return NO;
}

- (BOOL)tencentNeedPerformReAuth:(TencentOAuth *)tencentOAuth{
    return YES;
}

- (void)tencentDidUpdate:(TencentOAuth *)tencentOAuth{
    NSLog(@"增量授权完成");
    if (tencentOAuth.accessToken
        && 0 != [tencentOAuth.accessToken length])
    { // 在这里第三方应用需要更新自己维护的token及有效期限等信息
        // **务必在这里检查用户的openid是否有变更，变更需重新拉取用户的资料等信息** _labelAccessToken.text = tencentOAuth.accessToken;
    }
    else {
        NSLog(@"增量授权不成功，没有获取accesstoken");
    }
}

- (void)tencentFailedUpdate:(UpdateFailType)reason {
    
    switch (reason)
    {
        case kUpdateFailNetwork:
        {
            NSLog(@"增量授权失败，无网络连接，请设置网络");
            break;
        }
        case kUpdateFailUserCancel:
        {
            NSLog(@"增量授权失败，用户取消授权");
            break;
        }
        case kUpdateFailUnknown:
        default:
        {
            NSLog(@"增量授权失败，未知错误");
            break;
        }
    }
}

@end
