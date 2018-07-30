//
//  AppDelegate.m
//  ZhiLianQianZhang
//
//  Created by 李晓伟 on 2017/11/28.
//  Copyright © 2017年 李晓伟. All rights reserved.
//

#import "AppDelegate.h"
#import "Header.h"
#import "DataService.h"
#import "NetApiManager.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <AlipaySDK/AlipaySDK.h>

BOOL isQQNotWeixin = NO;

@interface AppDelegate () <WXApiDelegate, QQApiInterfaceDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    _Home_View = [[HomeViewController alloc]init];
    
    _NC = [[UINavigationController alloc]initWithRootViewController:_Home_View];
    
    self.window.rootViewController = _NC;
    
    [WXApi registerApp:@"wxff10f21436f38794"];
    

    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    if ([url.host isEqualToString:@"qzapp"]) {
        return [TencentOAuth HandleOpenURL:url];
    }else {
        return [WXApi handleOpenURL:url delegate:self];
    }
}

-(void) onResp:(BaseResp*)resp
{
    if (isQQNotWeixin) {
        
    } else {
        SendAuthResp *aresp = (SendAuthResp *)resp;
        
        if(aresp.errCode== 0 && [aresp.state isEqualToString:@"App"]) {
            NSString *code = aresp.code;
            NSLog(@"%@",code);
            [self getWeiXinOpenId:code];
        }
    }
}

- (void)isOnlineResponse:(NSDictionary *)response {
    NSLog(@"qq登录回调：%@", response);
}

- (void)getWeiXinOpenId:(NSString *)code{
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",@"wxff10f21436f38794",@"e3382ce0684f8b2fa79d929e21f9e15c",code];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURL *zoneUrl = [NSURL URLWithString:url];
        
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (data){
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
//                NSString *openID = dic[@"openid"];
//                NSString *unionid = dic[@"unionid"];
                
                NSString *infoUrl =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",dic[@"access_token"],dic[@"openid"]];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    NSURL *zoneUrl = [NSURL URLWithString:infoUrl];
                    
                    NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
                    
                    NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (data){
                         
                            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                            
                            NSLog(@"%@",dic);
                            
                            NSString *str_openid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"openid"]];
                            
                            NSLog(@"%@",str_openid);
                            
                            NSDictionary *dic_S_T = [NSDictionary dictionaryWithObjectsAndKeys:str_openid,@"openId", nil];
                            
                            [DataService requestDataWithURL:URL_DengLU_ withMethod:@"POST" withParames:dic_S_T withResult:^(id result) {

                                NSDictionary *dicsss = result;
                                
                                NSLog(@"%@",dicsss);
                                
                                NSDictionary *dic_data = [dicsss objectForKey:@"user"];
                                
                                NSString *str_id = [NSString stringWithFormat:@"%@",[dic_data objectForKey:@"id"]];
                                
                                NSString *str_isNewRecord = [NSString stringWithFormat:@"%@",[dic_data objectForKey:@"isNewRecord"]];
                                
                                NSString *str_level = [NSString stringWithFormat:@"%@",[dic_data objectForKey:@"level"]];
                                
                                NSString *str_openid = [NSString stringWithFormat:@"%@",[dic_data objectForKey:@"openid"]];
                                
                                NSString *str_point = [NSString stringWithFormat:@"%@",[dic_data objectForKey:@"point"]];
                                
                                NSString *str_nickname = [NSString stringWithFormat:@"%@",[dic objectForKey:@"nickname"]];
                                
                                NSLog(@"%@",str_nickname);
                                
                                NSString *str_headimgurl = [NSString stringWithFormat:@"%@",[dic objectForKey:@"headimgurl"]];
                                
//                                NSString *string_unionid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"unionid"]];
                                
                                NSString *string_unionid = [dicsss objectForKey:@"card"];
                                
                                NSLog(@"%@",string_unionid);
                                
                                NSUserDefaults *User_Defaul_Data = [NSUserDefaults standardUserDefaults];
                                
                                NSDictionary *dic_User_B = [NSDictionary dictionaryWithObjectsAndKeys:str_id,@"id",str_isNewRecord,@"isNewRecord",str_level,@"level",str_openid,@"openid",str_point,@"point",str_nickname,@"name",str_headimgurl,@"image",string_unionid,@"unionid", nil];
                                
                                NSLog(@"%@",dic_User_B);
                                
                                [User_Defaul_Data setObject:dic_User_B forKey:@"User"];
                            }];
                        }
                    });
                });
            }
        });
    });
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        }];

        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {

            NSLog(@"result = %@",resultDic);

            NSString *result = resultDic[@"result"];

            NSString *authCode = nil;

            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }else if ([url.host isEqualToString:@"qzapp"]) {
        return [TencentOAuth HandleOpenURL:url];
    }else {
        
//
//        SendAuthResp *aresp = (SendAuthResp *)resp;
//
//        if(aresp.errCode== 0 && [aresp.state isEqualToString:@"App"])
//        {
//            NSString *code = aresp.code;
//            [self getWeiXinOpenId:code];
//        }
//        [self getWeiXinOpenId:code];
        
        [WXApi handleOpenURL:url delegate:self];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)onReq:(QQBaseReq *)req {
    NSLog(@"QQ或微信登录请求");
}


@end
