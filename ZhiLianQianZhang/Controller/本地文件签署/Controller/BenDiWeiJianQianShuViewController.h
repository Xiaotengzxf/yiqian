//
//  BenDiWeiJianQianShuViewController.h
//  ZhiLianQianZhang
//
//  Created by 李晓伟 on 2018/1/3.
//  Copyright © 2018年 李晓伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BenDiWeiJianQianShuViewController : UIViewController <UITableViewDelegate,UITableViewDataSource> {
    
    NSMutableArray *_Data_Array;
}

@property (weak, nonatomic) IBOutlet UITableView *Self_Tableview;

@property (nonatomic, copy) NSMutableArray *chosenImages;

@property (nonatomic, strong)  UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *Self_label_Office;

@property (weak, nonatomic) IBOutlet UILabel *Self_Label_Office_Xia;

@property (weak, nonatomic) IBOutlet UILabel *Self_Label_PDF;

@property (weak, nonatomic) IBOutlet UILabel *Self_Label_PDF_Xia;

@property (weak, nonatomic) IBOutlet UILabel *Self_Label_TuPian;

@property (weak, nonatomic) IBOutlet UILabel *Self_Label_TuPian_Xia;

@property (weak, nonatomic) IBOutlet UILabel *Self_Label_PanXu;


@end
