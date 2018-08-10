//
//  BenDiWeiJianQianShuViewController.m
//  ZhiLianQianZhang
//
//  Created by 李晓伟 on 2018/1/3.
//  Copyright © 2018年 李晓伟. All rights reserved.
//

#import "BenDiWeiJianQianShuViewController.h"
#import "BenDiWenJianXuanZeTableViewCell.h"
#import "ELCImagePickerController.h"
#import "AFHTTPSessionManager.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+AFNetworking.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "MBProgressHUD.h"
#import "BJTSignView.h"
#import "Header.h"
#import "XuanZeTuPian_TuPianQianMing_ChuliViewController.h"
#import "View_PanXu_View.h"
#import <QuickLook/QuickLook.h>
#import "BendiWenJianSouSuoViewController.h"
#import "DaKaiBenDiWenJianViewController.h"

@interface BenDiWeiJianQianShuViewController () <UIDocumentInteractionControllerDelegate, ELCImagePickerControllerDelegate> {
    
    View_PanXu_View *_View_PanXu;
    NSInteger Int_PanXu_Count;
    NSString *str_Url_S;
    NSURL *fileURL;
    NSString *str_User_Id;
    NSDictionary *dic_User_Defaul;
    UIDocumentInteractionController *_documentController; //文档交互控制器
    NSInteger Int_PD_WenJian_ShangChuan;
    NSMutableArray * arrTableData;
}

#define YYEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]

//@property(nonatomic,retain)UIDocumentInteractionController *docController;

//@property (strong, nonatomic)QLPreviewController *previewController;

//@property (copy, nonatomic)NSURL *fileURL;

@end

@implementation BenDiWeiJianQianShuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    arrTableData = [[NSMutableArray alloc] init];
    
    NSUserDefaults *User_Defaul_Q = [NSUserDefaults standardUserDefaults];
    
    dic_User_Defaul = [User_Defaul_Q objectForKey:@"User"];
    
    str_User_Id = [NSString stringWithFormat:@"%@",[dic_User_Defaul objectForKey:@"id"]];

    _Data_Array = [[NSMutableArray alloc]init];
    
    Int_PanXu_Count = 0;
    
    [self URL_ShaHe_BianLi_Click];
    
    [self UI_Nib_Click];
}

-(void) UI_Nib_Click {
    
    self.Self_Tableview.delegate = self;
    
    self.Self_Tableview.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"BenDiWeiJianQianShuViewController" bundle:nil];

    [self.Self_Tableview registerNib:nib forCellReuseIdentifier:@"BenDiWenJianXuanZeTableViewCell"];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return arrTableData.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 66;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BenDiWenJianXuanZeTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:@""];
    
    if (!Cell) {
        
        Cell = [[[NSBundle mainBundle]loadNibNamed:@"BenDiWenJianXuanZeTableViewCell" owner:self options:nil]lastObject];
        
        NSDictionary * dict = [arrTableData objectAtIndex: indexPath.row];
        Cell.nameLabel.text = [dict objectForKey: @"name"];
        Cell.sizeLabel.text = [dict objectForKey: @"size"];
        Cell.dateLabel.text = [dict objectForKey: @"date"];
    }
    
    Cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return Cell;
}

#pragma mark -  遍历沙盒路径
-(void) URL_ShaHe_BianLi_Click {

    NSArray *patchs = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [patchs objectAtIndex:0];
    NSArray *files = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:[documentsDirectory stringByAppendingPathComponent:@"Inbox"] error:nil];
    for (int i = 0; i < files.count; i++) {
        NSString * filePath = [files objectAtIndex:i];
        NSString * fileName = filePath.lastPathComponent;
        if ([self getFileTypeStr:fileName.pathExtension].length > 0) {
            NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
            NSDictionary *fileDict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
            NSDate * date = fileDict.fileCreationDate;
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
            NSString * strDate = [formatter stringFromDate:date];
            [dict setObject:strDate forKey: @"date"];
            unsigned long long fileSize = fileDict.fileSize;
            NSString * strFileSize = nil;
            if (fileSize > 1024 * 1024) {
                strFileSize = [NSString stringWithFormat:@"%lluM", fileSize / 1024 / 1024];
            } else if (fileSize > 1024) {
                strFileSize = [NSString stringWithFormat:@"%lluKB", fileSize / 1024];
            } else {
                strFileSize = [NSString stringWithFormat:@"%lluB", fileSize];
            }
            [dict setObject:strFileSize forKey: @"size"];
            [dict setObject:fileName forKey:@"name"];
            [arrTableData addObject: dict];
        }
    }
}

