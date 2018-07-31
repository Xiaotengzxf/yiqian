//
//  XuanZeQianMingViewController.m
//  ZhiLianQianZhang
//
//  Created by 李晓伟 on 2018/1/8.
//  Copyright © 2018年 李晓伟. All rights reserved.
//

#import "XuanZeQianMingViewController.h"
#import "XuanZeQianMingTableViewCell.h"
#import "XuanZeQianMing1TableViewCell.h"
#import "XinJianQianMingViewController.h"
#import "DataService.h"
#import "Header.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+AFNetworking.h"
#import "DrawSignView.h"


@interface XuanZeQianMingViewController () {
    
    NSString *str_User_Id;
}

@end

@implementation XuanZeQianMingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    NSUserDefaults *User_Defaul_Q = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dic_User_Defaul = [User_Defaul_Q objectForKey:@"User"];
    
    str_User_Id = [NSString stringWithFormat:@"%@",[dic_User_Defaul objectForKey:@"id"]];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self UI_TableView_Click];
    
    [self URL_Tableview_Click];
}

-(void) URL_Tableview_Click {
    
    NSDictionary *dic_S_T = [NSDictionary dictionaryWithObjectsAndKeys:str_User_Id,@"id", nil];
    
    [DataService requestDataWithURL:URL_HuoQu_XinJianQianMing_LieBiao withMethod:@"POST" withParames:dic_S_T withResult:^(id result) {
        
        NSDictionary *dic_Re = result;
        
        NSLog(@"%@",dic_Re);
        
        _Data_Array = [[NSMutableArray alloc]init];

        NSString *str_Code = [NSString stringWithFormat:@"%@",[dic_Re objectForKey:@"code"]];
        
        if ([str_Code isEqualToString:@"200"]) {
            
            _Data_Array = [dic_Re objectForKey:@"data"];
       
            [self.Self_TableView reloadData];
        }
    }];
}

-(void) UI_TableView_Click {
    
    self.Self_TableView.delegate = self;
    
    self.Self_TableView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"XuanZeQianMingViewController" bundle:nil];
    
    [self.Self_TableView registerNib:nib forCellReuseIdentifier:@"XuanZeQianMingTableViewCell"];
    
    UINib *nib1 = [UINib nibWithNibName:@"XuanZeQianMingViewController" bundle:nil];
    
    [self.Self_TableView registerNib:nib1 forCellReuseIdentifier:@"XuanZeQianMing1TableViewCell"];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _Data_Array.count + 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 186;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == _Data_Array.count) {
        
        XuanZeQianMing1TableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"1"];
        
        if (!Cell) {
            
            Cell = [[[NSBundle mainBundle]loadNibNamed:@"XuanZeQianMing1TableViewCell" owner:self options:nil]lastObject];
        }
        
        Cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return Cell;
        
    } else {
        
        XuanZeQianMingTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"1"];
        
        if (!Cell) {
            
            Cell = [[[NSBundle mainBundle]loadNibNamed:@"XuanZeQianMingTableViewCell" owner:self options:nil]lastObject];
        }
        
        [Cell.Self_Button_Delete addTarget:self action:@selector(Self_Button_Delete_Click:) forControlEvents:UIControlEventTouchUpInside];
        
        NSDictionary *Dic_Cell = [_Data_Array objectAtIndex:indexPath.row];
        
        NSString *str_URL_filesrc = [NSString stringWithFormat:@"%@%@",URL, [Dic_Cell objectForKey:@"filesrc"]];

        [Cell.Cell_Image_QianMing_Image setImageWithURL:[NSURL URLWithString:str_URL_filesrc]];
        
        Cell.Self_Button_Delete.tag = indexPath.row;
        
        Cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return Cell;
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == _Data_Array.count) {
        
        NSLog(@"最后");
        XinJianQianMingViewController *xinjian_Controller = [[XinJianQianMingViewController alloc]init];
        [self.navigationController pushViewController:xinjian_Controller animated:YES];
        
        // 添加新的签名
    } else {
        NSLog(@"%li",indexPath.row);
        XuanZeQianMingTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if ([self.delegate respondsToSelector:@selector(sendValues:)]) {
            [self.delegate sendValues: cell.Cell_Image_QianMing_Image.image];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 确定
- (IBAction)Self_Button_QueDing_Click:(id)sender {
    
    NSLog(@"确定");
}

#pragma mark - Cell - 删除
-(void) Self_Button_Delete_Click:(UIButton *)Sender {
    
    NSLog(@"%li",Sender.tag);
    //NSInteger int_Tag = Sender.tag;
    NSMutableArray *array_ShanChu = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < _Data_Array.count; i++) {
        
        NSDictionary *dic_Array = [_Data_Array objectAtIndex:i];
        
        if (i == Sender.tag) {
            
        }else {
            
            [array_ShanChu addObject:dic_Array];
        }
    }
    _Data_Array = array_ShanChu;
    
    [self.Self_TableView reloadData];
}

- (IBAction)Self_Button_PoP_Click:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}



@end
