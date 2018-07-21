//
//  BendiWenJianSouSuoViewController.m
//  ZhiLianQianZhang
//
//  Created by 李晓伟 on 2018/1/13.
//  Copyright © 2018年 李晓伟. All rights reserved.
//

#import "BendiWenJianSouSuoViewController.h"

@interface BendiWenJianSouSuoViewController ()

@end

@implementation BendiWenJianSouSuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void) UI_TableView_Click {
    
    self.Self_TableView.delegate = self;
    
    self.Self_TableView.dataSource = self;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 30;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *Cell;
    
    return Cell;
}

#pragma mark - 清空
- (IBAction)Self_Button_QingCHu_CLick:(id)sender {
    
    
}

- (IBAction)Self_Button_QuXiao_Click:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
