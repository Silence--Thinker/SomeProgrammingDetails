//
//  PrimeNumber.h
//  Foundation常用类
//
//  Created by Silence on 16/4/26.
//  Copyright © 2016年 ___SILENCE___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrimeNumber : NSObject

// 获取指定范围内所有的素数
+ (NSArray *)primeNumberWithEndNumber:(NSInteger)maxNum;

@property (nonatomic, copy) NSString *name;

@end
