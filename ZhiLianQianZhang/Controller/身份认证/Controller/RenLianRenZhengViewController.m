//
//  RenLianRenZhengViewController.m
//  ZhiLianQianZhang
//
//  Created by 李晓伟 on 2018/1/27.
//  Copyright © 2018年 李晓伟. All rights reserved.
//

#import "RenLianRenZhengViewController.h"
#import "DataService.h"
#import "Header.h"
#import "NetApiManager.h"


@interface RenLianRenZhengViewController ()<UIImagePickerControllerDelegate> {
    
    UIImage *_image_ShenFenZheng;
    
    NSString *str_Shenfenzheng_Hao;
    NSString *str_ShenFen_Name;
    NSString *str_Shenfen_Key;
    NSString *str_User_Id;

    
}

@end

@implementation RenLianRenZhengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSUserDefaults *User_Defaul_Q = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dic_User_Defaul = [User_Defaul_Q objectForKey:@"User"];
    
    str_User_Id = [NSString stringWithFormat:@"%@",[dic_User_Defaul objectForKey:@"id"]];
}

#pragma mark - 开始拍照
- (IBAction)Self_Button_KaiShiPaiZhao_click:(id)sender {
    

    [self URL_PaiZhao_ShiBie_Click];
}

-(void)get1
{
    
    NSString *str1 = [str_ShenFen_Name stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
    //1.确定请求路径
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://op.juhe.cn/idcard/query?key=%@&idcard=%@&realname=%@",str_Shenfen_Key,str_Shenfenzheng_Hao,str1]];
    
    //2.创建请求对象
    //请求对象内部默认已经包含了请求头和请求方法（GET）
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //3.获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    //4.根据会话对象创建一个Task(发送请求）
    /*
     第一个参数：请求对象
     第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
     data：响应体信息（期望的数据）
     response：响应头信息，主要是对服务器端的描述
     error：错误信息，如果请求失败，则error有值
     */
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil) {
            //6.解析服务器返回的数据
            //说明：（此处返回的数据是JSON格式的，因此使用NSJSONSerialization进行反序列化处理）
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            
            NSLog(@"%@",dict);
            
            NSString *str_reason = [NSString stringWithFormat:@"%@",[dict objectForKey:@"error_code"]];
            
            NSLog(@"%@",str_reason);
            
            if ([str_reason isEqualToString:@"0"]) {
                
                NSDictionary *dic_result = [dict objectForKey:@"result"];
                
                NSString *str_dic_idcard = [NSString stringWithFormat:@"%@",[dic_result objectForKey:@"idcard"]];
                
                NSString *str_dic_realname = [NSString stringWithFormat:@"%@",[dic_result objectForKey:@"realname"]];
                
                NSString *str_dic_sex = @"男";
                
                NSString *str_shengri = @"1993-04-21";
                
                NSString *str_dizhi = @"临汾";
                
                NSDictionary *dic_xx = [NSDictionary dictionaryWithObjectsAndKeys:str_dic_idcard,@"number",str_dic_realname,@"name",str_dic_sex,@"sex",str_shengri,@"birth",str_dizhi,@"address",str_User_Id,@"userid", nil];
                
                [DataService requestDataWithURL:URL_ShenFen_RenZheng_ChengGong withMethod:@"POST" withParames:dic_xx withResult:^(id result) {

                    NSDictionary *dic_Re = result;
                    
                    NSLog(@"%@",dic_Re);
                }];
            }
        }
    }];
    
    [dataTask resume];
    
    
    [self URL_TuPian_ShiBie_Click];
}


-(void)URL_PaiZhao_ShiBie_Click {
    
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    
    if (!isCamera) {
        NSLog(@"没有摄像头");
        return;
    }
    //初始化图片选择控制器
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;//设置通过照相来选取照片
    
    imagePicker.allowsEditing = YES; //设置拍照时的下方的工具栏是否显示，如果需要自定义拍摄界面，则可把该工具栏隐藏
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];

    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    //在这个方法里我们可以进行图片的修改, 保存, 或者视频的保存
    // UIImagePickerControllerOriginalImage 原始图片
    // UIImagePickerControllerEditedImage 编辑后图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    _imageView.image = image;
    
    
//    NSString *imageDocPath = [self getImageSavePath];//保存
//    _photoUrl = imageDocPath;
//    NSLog(@"imageDocPath == %@", imageDocPath);
    _image_ShenFenZheng = image;
    
    self.Self_Image_ShenFenZheng.image = image;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    [self URL_TuPian_ShiBie_Click];
}

//当用户取消相册时, 调用该方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - 下一步
- (IBAction)Self_Button_XiaYIBu_Click:(id)sender {
    
    str_Shenfen_Key = @"b016502da3760ce60ee63b8b76f80fdb";
    
    str_Shenfenzheng_Hao = @"141002199304210011";
    
    str_ShenFen_Name = @"李晓伟";
    
    [self get1];
}


