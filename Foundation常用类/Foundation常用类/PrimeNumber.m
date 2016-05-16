//
//  PrimeNumber.m
//  Foundation常用类
//
//  Created by Silence on 16/4/26.
//  Copyright © 2016年 ___SILENCE___. All rights reserved.
//

#import "PrimeNumber.h"

@implementation PrimeNumber

+ (NSArray *)primeNumberWithEndNumber:(NSInteger)maxNum {
    if (maxNum < 2) return nil;
    NSMutableArray *result = [NSMutableArray array];
    if (maxNum >= 2) [result addObject:@(2)];
    if (maxNum >= 3) [result addObject:@(3)];
    
    BOOL isPrime;
    for (NSInteger first = 5; first <= maxNum; first += 2) {
        isPrime = YES;
        NSInteger i = 1;
        NSInteger num;
        
        do {
            num = [[result objectAtIndex:i] integerValue];
            if (first % num == 0) {
                isPrime = NO;
            }
            i++;
            
        } while (isPrime == YES && first / num >= num);
        
        if (isPrime) {
            [result addObject:@(first)];
        }
    }
    return result;
}

- (BOOL)isEqual:(PrimeNumber *)object {
    if ([object.name isEqualToString:self.name]) {
        return YES;
    }
    return NO;
}

#warning constructor / destructor
/* dyld(动态链接器)加载的时候调用，在main函数之前调用
*/
+ (void)load {
    NSLog(@"begin load");
}

/* 第一次调用该类的任何方法的时候调用
*/
+ (void)initialize {
    NSLog(@"begin initialize");
}

__attribute__((constructor(102)))
static void beforeMain() {
    NSLog(@"beforeMain 102");
}

__attribute__((constructor(103)))
static void beforeMain103() {
    NSLog(@"beforeMain 103");
}

__attribute__((destructor))
static void afterMain() {
    NSLog(@"aftereMain");
}
@end




@implementation Person

- (void)uziFighting {
    NSLog(@"fighting UZI");
}
@end




@implementation Father

- (void)uziFighting {
    [super uziFighting];
}
@end
