//
//  DaKaiBenDiWenJianViewController.m
//  ZhiLianQianZhang
//
//  Created by 李晓伟 on 2018/1/13.
//  Copyright © 2018年 李晓伟. All rights reserved.
//

#import "DaKaiBenDiWenJianViewController.h"
#import "AFHTTPSessionManager.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+AFNetworking.h"
@interface DaKaiBenDiWenJianViewController () <UIDocumentInteractionControllerDelegate> {
    
    UIDocumentInteractionController *_documentController; //文档交互控制器
    
    NSString *str_Fi_String;
}

@end

@implementation DaKaiBenDiWenJianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//
//    NSArray *patchs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//
//    // 获取Documents路径
//    // [patchs objectAtIndex:0]
//    NSString *documentsDirectory = [patchs objectAtIndex:0];
//    NSString *fileDirectory = [documentsDirectory stringByAppendingPathComponent:@"%@", dirName];
//    NSArray *files = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:fileDirectory error:nil];
    
    NSString *docDirectionary = [NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()];

    NSFileManager *fileM = [NSFileManager defaultManager];
    
    NSArray *subPaths = [fileM contentsOfDirectoryAtPath:docDirectionary error:nil];
    
    NSLog(@"%@",subPaths);
    
    if (subPaths) {
        
        for (NSString *subpath in subPaths) {
            
            NSLog(@"%@",subpath);
        }
    }
    
    [self URL_WenJian_XiaZai_Cick];
}

//预览
- (IBAction)Self_Button_YuLian_Click:(id)sender {
    
    NSLog(@"%@",str_Fi_String);
    
    //初始化文档交互
    //准备文档的Url
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"改版.xlsx" withExtension:nil];
    
    _documentController = [UIDocumentInteractionController interactionControllerWithURL:url];
    
    [_documentController setDelegate:self];
    
    //当前APP打开  需实现协议方法才可以完成预览功能
    [_documentController presentPreviewAnimated:YES];
    
//    UIView *view_b = [[UIView alloc]init];
//
//    view_b.frame = CGRectMake(100, 100, 100, 100);
//
//    view_b.backgroundColor = [UIColor blueColor];
//
//    [_documentController addSubview:view_b];
    
}

//第三方打开 手机中安装有可以打开此格式的软件都可以打开
//- (void)openClick:(UIButton *)btn {
//
//    //初始化文档交互
//    //准备文档的Url
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"全年账单.rtf" withExtension:nil];
//
//    _documentController = [UIDocumentInteractionController interactionControllerWithURL:url];
//    [_documentController setDelegate:self];
//
//    [_documentController presentOpenInMenuFromRect:btn.frame inView:self.view animated:YES];
//}

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    
    //注意：此处要求的控制器，必须是它的页面view，已经显示在window之上了
    return self.navigationController;
}

#pragma mark - 文件下载
-(void) URL_WenJian_XiaZai_Cick {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.0.113:8080/Challane/userfiles/files/20180109/20180109100638_847.doc"]];
    //下载文件
    /*
     第一个参数:请求对象
     第二个参数:progress 进度回调
     第三个参数:destination 回调(目标位置)
     有返回值
     targetPath:临时文件路径
     response:响应头信息
     第四个参数:completionHandler 下载完成后的回调
     filePath:最终的文件路径
     */
    NSURLSessionDownloadTask *download = [manager downloadTaskWithRequest:request
                                                                 progress:^(NSProgress * _Nonnull downloadProgress) {
                                                                     //下载进度
                                                                     NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
                                                                 }
                                                              destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                                                                  //保存的文件路径
                                                                  NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
                                                                  return [NSURL fileURLWithPath:fullPath];
                                                                  
                                                              }
                                                        completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                                                            
                                                            NSLog(@"%@",filePath);
                                                            
                                                            NSURL *url_xx = filePath;
                                                            
                                                            str_Fi_String = [NSString stringWithFormat:@"%@",filePath];
                                                            
                                                        }];
    
    //执行Task
    [download resume];
}


@end