-(void) URL_TuPian_ShiBie_Click {
    
    //    NSString *appcode = @"你自己的AppCode";
    
    NSString *appcode = @"24777096";
    
    NSString *host = @"https://dm-51.data.aliyun.com";
    NSString *path = @"/rest/160601/ocr/ocr_idcard.json";
    NSString *method = @"POST";
//    82d11e1901c8f937f3e4b1f1cbc5a5bc
    NSString *querys = @"82d11e1901c8f937f3e4b1f1cbc5a5bc";
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    NSData *data =UIImageJPEGRepresentation(self.Self_Image_ShenFenZheng.image,1.0);
    
    NSString *base64String = [data base64Encoding];
    
//    NSString *bodys = [NSString stringWithFormat:@"{\"inputs\":[{\"image\":{\"dataType\":50,\"dataValue\":\"%@\"},\"configure\":{\"dataType\":50,\"dataValue\":\"{\\\"side\\\":\\\"face\\\"}\"@"":face/face}}]}",base64String];
    
    NSMutableArray *array_D = [[NSMutableArray alloc]init];
    
    NSDictionary *dic_d_1_1 = [NSDictionary dictionaryWithObjectsAndKeys:@"50",@"dataType",base64String,@"dataValue", nil];
    
    NSDictionary *dic_d_1 = [NSDictionary dictionaryWithObjectsAndKeys:dic_d_1_1,@"image", nil];
    
    NSLog(@"%@",dic_d_1);
    
    NSDictionary *dic_d_2_2 = [NSDictionary dictionaryWithObjectsAndKeys:@"face",@"side", nil];
    
    NSDictionary *dic_dic_2_1 = [NSDictionary dictionaryWithObjectsAndKeys:@"50",@"dataType",dic_d_2_2,@"dataValue", nil];
    
    NSDictionary *dic_d_2 = [NSDictionary dictionaryWithObjectsAndKeys:dic_dic_2_1,@"configure", nil];
    
    NSLog(@"%@",dic_d_2);
    
    
    [array_D addObject:dic_d_2];
    
    [array_D addObject:dic_d_1];
    
    NSDictionary *dic_Data = [NSDictionary dictionaryWithObjectsAndKeys:array_D,@"inputs", nil];
    
    NSLog(@"%@",dic_Data);
    
    NSError *error;
    
    NSString *jsonString;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic_Data options:NSJSONWritingPrettyPrinted error:&error];
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    
    NSLog(@"%@",url);
    
    request.HTTPMethod  =  method;
    
    [request addValue:  [NSString  stringWithFormat:@"APPCODE%@",appcode]  forHTTPHeaderField:@"Authorization"];
    
    //根据API的要求，定义相对应的Content-Type
    [request addValue: @"application/json;charset=UTF-8" forHTTPHeaderField: @"Content-Type"];
    
    NSData *dataa = [jsonString dataUsingEncoding: NSUTF8StringEncoding];
    
    NSLog(@"%@",dataa);
    
    [request setHTTPBody: dataa];
    
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {

        
        NSLog(@"Response object: %@" , response);
        
        NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                                                       
        //打印应答中的body
        NSLog(@"Response body: %@" , bodyString);
        
        NSData *data = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
                                                       
        NSLog(@"%@",data);
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                                       
        NSLog(@"%@",dic);
        
        NSDictionary *model = dic[@"outputs"][0];
        
        NSString *dataValue = model[@"outputValue"][@"dataValue"];
        
        NSLog(@"%@",dataValue);
        
        NSData *data1 = [dataValue dataUsingEncoding:NSUTF8StringEncoding];
                                                       
        NSLog(@"%@",data1);
                                                       
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"dataDic ===  %@", dataDic);
        
    }];
    
    [task resume];
}


-(void) URL_x {
    
    //
    //    NSString * postPath = @"/rest/160601/ocr/ocr_vehicle.json";
    //
    //    NSMutableDictionary *postQueryParams = [[NSMutableDictionary alloc] init];
    //    [postQueryParams setValue:@"TestQueryNameVlaue" forKey:@"TestQueryName"];
    //
    //    NSMutableDictionary *postHeaderParams = [[NSMutableDictionary alloc] init];
    //    [postHeaderParams setValue:@"TestPostHeaderValue" forKey:@"TestPostHeader"];
    //
    //    // a.这里就是之前文档里面的那个代码 要用json字符串格式 我用转义字符来直接写了这个字符串
    //    NSString *bodyString = [NSString stringWithFormat:@"{\"inputs\":[{\"image\":{\"dataType\":50,\"dataValue\":\" %@ \"}}]}", base64String];
//        NSData *body = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    //    // b. 点击进入这个方法里面  修改CLOUDAPI_HTTP 为CLOUDAPI_HTTPS常量。 因为本功能用到的是https而不是http
    //    [[HttpUtil instance] httpPost:postPath
    //                       pathParams:nil
    //                      queryParams:postQueryParams
    //                             body:body
    //                     headerParams:postHeaderParams
    //                  completionBlock:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
    //                      NSLog(@"Response object: %@" , response);
    //                      NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
    //                      NSLog(@"Response body: %@" , bodyString);
    //
    //                      // d.这是我对返回的json字符串信息 做的处理 最后出来的是一个字典
    //                      NSData *data = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    //                      NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    //                      NSDictionary *model = dic[@"outputs"][0];
    //                      NSString *dataValue = model[@"outputValue"][@"dataValue"];
    //                      NSData *data1 = [dataValue dataUsingEncoding:NSUTF8StringEncoding];
    //                      NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingMutableContainers error:nil];
    //                      NSLog(@"dataDic ===  %@", dataDic);
    //                  }];
}

#pragma mark - 返回
- (IBAction)Self_Button_pop_Click:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
