//
//  DataService.h
//  04 RequestData
//
//  Created by liyoubing on 15/9/22.
//  Copyright (c) 2015年 www.liyoubing.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DataBlock)(id result);

@interface DataService : NSObject


/**
 网络请求工具

 @param stringURL 后代地址
 @param method    POST或者GET
 @param parames   上传的参数(字典形式)
 @param block     返回的结果
 */
+ (void)requestDataWithURL:(NSString *)stringURL
                withMethod:(NSString *)method
               withParames:(NSDictionary *)parames
                withResult:(DataBlock)block;


+ (void)cancelRequest;

@end