- (NSString *)getFileTypeStr:(NSString *)pathExtension
{
    if ([pathExtension isEqualToString:@"pdf"] || [pathExtension isEqualToString:@"PDF"]) {
        return @"PDF";
    }
    if ([pathExtension isEqualToString:@"doc"] || [pathExtension isEqualToString:@"docx"] || [pathExtension isEqualToString:@"DOC"] || [pathExtension isEqualToString:@"DOCX"]) {
        return @"Word";
    }
    if ([pathExtension isEqualToString:@"ppt"] || [pathExtension isEqualToString:@"PPT"]) {
        return @"PowerPoint";
    }
    if ([pathExtension isEqualToString:@"xls"] || [pathExtension isEqualToString:@"XLS"] || [pathExtension isEqualToString:@"xlsx"] || [pathExtension isEqualToString:@"XLSX"]) {
        return @"Excel";
    }
    return @"";
}

#pragma mark - 开始选择图片
-(void) UI_Click_XuanZeTuPian {
    
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    
    // 最多选择 100 长
    elcPicker.maximumImagesCount = 1;
    
    elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
    
    elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
    
    elcPicker.onOrder = YES; //For multiple image selection, display and return order of selected images
    
    elcPicker.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie]; //Supports image and movie types
    
    elcPicker.imagePickerDelegate = self;
    
    [self presentViewController:elcPicker animated:YES completion:nil];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    for (UIView *v in [_scrollView subviews]) {
        
        [v removeFromSuperview];
    }
    
    CGRect workingFrame = _scrollView.frame;
    
    workingFrame.origin.x = 0;
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:[info count]];
    
    NSLog(@"%@",images);
    
    for (NSDictionary *dict in info) {
        
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
            
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                
                [images addObject:image];
                
                UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
                
                [imageview setContentMode:UIViewContentModeScaleAspectFit];
                
                imageview.frame = workingFrame;
                
                workingFrame.origin.x = workingFrame.origin.x + workingFrame.size.width;
                
                //                image_view_s.image = imageview.image;
                
            } else {
                
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        } else if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypeVideo){
            
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                
                [images addObject:image];
                
                UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
                
                [imageview setContentMode:UIViewContentModeScaleAspectFit];
                
                imageview.frame = workingFrame;
                
                workingFrame.origin.x = workingFrame.origin.x + workingFrame.size.width;
                
                //                image_view_s.image = imageview.image;
                
            } else {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        } else {
            
            NSLog(@"Uknown asset type");
        }
    }
    self.chosenImages = images;
    
    [_scrollView setPagingEnabled:YES];
    
    [_scrollView setContentSize:CGSizeMake(workingFrame.origin.x, workingFrame.size.height)];
    
    if (self.chosenImages.count == 0) {
    }else {
        
        UIImageView *image_View_View = [[UIImageView alloc]init];
        
        image_View_View.frame = CGRectMake(0, 0, 0, 0);
        
        image_View_View.image = [self.chosenImages objectAtIndex:0];
        
        XuanZeTuPian_TuPianQianMing_ChuliViewController *XuanZeTuPian_Controller = [[XuanZeTuPian_TuPianQianMing_ChuliViewController alloc]init];
        
        XuanZeTuPian_Controller.image_Bg_image = image_View_View.image;
        
        [self.navigationController pushViewController:XuanZeTuPian_Controller animated:YES];
    }
}

