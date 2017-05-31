//
//  main.m
//  块Block的使用
//
//  Created by Silent on 2017/5/17.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "Woman.h"

void block_demo_01() {
    void (^block)() = ^(){
        NSLog(@"this is a block");
    };
    
    NSLog(@"%s", object_getClassName(block));
    
    void (^block_b)();
    for (NSUInteger i = 0; i < 4; i ++) {
        if (i %2 == 0) {
            block_b = ^{
                NSLog(@"this is i == %zd block", i);
            };
        }else {
            block_b = ^{
                NSLog(@"this is i == %zd block", i);
            };
        }
        block_b();
        NSLog(@"%s", object_getClassName(block_b));
        NSLog(@"%@", block_b);
    }
    
    NSArray *array;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
    }];
}

void block_different_functPoint () {
    Woman *m = [[Woman alloc] init];

//    void (* point)(NSInteger value) = functionForPointer;
    [m functionWithFunctPointer:functionForPointer];
    
    [m functionWithBlockPointer:^(NSInteger value) {
        NSLog(@"%zd", value);
    }];
}
int main(int argc, const char * argv[]) {
//    block_demo_01();
    
    block_different_functPoint();
    return 0;
}
