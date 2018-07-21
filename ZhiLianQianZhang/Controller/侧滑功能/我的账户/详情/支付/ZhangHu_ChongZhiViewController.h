//
//  ZhangHu_ChongZhiViewController.h
//  ZhiLianQianZhang
//
//  Created by 李晓伟 on 2018/1/26.
//  Copyright © 2018年 李晓伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhangHu_ChongZhiViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *Self_Label_FeiYong_Text;

@property (weak, nonatomic) IBOutlet UILabel *Self_Label_FuFei_RenShu_Text;

@property (weak, nonatomic) IBOutlet UILabel *Self_Label_ChongZhi_Riqi_KaiShi;

@property (weak, nonatomic) IBOutlet UILabel *Self_Label_ChongZhi_Riqi_JieShu;

@property (weak, nonatomic) IBOutlet UILabel *Self_Label_KuoZhan_RiQi_KaiShi;

@property (weak, nonatomic) IBOutlet UILabel *Self_Label_KuoZhan_RiQi_JieShu;

@property (weak, nonatomic) IBOutlet UIImageView *Self_Image_Weixin;

@property (weak, nonatomic) IBOutlet UIImageView *Self_Image_ZhiFuBao;

@property (weak, nonatomic) IBOutlet UIButton *Self_Button_QueRen_Zhifu;

@property (nonatomic, copy) NSString *str_orderNo_ing;

@end
