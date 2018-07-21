//
//  BendiWenJianSouSuoViewController.h
//  ZhiLianQianZhang
//
//  Created by 李晓伟 on 2018/1/13.
//  Copyright © 2018年 李晓伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BendiWenJianSouSuoViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *Self_Text_NeiROng;

@property (weak, nonatomic) IBOutlet UITableView *Self_TableView;

@end
