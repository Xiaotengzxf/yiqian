//
//  XiuGaiLianXiRenViewController.m
//  ZhiLianQianZhang
//
//  Created by 李晓伟 on 2018/1/30.
//  Copyright © 2018年 李晓伟. All rights reserved.
//

#import "XiuGaiLianXiRenViewController.h"
#import "DataService.h"
#import "Header.h"

@interface XiuGaiLianXiRenViewController ()

@end

@implementation XiuGaiLianXiRenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.Self_Text_XingMing.text = self.str_Name;
    
    self.Self_Label_ZhangHao.text = self.str_ZhangHao;
}

- (IBAction)Self_Button_BaoCun_Click:(id)sender {
    
    
    NSDictionary *dic_S_T = [NSDictionary dictionaryWithObjectsAndKeys:self.str_ID,@"id",self.Self_Text_XingMing.text,@"linkname", nil];
    
    NSLog(@"%@",dic_S_T);
    
    [DataService requestDataWithURL:URL_XiuGai_LianXiRen withMethod:@"POST" withParames:dic_S_T withResult:^(id result) {
        
        NSDictionary *dic_Re = result;
        
        NSLog(@"%@",dic_Re);
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (IBAction)Self_Button_Pop_Click:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}



@end
