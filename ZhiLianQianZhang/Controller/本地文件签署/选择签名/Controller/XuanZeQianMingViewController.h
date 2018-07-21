//
//  XuanZeQianMingViewController.h
//  ZhiLianQianZhang
//
//  Created by 李晓伟 on 2018/1/8.
//  Copyright © 2018年 李晓伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegisterViewControl <NSObject>

-(void)sendValues:(UIImage *)Image_ChuanZhi;

@end

@interface XuanZeQianMingViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,RegisterViewControl> {
    
    NSMutableArray *_Data_Array;
}

@property (assign, nonatomic) id<RegisterViewControl>delegate;

@property (weak, nonatomic) IBOutlet UITableView *Self_TableView;

@property (nonatomic, strong)  UIImage *image_Bg_image;


@end
