//
//  NSDictionary+NullReplacement.h
//  JinSeJiaYuanWang
//
//  Created by 李晓伟 on 17/7/17.
//  Copyright © 2016年 JYall Network Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NullReplacement)
- (NSDictionary *)dictionaryByReplacingNullsWithBlanks;
@end

@interface NSArray (NullReplacement)
- (NSArray *)arrayByReplacingNullsWithBlanks;
@end