#pragma mark - ELCImagePickerController 相册取消
-(void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 选择图片
- (IBAction)Self_Button_TuPian_Click:(id)sender {
    
    NSLog(@"选择图片");
    
    [self UI_Click_XuanZeTuPian];
    
    self.Self_Label_TuPian.textColor = [UIColor colorWithRed:82/255.0f green:204/255.0f blue:186/255.0f alpha:1];
    
    self.Self_Label_TuPian_Xia.backgroundColor = [UIColor colorWithRed:82/255.0f green:204/255.0f blue:186/255.0f alpha:1];
    
    self.Self_label_Office.textColor = [UIColor blackColor];
    
    self.Self_Label_Office_Xia.backgroundColor = [UIColor clearColor];
    
    self.Self_Label_PDF.textColor = [UIColor blackColor];
    
    self.Self_Label_PDF_Xia.backgroundColor = [UIColor clearColor];
}
#pragma mark - 选择 PDF
- (IBAction)Self_Button_PDF_Click:(id)sender {
    
    self.Self_Label_PDF.textColor = [UIColor colorWithRed:82/255.0f green:204/255.0f blue:186/255.0f alpha:1];
    
    self.Self_Label_PDF_Xia.backgroundColor = [UIColor colorWithRed:82/255.0f green:204/255.0f blue:186/255.0f alpha:1];
    
    self.Self_label_Office.textColor = [UIColor blackColor];
    
    self.Self_Label_Office_Xia.backgroundColor = [UIColor clearColor];
    
    self.Self_Label_TuPian.textColor = [UIColor blackColor];
    
    self.Self_Label_TuPian_Xia.backgroundColor = [UIColor clearColor];
    
    
//    NSString *fileName = [self.listDicobjectForKey:@"fileName"];
    
    
//    self.docController = [UIDocumentInteractionController interactionControllerWithURL:[[NSBundle mainBundle] URLForResource:@"MyFile" withExtension:@"pdf"]];
//
//    self.docController.delegate =self;//设置代理
//
//    CGRect navRect =self.navigationController.navigationBar.frame;
//
//    navRect.size =CGSizeMake(1500.0f,40.0f);
//
//    [self.docController presentOptionsMenuFromRect:navRectinView:self.view animated:YES];
//
//    [self.docController presentOpenInMenuFromRect:self.view.bounds inView:self.view animated:YES];
    
    
//    NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"http://192.168.0.113:8080/Challane/userfiles/files/20180109/20180109100638_847.doc" ofType:nil];
    
//    str_Url_S = @"http://192.168.0.113:8080/Challane/userfiles/files/20180109/20180109101759_507.pptx"
    
//    file:///var/mobile/Containers/Data/Application/5912CAA3-F8FA-4C15-9202-14C789489845/Library/Caches/20180109101759_507.pptx
    
//    str_Url_S = @"file:/var/mobile/Containers/Data/Application/B3D431EA-EE82-4BA5-935A-527F3F1CAD88/Library/Caches/20180109100638_847.doc";

//    NSLog(@"%@",str_Url_S);
//
//    NSURL *url = [NSURL fileURLWithPath:str_Url_S];
//
//    NSLog(@"%@",url);

//    UIWebView *_webView = [[UIWebView alloc]init];
//
//    _webView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//
//    _webView.scalesPageToFit = YES;
//
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//
//    [_webView loadRequest:request];
//
//    [self.view addSubview:_webView];
    
//    UIDocumentInteractionController *documentVc = [UIDocumentInteractionController interactionControllerWithURL:url];
//
//    documentVc.delegate = self;
//
//    [documentVc presentPreviewAnimated:YES];
    
    //- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
    //{
    //    return self;
    //}
    //
    //- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller
    //{
    //    return self.view ;
    //}
    //
    //
    //- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller
    //{
    //    return  self.view.bounds;
    //}

//    QLPreviewController *previewController = [[QLPreviewController alloc] init];
//    previewController.dataSource = self;
//    previewController.delegate = self;
//    [self presentViewController:previewController animated:YES completion:nil];
    
//    DaKaiBenDiWenJianViewController *_DaKai_Controller = [[DaKaiBenDiWenJianViewController alloc]init];
//
//    [self.navigationController pushViewController:_DaKai_Controller animated:YES];
    
//    打开文档
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"改版.xlsx" withExtension:nil];
    
    
    
//
//    _documentController = [UIDocumentInteractionController interactionControllerWithURL:url];
//
//    [_documentController setDelegate:self];
//
//    //当前APP打开  需实现协议方法才可以完成预览功能
//    [_documentController presentPreviewAnimated:YES];
//
//    UIView *view_BG_PD = [[UIView alloc]init];
//
//    view_BG_PD.frame = CGRectMake(0, 100, 375, 100);
//
//    view_BG_PD.backgroundColor = [UIColor blueColor];
    
    Int_PD_WenJian_ShangChuan = 0;
    
//    NSURL *fileurl = [[NSBundle mainBundle] URLForResource:@"改版.xlsx" withExtension:nil];

    NSURL *fileurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@Challane/userfiles/images/20180119111800_435.pdf", URL]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:fileurl];
    
    NSURLResponse *repsonse = nil;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&repsonse error:nil];
    
    // 得到mimeType
    NSLog(@"%@", repsonse.MIMEType);
    
    NSDictionary *Dic_Data_mgcon = [NSDictionary dictionaryWithObjectsAndKeys:str_User_Id,@"id",@"xxxx.pdf",@"filename", nil];

    [self upload:@"file" filename:@"xxxx.pdf" mimeType:repsonse.MIMEType data:data parmas:Dic_Data_mgcon];
    
