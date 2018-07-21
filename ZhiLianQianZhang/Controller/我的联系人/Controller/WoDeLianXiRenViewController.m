//
//  WoDeLianXiRenViewController.m
//  ZhiLianQianZhang
//
//  Created by 李晓伟 on 2018/1/18.
//  Copyright © 2018年 李晓伟. All rights reserved.
//

#import "WoDeLianXiRenViewController.h"
#import "DataService.h"
#import "Header.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+AFNetworking.h"
#import "WodeLianXiRenTableViewCell.h"
#import "TianjiaLianXiRenViewController.h"
#import "XiuGaiLianXiRenViewController.h"
@interface WoDeLianXiRenViewController ()<UITextFieldDelegate> {
    
    NSString *str_unionid;
    
    NSString *str_text;
}

@end

@implementation WoDeLianXiRenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    Challane/challane/challaneUser/friendlist
    
    NSUserDefaults *User_Defaul_Q = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dic_User_Defaul = [User_Defaul_Q objectForKey:@"User"];
    
    str_unionid = [NSString stringWithFormat:@"%@",[dic_User_Defaul objectForKey:@"unionid"]];
    
    self.Self_My_textField.delegate = self;
    
    self.Self_Text_Bg_1.layer.masksToBounds = YES;
    
    self.Self_Text_Bg_1.layer.cornerRadius = 15;
    
    self.Self_Text_Bg_2.layer.masksToBounds = YES;
    
    self.Self_Text_Bg_2.layer.cornerRadius = 15;
}


-(void)viewWillAppear:(BOOL)animated {
    
    [self UI_Click];
    
    [self URL_Click];
}

-(void)UI_Click {
    
    self.Self_My_Tableview.delegate = self;
    
    self.Self_My_Tableview.dataSource = self;
    
    self.Self_My_Tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib *nib = [UINib nibWithNibName:@"WoDeLianXiRenViewController" bundle:nil];
    
    [self.Self_My_Tableview registerNib:nib forCellReuseIdentifier:@"WodeLianXiRenTableViewCell"];
}

-(void) URL_Click {
    
    NSDictionary *dic_S_T = [NSDictionary dictionaryWithObjectsAndKeys:str_unionid,@"unionid", nil];
    
    [DataService requestDataWithURL:URL_TongXunLu_LieBie withMethod:@"POST" withParames:dic_S_T withResult:^(id result) {
        
        NSDictionary *dic_Re = result;
                
        _Data_Array = [[NSMutableArray alloc]init];
        
        _Data_Array = [dic_Re objectForKey:@"friend"];

        [self.Self_My_Tableview reloadData];
        
    }];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _Data_Array.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 62;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WodeLianXiRenTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:@""];
    
    if (!Cell) {
        
        Cell = [[[NSBundle mainBundle]loadNibNamed:@"WodeLianXiRenTableViewCell" owner:self options:nil]lastObject];
    }
    
    NSDictionary *dic_Cell = [_Data_Array objectAtIndex:indexPath.row];
    
    Cell.Cell_Label_Name.text = [NSString stringWithFormat:@"%@",[dic_Cell objectForKey:@"linkname"]];
    
//    [Cell.Cell_Image_TouXiang setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic_Cell objectForKey:@""]]]];
    
    Cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return Cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic_cell = [_Data_Array objectAtIndex:indexPath.row];
    
    NSLog(@"%@",dic_cell);
    
    NSString *str_zhanghao = [NSString stringWithFormat:@"%@",[dic_cell objectForKey:@"friendunionid"]];
    
    NSString *str_id = [NSString stringWithFormat:@"%@",[dic_cell objectForKey:@"id"]];
    
    NSLog(@"%@",str_id);
    
    NSString *str_name = [NSString stringWithFormat:@"%@",[dic_cell objectForKey:@"linkname"]];
    
    XiuGaiLianXiRenViewController *Xiu = [[XiuGaiLianXiRenViewController alloc]init];
    
    Xiu.str_ID = str_id;
    
    Xiu.str_Name = str_name;
    
    Xiu.str_ZhangHao = str_zhanghao;
    
    [self.navigationController pushViewController:Xiu animated:YES];
}


-(void) textFieldDidBeginEditing:(UITextField *)textField {
    
    textField.text = @"";
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    [self sousuo_LianxiRen_Click];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic_cell = [_Data_Array objectAtIndex:indexPath.row];
    
    NSString *str_Id_s = [NSString stringWithFormat:@"%@",[dic_cell objectForKey:@"id"]];
    
    NSDictionary *dic_S_T = [NSDictionary dictionaryWithObjectsAndKeys:str_Id_s,@"id", nil];
    
    [DataService requestDataWithURL:URL_ShanChuLianXiRen withMethod:@"POST" withParames:dic_S_T withResult:^(id result) {
        
        NSDictionary *dic_Re = result;
        
        NSLog(@"%@",dic_Re);
        
        [self URL_Click];
    }];
}


-(void) sousuo_LianxiRen_Click {
    
    NSDictionary *dic_S_Ts = [NSDictionary dictionaryWithObjectsAndKeys:self.Self_My_textField.text,@"unionid", nil];
    
    [DataService requestDataWithURL:URL_TongXunLu_LieBiao_SouSuo withMethod:@"POST" withParames:dic_S_Ts withResult:^(id result) {
        
        NSDictionary *dic_Re = result;
        
        NSLog(@"%@",dic_Re);
        
        _Data_Array = [[NSMutableArray alloc]init];
        
        _Data_Array = [dic_Re objectForKey:@"friend"];
        
        [self.Self_My_Tableview reloadData];
    }];
}

- (IBAction)Self_Button_Pop_Click:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)self_Button_Next_Click:(id)sender {
    
    TianjiaLianXiRenViewController *TianJia = [[TianjiaLianXiRenViewController alloc]init];
    
    [self.navigationController pushViewController:TianJia animated:YES];
}

@end
