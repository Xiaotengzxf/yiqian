//
//  XiangQing_ZhanShi_MuBanViewController.m
//  ZhiLianQianZhang
//
//  Created by 李晓伟 on 2018/1/27.
//  Copyright © 2018年 李晓伟. All rights reserved.
//

#import "XiangQing_ZhanShi_MuBanViewController.h"

@interface XiangQing_ZhanShi_MuBanViewController ()

@end

@implementation XiangQing_ZhanShi_MuBanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.Self_label_BiaoTi.text = self.str_Biaoti;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.str_RUL_ing]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    self.self_My_web.backgroundColor = [UIColor whiteColor];
    
    [self.self_My_web loadRequest:request];
}

- (IBAction)Self_Button_Pop_Click:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
