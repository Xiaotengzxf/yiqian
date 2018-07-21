//
//  MuBanQianPiViewController.h
//  ZhiLianQianZhang
//
//  Created by 李晓伟 on 2018/1/27.
//  Copyright © 2018年 李晓伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MuBanQianPiViewController : UIViewController <UITableViewDelegate,UITableViewDataSource> {
    
    NSMutableArray *_Data_Array;
    
}


@property (weak, nonatomic) IBOutlet UITableView *Self_My_Tableview;


@end
