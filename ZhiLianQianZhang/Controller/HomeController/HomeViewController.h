//
//  HomeViewController.h
//  ZhiLianQianZhang
//
//  Created by 李晓伟 on 2017/11/28.
//  Copyright © 2017年 李晓伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface HomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *self_View_ZhangHao_Bg_1;
@property (weak, nonatomic) IBOutlet UIView *Self_View_ZhangHao_Bg_2;
@property (weak, nonatomic) IBOutlet UIView *Self_View_MiMa_Bg_1;

@property (weak, nonatomic) IBOutlet UIView *Self_View_MiMa_Bg_2;

@property (strong, nonatomic) TencentOAuth *tencentOAuth;

@end