//    // 给本地文件发送一个请求
//    NSURL *fileurl = [[NSBundle mainBundle] URLForResource:@"改版.xlsx" withExtension:nil];
//    NSURLRequest *request = [NSURLRequest requestWithURL:fileurl];
//    NSURLResponse *repsonse = nil;
//
//    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&repsonse error:nil];
//
//    // 得到mimeType
//    NSLog(@"%@", repsonse.MIMEType);
//
//    //     NSURL *url = [[NSBundle mainBundle] URLForResource:@"改版.xlsx" withExtension:nil];
//
//    NSDictionary *Dic_Data_mgcon = [NSDictionary dictionaryWithObjectsAndKeys:str_User_Id,@"id",@"改版.xlsx",@"filename", nil];
//
//    [self upload:@"file" filename:@"改版s.xlsx" mimeType:repsonse.MIMEType data:data parmas:Dic_Data_mgcon];
}

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    
    //注意：此处要求的控制器，必须是它的页面view，已经显示在window之上了
    return self.navigationController;
}

#pragma mark - 其他文件 - Office
- (IBAction)Self_Button_Office_Click:(id)sender {
    
    self.Self_label_Office.textColor = [UIColor colorWithRed:82/255.0f green:204/255.0f blue:186/255.0f alpha:1];
    
    self.Self_Label_Office_Xia.backgroundColor = [UIColor colorWithRed:82/255.0f green:204/255.0f blue:186/255.0f alpha:1];
    
    self.Self_Label_TuPian.textColor = [UIColor blackColor];
    
    self.Self_Label_TuPian_Xia.backgroundColor = [UIColor clearColor];
    
    self.Self_Label_PDF.textColor = [UIColor blackColor];
    
    self.Self_Label_PDF_Xia.backgroundColor = [UIColor clearColor];
}

#pragma mark - 返回
- (IBAction)Self_Button_Pop_Click:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)Self_Button_PanXu_Click:(id)sender {
    
    NSLog(@"排序");
    
    Int_PanXu_Count ++;
    
    if (Int_PanXu_Count %2 == 0) {
        
        [_View_PanXu removeFromSuperview];
        
    }else {
        
        NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"View_PanXu_View" owner:nil options:nil];
        
        _View_PanXu = [nibContents lastObject];
        
        _View_PanXu.frame = CGRectMake(0, 110, [UIScreen mainScreen].bounds.size.width, 138);
        
        [_View_PanXu.View_Button_MoRen addTarget:self action:@selector(View_Button_MoRen_Click) forControlEvents:UIControlEventTouchUpInside];
        
        [_View_PanXu.View_Button_RiQi addTarget:self action:@selector(View_Button_RiQi_Click) forControlEvents:UIControlEventTouchUpInside];
        
        [_View_PanXu.View_Button_WenJianMing addTarget:self action:@selector(View_Button_WenJianMing_Click) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_View_PanXu];
    }
}

#pragma mark - 搜索
- (IBAction) Self_Button_SouSuo:(id)sender {
    
    NSLog(@"搜索");
    
    BendiWenJianSouSuoViewController *SouSuo_Controller = [[BendiWenJianSouSuoViewController alloc]init];

    [self.navigationController pushViewController:SouSuo_Controller animated:YES];
}

#pragma mark - 默认
-(void) View_Button_MoRen_Click{
    
    [_View_PanXu removeFromSuperview];
    
    Int_PanXu_Count = 0;
    
    _View_PanXu.View_Image_MoRen.image = [UIImage imageNamed:@"paixu.png"];
    
    _View_PanXu.View_Image_RiQi.image = [UIImage imageNamed:@""];
    
    _View_PanXu.View_Image_WenJianMing.image = [UIImage imageNamed:@""];
}

#pragma mark - 日期
-(void) View_Button_RiQi_Click{
    
    [_View_PanXu removeFromSuperview];
    
    Int_PanXu_Count = 0;
    
    _View_PanXu.View_Image_MoRen.image = [UIImage imageNamed:@""];
    
    _View_PanXu.View_Image_RiQi.image = [UIImage imageNamed:@"paixu.png"];
    
    _View_PanXu.View_Image_WenJianMing.image = [UIImage imageNamed:@""];
}

#pragma mark - 文件名
-(void) View_Button_WenJianMing_Click {
    
    [_View_PanXu removeFromSuperview];
    
    Int_PanXu_Count = 0;
    
    _View_PanXu.View_Image_MoRen.image = [UIImage imageNamed:@""];
    
    _View_PanXu.View_Image_RiQi.image = [UIImage imageNamed:@""];
    
    _View_PanXu.View_Image_WenJianMing.image = [UIImage imageNamed:@"paixu.png"];
}

