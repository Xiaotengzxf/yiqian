//
//  DataService.m
//  04 RequestData
//
//  Created by liyoubing on 15/9/22.
//  Copyright (c) 2015年 www.liyoubing.com. All rights reserved.
//

#import "DataService.h"
#import "AFNetworking.h"

@interface DataService()
@property (nonatomic, strong)AFHTTPSessionManager *manager;
@end

static DataService *_data;
@implementation DataService

+ (instancetype)share
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _data = [[self alloc]init];
    });
    return _data;
}

+ (void)requestDataWithURL:(NSString *)stringURL
                withMethod:(NSString *)method
               withParames:(NSDictionary *)parames
                withResult:(DataBlock)block {
    NSLog(@"请求URL:%@", stringURL);
    //1.获取URL
//    NSURL *url = [NSURL URLWithString:stringURL];
    
    //2.创建manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [DataService share].manager = manager;
    
    //设置请求参数的格式
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.requestSerializer.timeoutInterval = 30.f;
    
    //设置获取的数据格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    //3.请求
    if ([method isEqualToString:@"GET"])
    {
        [manager GET:stringURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if(responseObject)
            {
                block(responseObject);
            }
            else
            {
                block(@{@"code":@-3,@"msg":@"NSDicNULL"});
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSDictionary *dic = @{
                                   @"code":@-1,@"msg":@"连接服务器失败",
                                   @"error":error.localizedDescription==nil?@"":error.localizedDescription
                                   };
            block(dic);
        } ];
    }
    
    else if ([method isEqualToString:@"POST"]) {
    
       [manager POST:stringURL parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
           
       } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           
           if(responseObject)
           {
               block(responseObject);
           }
           else
           {
               block(@{@"code":@-3,@"msg":@"NSDicNULL"});
           }
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           
           NSDictionary *dic = @{
                                 @"code":@-1,@"msg":@"连接服务器失败",
                                 @"error":error.localizedDescription==nil?@"":error.localizedDescription
                                 };
           block(dic);

       }];
    }
}

+ (void)cancelRequest
{
    //NSLog(@"%@",[DataService share].manager);
    [[DataService share].manager.operationQueue cancelAllOperations];
}

@end
