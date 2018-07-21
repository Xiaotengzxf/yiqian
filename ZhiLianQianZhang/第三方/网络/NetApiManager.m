//
//  NetApiManager.m
//  CeShiTest
//
//  Created by 李晓伟 on 2017/7/17.
//  Copyright © 2017年 李晓伟. All rights reserved.
//

#import "NetApiManager.h"
#import "RealReachability.h"
#import "NSDictionary+NullReplacement.h"

static NetApiManager *netApiManager;

@implementation NetApiManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netApiManager = [[NetApiManager alloc]init];
        netApiManager.serviceType = SERVICE_TYPE;
        [RealReachability sharedInstance].hostForPing = @"m.jyall.com";
        [GLobalRealReachability startNotifier];
    });
    return netApiManager;
}

+(NSString *)get_BASEURL{
    NSInteger type = [NetApiManager sharedInstance].serviceType;
    if (type == 1) {
        return DEV_BASEURL;
    }else if (type == 2) {
        return TEST_BASEURL;
    }else if (type == 3) {
        return PRO_BASEURL;
    }
    return PRO_BASEURL;
}

/**
 *  处理接口返回字段为 null 问题
 *  @return 用“”替换“null”后的数据结果
 */
+ (id)replaceNullsWithBlanksWithResponseObject:(id)responseObject
{
    if ([responseObject isKindOfClass:[NSArray class]]) {
        responseObject = [responseObject arrayByReplacingNullsWithBlanks];
    }
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        responseObject = [responseObject dictionaryByReplacingNullsWithBlanks];
    }
    return responseObject;
}
+ (void)getFromURL:(NSString *)URLString
            params:(NSDictionary *)params
          finished:(NetApiCallBack)finished
{
//    [NetApiManager sharedInstance] .getUrl = URLString;
    if (params != nil) {
        [NetApiManager sharedInstance].prameDic = params;
        [NetApiManager sharedInstance].postBody = nil;
    } else {
        [NetApiManager sharedInstance].prameDic = nil;
        [NetApiManager sharedInstance].postBody = nil;
    }
    
    AFHTTPSessionManager *manager = [NetApiManager sharedInstance].manager;
    NSLog(@"---->%@",manager.requestSerializer.HTTPRequestHeaders);
    NSLog(@"---->%@",URLString);
    [manager GET:URLString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        responseObject = [NetApiManager replaceNullsWithBlanksWithResponseObject:responseObject];
        NetResponse *apiObject = [[NetResponse alloc]initWithTask:task responseObject:responseObject error:nil];
        finished(apiObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NetResponse *apiObject = [[NetResponse alloc]initWithTask:task responseObject:nil error:error];
        [apiObject checkNotReachability];
        finished(apiObject);
        //tokenid失效返回code 然后弹出登录
    }];
}

+ (void)postToURL:(NSString *)URLString
       bodyParams:(id)bodyParams
         finished:(NetApiCallBack)finished
{
    [NetApiManager sharedInstance].prameDic = bodyParams;
    AFHTTPSessionManager *manager = [NetApiManager sharedInstance].manager;
    [manager POST:URLString parameters:bodyParams progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        responseObject = [NetApiManager replaceNullsWithBlanksWithResponseObject:responseObject];
        
        NetResponse *apiObject = [[NetResponse alloc]initWithTask:task responseObject:responseObject error:nil];
        
        finished(apiObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NetResponse *apiObject = [[NetResponse alloc]initWithTask:task responseObject:nil error:error];
        
        [apiObject checkNotReachability];
        finished(apiObject);
        //tokenid失效返回code 然后弹出登录
    }];
}

