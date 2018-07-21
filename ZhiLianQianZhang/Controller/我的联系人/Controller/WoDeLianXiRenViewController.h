//
//  WoDeLianXiRenViewController.h
//  ZhiLianQianZhang
//
//  Created by 李晓伟 on 2018/1/18.
//  Copyright © 2018年 李晓伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WoDeLianXiRenViewController : UIViewController <UITableViewDelegate,UITableViewDataSource> {
    
    NSMutableArray *_Data_Array;
    
}

@property (weak, nonatomic) IBOutlet UITableView *Self_My_Tableview;

@property (weak, nonatomic) IBOutlet UITextField *Self_My_textField;


@property (weak, nonatomic) IBOutlet UIView *Self_Text_Bg_1;

@property (weak, nonatomic) IBOutlet UIView *Self_Text_Bg_2;



@end
