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

@end