- (void)upload:(NSString *)name filename:(NSString *)filename mimeType:(NSString *)mimeType data:(NSData *)data parmas:(NSDictionary *)params
 {
     NSURL *url;
     
     if (Int_PD_WenJian_ShangChuan == 0) {
         
         url  = [NSURL URLWithString:[NSString stringWithFormat:@"%@Challane/challane/challaneFile/uploadMedias", URL]];

     }else {
         
         url  = [NSURL URLWithString:[NSString stringWithFormat:@"%@Challane/challane/challaneFile/pdftojpg", URL]];
     }
     
     
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
     
         request.HTTPMethod = @"POST";
    
         // 设置请求体
         NSMutableData *body = [NSMutableData data];
    
         /***************文件参数***************/
         // 参数开始的标志
         [body appendData:YYEncode(@"--YY\r\n")];
         // name : 指定参数名(必须跟服务器端保持一致)
         // filename : 文件名
         NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, filename];
         [body appendData:YYEncode(disposition)];
         NSString *type = [NSString stringWithFormat:@"Content-Type: %@\r\n", mimeType];
         [body appendData:YYEncode(type)];
    
         [body appendData:YYEncode(@"\r\n")];
         [body appendData:data];
         [body appendData:YYEncode(@"\r\n")];
    
         /***************普通参数***************/
         [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                 // 参数开始的标志
                [body appendData:YYEncode(@"--YY\r\n")];
                 NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n", key];
                 [body appendData:YYEncode(disposition)];
        
                 [body appendData:YYEncode(@"\r\n")];
                 [body appendData:YYEncode(obj)];
                 [body appendData:YYEncode(@"\r\n")];
             }];

         /***************参数结束***************/
         // YY--\r\n
         [body appendData:YYEncode(@"--YY--\r\n")];
        request.HTTPBody = body;
    
         // 设置请求头
         // 请求体的长度
         [request setValue:[NSString stringWithFormat:@"%zd", body.length] forHTTPHeaderField:@"Content-Length"];
         // 声明这个POST请求是个文件上传
         [request setValue:@"multipart/form-data; boundary=YY" forHTTPHeaderField:@"Content-Type"];
    
    // 发送请求
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            NSLog(@"%@", dict);
            
            Int_PD_WenJian_ShangChuan ++;
            
            if (Int_PD_WenJian_ShangChuan == 1) {
             
                NSURL *fileurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@Challane/userfiles/images/20180119111800_435.pdf", URL]];
                
                NSURLRequest *request = [NSURLRequest requestWithURL:fileurl];
                
                NSURLResponse *repsonse = nil;
                
                NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&repsonse error:nil];
                
                // 得到mimeType
                NSLog(@"%@", repsonse.MIMEType);
                
                NSDictionary *Dic_Data_mgcon = [NSDictionary dictionaryWithObjectsAndKeys:str_User_Id,@"id",@"xxxx.pdf",@"filename", nil];
                
                [self upload:@"file" filename:@"xxxx.pdf" mimeType:repsonse.MIMEType data:data parmas:Dic_Data_mgcon];
                
            }else {
                Int_PD_WenJian_ShangChuan = 0;
            }

        } else {
                
                NSLog(@"上传失败");
            }
    }];
}
 - (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
 {
         // Socket 实现断点上传
    
         //apache-tomcat-6.0.41/conf/web.xml 查找 文件的 mimeType
     //    UIImage *image = [UIImage imageNamed:@"test"];
     //    NSData *filedata = UIImagePNGRepresentation(image);
     //    [self upload:@"file" filename:@"test.png" mimeType:@"image/png" data:filedata parmas:@{@"username" : @"123"}];
    
         // 给本地文件发送一个请求
         NSURL *fileurl = [[NSBundle mainBundle] URLForResource:@"itcast.txt" withExtension:nil];
        NSURLRequest *request = [NSURLRequest requestWithURL:fileurl];
         NSURLResponse *repsonse = nil;
         NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&repsonse error:nil];
    
        // 得到mimeType
         NSLog(@"%@", repsonse.MIMEType);
     
//     NSURL *url = [[NSBundle mainBundle] URLForResource:@"改版.xlsx" withExtension:nil];

    [self upload:@"file" filename:@"改版.xlsx" mimeType:repsonse.MIMEType data:data parmas:nil];
}

@end