+ (void)postToImgUrl:(NSString *)strUrl parme:(NSDictionary *)parme ImgArr:(NSArray *)imgArr finished:(NetApiCallBack)finished {
    
    [NetApiManager sharedInstance].prameDic = parme;
    AFHTTPSessionManager *manager = [NetApiManager sharedInstance].manager;
    
    [manager POST:strUrl parameters:parme constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i = 0; i<imgArr.count; i++) {
            
            UIImage *image = imgArr[i];
            NSData* imageData = UIImageJPEGRepresentation(image, 0.3);
            if (!imageData) {
                imageData = UIImagePNGRepresentation(image);
            }
            [formData appendPartWithFileData:imageData name:@"file" fileName:[NSString stringWithFormat:@"file%d",i] mimeType:@"image/jpeg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        responseObject = [NetApiManager replaceNullsWithBlanksWithResponseObject:responseObject];
        
        NetResponse *apiObject = [[NetResponse alloc]initWithTask:task responseObject:responseObject error:nil];
        finished(apiObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NetResponse *apiObject = [[NetResponse alloc]initWithTask:task responseObject:nil error:error];
        
        [apiObject checkNotReachability];
        finished(apiObject);
        
    }];
}

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
        sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        [sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        sessionManager.responseSerializer = responseSerializer;
        [sessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        sessionManager.requestSerializer.timeoutInterval = 30.f;
        [sessionManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*",@"application/x-www-form-urlencoded"]];
        sessionManager.operationQueue.maxConcurrentOperationCount = 3;
        _manager = sessionManager;
    }
    [NetApiManager setHttpCommonHeader:_manager];
    
    return _manager;
}
+ (void)setHttpCommonHeader:(AFHTTPSessionManager *)manager{
    
    NSArray *allKeyArray = [[NetApiManager sharedInstance].prameDic allKeys];
    
    NSArray *afterSortKeyArray = [allKeyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSComparisonResult resuest = [obj1 compare:obj2];
        return resuest;
    }];
    NSLog(@"afterSortKeyArray:%@",afterSortKeyArray);
    
    //通过排列的key值获取value
    NSMutableArray *valueArray = [NSMutableArray array];
    for (NSString *sortsing in afterSortKeyArray) {
        NSString *valueString = [[NetApiManager sharedInstance].prameDic objectForKey:sortsing];
        [valueArray addObject:valueString];
    }
    NSLog(@"valueArray:%@",valueArray);
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<afterSortKeyArray.count; i++) {
        if ([valueArray[i] isKindOfClass:[NSArray class]]) {
            
            NSLog(@"%@", [valueArray[i] componentsJoinedByString:@","]);
            
        } else {
            [arr addObject:[NSString stringWithFormat:@"%@=%@",afterSortKeyArray[i],valueArray[i]]];
        }
    }
        NSTimeInterval a = [[NSDate date] timeIntervalSince1970];
    
        if (arr.count != 0) {
            NSString *bodyStr = [arr componentsJoinedByString:@"&"];
            
            NSString *systemString = [NSString stringWithFormat:@"iOS %@",[UIDevice currentDevice].systemVersion];
            
            [manager.requestSerializer setValue:systemString forHTTPHeaderField:@"vesionCode"];
            [manager.requestSerializer setValue:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forHTTPHeaderField:@"deviceId"];
        } else {
            
            NSString *systemString = [NSString stringWithFormat:@"iOS %@",[UIDevice currentDevice].systemVersion];
            
            [manager.requestSerializer setValue:systemString forHTTPHeaderField:@"vesionCode"];
            [manager.requestSerializer setValue:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forHTTPHeaderField:@"deviceId"];
        }
}

@end

@implementation NetResponse

- (instancetype)initWithTask:(NSURLSessionDataTask *)task responseObject :(id)responseObject error :(NSError *) error{
    self = [super init];
    if (self) {
        self.url = task.originalRequest.URL.absoluteString;
        self.httpCode = [[responseObject objectForKey:@"status"] integerValue];
        self.responseObject = responseObject;
        
        self.task = task;
        if (self.httpCode == 1) {
            self.isSuccess = YES;
        }else{
            self.isSuccess = NO;
            if (responseObject!= nil) {
                self.errorMessage = [NSString stringWithFormat:@"%@",responseObject[@"msg"]];
            } else {
                int code;
                
                self.errorMessage = [self getErrorMessage:error code:&code];
                self.code = code;
                self.error = error;
            }
        }
    }
    return self;
}

-(NSString *)getErrorMessage:(NSError *)error code:(int *)code
{
    NSString *errorMessage = nil;
    for (id data in error.userInfo.allValues) {
        if ([data isKindOfClass:[NSData class]]) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            errorMessage = dic[@"msg"];
            *code = [dic[@"status"] intValue];
        }
        if ([data isKindOfClass:[NSError class]]) {
            errorMessage = [self getErrorMessage:data code:code];
        }
    }
    if (errorMessage == nil || [errorMessage isKindOfClass:[NSNull class]]) {
        return @"请求失败";
    }
    return errorMessage;
}

-(NetResponse *)checkNotReachability{
    if (self.httpCode == 500 ||self.httpCode == 400) {
        return self;
    }
    NSInteger status = [RealReachability sharedInstance].currentReachabilityStatus;
    if (status == RealStatusNotReachable) {
        self.isSuccess = NO;

        self.errorMessage = @"网络连接失败";
    }
    return self;
}
@end
