//
//  MRCBlock.m
//  块Block的使用
//
//  Created by Silent on 2017/6/1.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "MRCBlock.h"

@implementation MRCBlock
int mrc_argument = 0;

- (void)dealloc {
    NSLog(@"%s", __func__);
    [super dealloc];
}

/*
    块具有：
    1、对其封闭作用域中可见的自动变量的只读访问权限
    2、对函数或者方法中声明的静态变量的读 / 写访问权限
    3、对外部变量的读 / 写访问权限
    4、对声明为块变量的特殊变量的读 / 写访问权限
 */
void block_mrc_demo_01() {
    int j = 10;
    int (^blockPtr)(int) = ^(int n){ return j + n ;};
    int k = blockPtr(5);
    NSLog(@"k = %zd", k);
}

void block_mrc_demo_02() {
    int j = 10;
    int (^blockPtr)(int) = ^(int n){ return j + n ;};
    
    j = 20;
    
    int k = blockPtr(5);
    NSLog(@"k = %zd", k);
}

void block_mrc_demo_03() {
    static int demo_03 = 10;
    NSMutableArray *arrayM = @[@1, @2, @3, @4, @5].mutableCopy;
    void (^showrtenArray)(void) = ^(void){ demo_03 += 5; [arrayM removeLastObject]; };
    
    showrtenArray();
    NSLog(@"%@===%zd", arrayM, demo_03);
}

void block_mrc_demo_04() {
    static int demo_04 = 10;
    NSMutableArray *arrayM = @[@1, @2, @3, @4, @5].mutableCopy;
    void (^showrtenArray)(void) = ^(void){ demo_04 += 5; [arrayM removeLastObject]; };
    demo_04 += 5;
    [arrayM removeObjectAtIndex:0];
    
    showrtenArray();
    NSLog(@"%@", arrayM);
}

void block_mrc_demo_05() {
    int (^blockPtr)(int) = ^(int n){ mrc_argument += 5; return  mrc_argument + n ;};
    int k = blockPtr(5);
    NSLog(@"k = %zd", k);
}

void block_mrc_demo_06() {
    int (^blockPtr)(int) = ^(int n){ mrc_argument += 5; return  mrc_argument + n ;};
    mrc_argument += 5;
    
    int k = blockPtr(5);
    NSLog(@"k = %zd", k);
}

- (instancetype)init {
    if (self = [super init]) {
        block_mrc_demo_01();
        block_mrc_demo_02();
        
        block_mrc_demo_03();
        block_mrc_demo_04();
        
        block_mrc_demo_05();
        block_mrc_demo_06();
    }
    return self;
}



@end
