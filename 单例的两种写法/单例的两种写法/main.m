//
//  main.m
//  单例的两种写法
//
//  Created by Silent on 2017/5/9.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mother.h"
#import "Father.h"
#import "Son.h"

/** GCD单例模式 */
void SingletonDemo_01() {
    Mother *m1 = [[Mother alloc] init];
//    m1.name = @"1";
//    m1.age = 52;
    Mother *m2 = m1.copy;
    Mother *m3 = [Mother shareMother];
    Mother *m4 = [Mother new];
    Mother *m5 = [[Mother alloc] init];
    m4.age = 45;
    
    NSLog(@"%@===%p", m1, m1);
    NSLog(@"%@===%p", m2, m2);
    NSLog(@"%@===%p", m3, m3);
    NSLog(@"%@===%p", m4, m4);
    NSLog(@"%@===%p", m5, m5);
}

/** 非GCD单例模式 */
void SingletonDemo_02() {
    Father *m1 = [[Father alloc] init];
    m1.name = @"1";
//    m1.age = 52;
    Father *m2 = m1.copy;
    Father *m3 = [Father shareFather];
    Father *m4 = [Father new];
//    m3.name = @"3";
    Father *m5 = [[Father alloc] init];
    
    NSLog(@"%@===%p", m1, m1);
    NSLog(@"%@===%p", m2, m2);
    NSLog(@"%@===%p", m3, m3);
    NSLog(@"%@===%p", m4, m4);
    NSLog(@"%@===%p", m5, m5);
}

void SingletonDemo_03() {
    Son *m1 = [[Son alloc] init];
    m1.name = @"1";
    m1.age = 52;
    Son *m2 = m1.copy;
    Son *m3 = [Son shareSon];
    Son *m4 = [Son new];
    m3.name = @"3";
    Son *m5 = [[Son alloc] init];
    
    NSLog(@"%@===%p", m1, m1);
    NSLog(@"%@===%p", m2, m2);
    NSLog(@"%@===%p", m3, m3);
    NSLog(@"%@===%p", m4, m4);
    NSLog(@"%@===%p", m5, m5);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
//        SingletonDemo_01();
//        SingletonDemo_02();
        SingletonDemo_03();
    }
    return 0;
}
