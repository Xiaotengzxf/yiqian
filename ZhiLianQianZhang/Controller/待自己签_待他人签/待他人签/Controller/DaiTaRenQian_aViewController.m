//
//  DaiTaRenQian_aViewController.m
//  ZhiLianQianZhang
//
//  Created by 李晓伟 on 2018/1/29.
//  Copyright © 2018年 李晓伟. All rights reserved.
//

#import "DaiTaRenQian_aViewController.h"

@interface DaiTaRenQian_aViewController ()

@end

@implementation DaiTaRenQian_aViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 全部
- (IBAction)Self_Button_QuanBu_Click:(id)sender {

    self.Self_Label_B_1.backgroundColor = [UIColor colorWithRed:170/255.0f green:170/255.0f blue:170/255.0f alpha:1];
    
    self.Self_Label_B_2.backgroundColor = [UIColor clearColor];
    
    self.Self_Label_B_3.backgroundColor = [UIColor clearColor];
    
    self.Self_Label_B_4.backgroundColor = [UIColor clearColor];
}

#pragma mark - 自己
- (IBAction)Self_Button_ZiJi_Click:(id)sender {
    
    self.Self_Label_B_1.backgroundColor = [UIColor clearColor];
    
    self.Self_Label_B_2.backgroundColor = [UIColor colorWithRed:170/255.0f green:170/255.0f blue:170/255.0f alpha:1];
    
    self.Self_Label_B_3.backgroundColor = [UIColor clearColor];
    
    self.Self_Label_B_4.backgroundColor = [UIColor clearColor];
}

#pragma mark - 他人
- (IBAction)Self_Button_TaRen_Click:(id)sender {
    
    self.Self_Label_B_1.backgroundColor = [UIColor clearColor];
    
    self.Self_Label_B_2.backgroundColor = [UIColor clearColor];
    
    self.Self_Label_B_3.backgroundColor = [UIColor colorWithRed:170/255.0f green:170/255.0f blue:170/255.0f alpha:1];
    
    self.Self_Label_B_4.backgroundColor = [UIColor clearColor];
    
    
}

#pragma mark - 我的发起
- (IBAction)Self_Button_FaQi_Click:(id)sender {
    
    self.Self_Label_B_1.backgroundColor = [UIColor clearColor];
    
    self.Self_Label_B_2.backgroundColor = [UIColor clearColor];
    
    self.Self_Label_B_3.backgroundColor = [UIColor clearColor];
    
    self.Self_Label_B_4.backgroundColor = [UIColor colorWithRed:170/255.0f green:170/255.0f blue:170/255.0f alpha:1];
}

- (IBAction)Self_Button_Pop_click:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
