//
//  main.m
//  __attribute__Cleanup使用
//
//  Created by Silence on 16/5/16.
//  Copyright © 2016年 ___SILENCE___. All rights reserved.
//

#import <Foundation/Foundation.h>
/*  __attribute__(cleanup(...)), 用于修饰一个 "变量" ，在它的作用域结束的时候可以自动执行一个
 *  指定的方法。
 *  注意：1、cleanup是先于对象的dealloc调用的 2、作用域内有若干个cleanup，调用顺序按 “先进后出” 栈序列
 *
*/
static void stringCleanUp(__strong NSString **string) {
    NSLog(@"%@", *string);
}

static void blockCleanUp(__strong void(^*block)(void)) {
    (*block)();
}

static void blockVarCleanUp(__strong void(^*block)(NSString *str)) {
    (*block)(@"string of var");
}

#define onExit \
__strong void(^block)(void) __attribute__((cleanup(blockCleanUp), unused)) = ^

#define whenExit(name) \
__strong void(^(name))(void) __attribute__((cleanup(blockCleanUp), unused)) = ^

int main(int argc, const char * argv[]) {
        
    __strong NSString *str __attribute__((cleanup(stringCleanUp), unused)) = @"stringCleanUp end";
    
    __strong void(^block2)(void) __attribute__((cleanup(blockCleanUp), unused)) = ^{
        NSLog(@"blockClenUp end");
    };
    __strong void(^block3)(NSString *str) __attribute__((cleanup(blockVarCleanUp), unused)) = ^(NSString *str){
        NSLog(@"%@", str);
        NSLog(@"blockVarCleanUp end");
    };
    
    
    NSRecursiveLock *alock = [NSRecursiveLock new];
    [alock lock];
    // 这里会定义一个block变量会和alock 的作用域相同，这样，当alock的作用域结束的时候调用【alock unclock】是最合适的
    // 这个做法真的是太明智了，无敌
    onExit {
        [alock unlock];
    };
    
    whenExit(tempBlock) {
        NSLog(@"tempBlock end");
    };
    
    NSLog(@"end");
    return 0;
}
