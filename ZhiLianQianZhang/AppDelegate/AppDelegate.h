//
//  AppDelegate.h
//  ZhiLianQianZhang
//
//  Created by 李晓伟 on 2017/11/28.
//  Copyright © 2017年 李晓伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "WXApi.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate> {
    
    HomeViewController *_Home_View;
    UINavigationController *_NC;
    
}

@property (strong, nonatomic) UIWindow *window;


@end

