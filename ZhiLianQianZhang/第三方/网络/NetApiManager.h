//
//  NetApiManager.h
//  CeShiTest
//
//  Created by 李晓伟 on 2017/7/17.
//  Copyright © 2017年 李晓伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

/// 设置默认服务器 1为开发服务器, 2为测试服务器, 3为正式服务器
#define SERVICE_TYPE 2
//开发模式接口
#define DEV_BASEURL @"http://api.meiweiyun.cn/"
//测试模式接口
#define TEST_BASEURL @"http://api.meiweiyun.cn/"
//生产模式接口
#define PRO_BASEURL @"http://api.meiweiyun.cn/"


@class NetResponse;

typedef void(^NetApiCallBack)(NetResponse * netResponse);

@interface NetApiManager : NSObject

@property (strong,nonatomic) NSString *getUrl;

@property (strong,nonatomic) NSDictionary *prameDic;

@property (strong,nonatomic) NSDictionary *postBody;

@property(strong, nonatomic) AFHTTPSessionManager *manager;

/// 设置默认服务器 1为开发服务器, 2为测试服务器, 3为正式服务器
@property (nonatomic , assign)NSInteger serviceType;
+ (instancetype)sharedInstance;
+(NSString *)get_BASEURL;

/**
 *  get 方法
 *
 *  @param URLString 请求 url
 *  @param params    参数
 *  @param finished  返回结果回调
 */
+ (void)getFromURL:(NSString *)URLString
            params:(NSDictionary *)params
          finished:(NetApiCallBack)finished;
/**
 *  post 请求
 *
 *  @param URLString  请求url
 *  @param bodyParams body体参数
 *  @param finished   返回结果回调
 */
+ (void)postToURL:(NSString *)URLString
       bodyParams:(id)bodyParams
         finished:(NetApiCallBack)finished;




+ (void)postToImgUrl:(NSString *)strUrl parme:(NSDictionary *)parme ImgArr:(NSArray *)imgArr finished:(NetApiCallBack)finished;


@end


@interface NetResponse : NSObject

///返回的httpCode
@property (assign,nonatomic) NSInteger httpCode;

@property (assign,nonatomic) NSInteger code;
///返回的错误信息
@property (copy,nonatomic) NSString *errorMessage;
///是否成功
@property (assign) BOOL isSuccess;
@property(copy, nonatomic) NSString *url;//请求url
@property (nonatomic) id responseObject;
@property (nonatomic,strong) NSError *error;
@property (nonatomic, strong) NSURLSessionDataTask *task;
- (instancetype)initWithTask:(NSURLSessionDataTask *)task responseObject :(id)responseObject error :(NSError *) error;
-(NetResponse *)checkNotReachability;

@end
