//
//  MuBanQianPiViewController.m
//  ZhiLianQianZhang
//
//  Created by 李晓伟 on 2018/1/27.
//  Copyright © 2018年 李晓伟. All rights reserved.
//

#import "MuBanQianPiViewController.h"
#import "MuBanQianPiTableViewCell.h"
#import "AFHTTPSessionManager.h"
#import "Header.h"
#import "DataService.h"
#import "XiangQing_ZhanShi_MuBanViewController.h"
@interface MuBanQianPiViewController ()

@end

@implementation MuBanQianPiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self UI_Click];
    
    [self URL_Click];
}

-(void) UI_Click {
    
    self.Self_My_Tableview.delegate = self;
    
    self.Self_My_Tableview.dataSource = self;
    
    self.Self_My_Tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.Self_My_Tableview.backgroundColor = [UIColor colorWithRed:239/255.0f green:239/255.0f blue:244/255.0f alpha:1];
    
    
    UINib *nib = [UINib nibWithNibName:@"MuBanQianPiViewController" bundle:nil];
    
    [self.Self_My_Tableview registerNib:nib forCellReuseIdentifier:@"MuBanQianPiTableViewCell"];
}
-(void) URL_Click {

    [DataService requestDataWithURL:URL_HuoQu_MuBan withMethod:@"POST" withParames:nil withResult:^(id result) {
        
        NSDictionary *dic_Re = result;
        
        _Data_Array = [[NSMutableArray alloc]init];
        
        _Data_Array = [dic_Re objectForKey:@"templet"];
        
        [self.Self_My_Tableview reloadData];
        
    }];
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _Data_Array.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return  61;
    
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MuBanQianPiTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:@""];
    
    if (!Cell) {
        
        Cell = [[[NSBundle mainBundle]loadNibNamed:@"MuBanQianPiTableViewCell" owner:self options:nil]lastObject];
    }

    NSDictionary *Dic_Cell = [_Data_Array objectAtIndex:indexPath.row];
    
    Cell.Cell_label_Name_text.text = [NSString stringWithFormat:@"%@",[Dic_Cell objectForKey:@"fliename"]];
    
    Cell.Cell_View_Bg_1.layer.masksToBounds = YES;
    
    Cell.Cell_View_Bg_1.layer.cornerRadius = 10;
    
    Cell.Cell_View_Bg_2.layer.masksToBounds = YES;
    
    Cell.Cell_View_Bg_2.layer.cornerRadius = 10;
    
    Cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return Cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic_cell = [_Data_Array objectAtIndex:indexPath.row];
    
    NSString *str_web_url = [NSString stringWithFormat:@"%@%@",URL,[dic_cell objectForKey:@"filesrc"]];
    
    NSString *str_biaoTi = [NSString stringWithFormat:@"%@",[dic_cell objectForKey:@"fliename"]];
    
    XiangQing_ZhanShi_MuBanViewController *_xq_controller = [[XiangQing_ZhanShi_MuBanViewController alloc]init];
    
    _xq_controller.str_RUL_ing = str_web_url;
    
    _xq_controller.str_Biaoti = str_biaoTi;
    
    [self.navigationController pushViewController:_xq_controller animated:YES];
}

#pragma mark - 返回
- (IBAction)self_button_pop_Click:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
