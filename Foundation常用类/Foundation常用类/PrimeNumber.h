//
//  PrimeNumber.h
//  Foundation常用类
//
//  Created by Silence on 16/4/26.
//  Copyright © 2016年 ___SILENCE___. All rights reserved.
//

#import <Foundation/Foundation.h>

__attribute__ ((objc_subclassing_restricted))
@interface PrimeNumber : NSObject 

// 获取指定范围内所有的素数
+ (NSArray *)primeNumberWithEndNumber:(NSInteger)maxNum;

@property (nonatomic, copy) NSString *name;
@end




@interface Person : NSObject

- (void)uziFighting __attribute__((objc_requires_super));
@end


@interface Father : Person
@end
