//
//  main.m
//  代理使用weak、copy、assign
//
//  Created by Silent on 2017/3/3.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Father.h"
#import "Mother.h"
#import "Son.h"

// 一般不会使用，会有野指针
// 特点: 赋值代理的对象销毁后，代理还能被调用，会崩溃。如果保证赋值代理永不销毁，便没有问题
void assignDelegate_demo() {
    // 第一种使用完全OK
    Father *f;
    Mother *m;
    
    f = [Father new];
    m = [Mother new];
    f.delegateAssign = m;
    [f delegateRun];
    
    // 在对象已经释放的情况下继续调用delegate方法 assign修饰会崩溃=>>野指针
    // 崩溃的可能性差不多30% 有时[f delegateRun]会有两次打印
    @autoreleasepool {
        m = nil;
    }
    [f delegateRun];
    
}

// 可以使用，但是不推荐使用，因为要为每一个delegate实现可copy操作
// 特点: 赋值代理的对象销毁后，代理还能被调用
void copyDelegate_demo() {
    // 使用copy修饰符
    // 1、代理对象必须是可以使用copy关键字的
    // 2、在对象销毁之后，调用代理方法仍然有回调，即代理对象被赋值的不是“m”本身而是[m copy]
    // 3、代理对象切换对象的时候，即重新赋值其他对象。
    Father *f;
    Mother *m;
    
    f = [Father new];
    m = [Mother new];
    f.delegateCopy = m;
    [f delegateRun];
    
    @autoreleasepool {
        m = nil;
    }
    [f delegateRun];
    
    Son *son = [Son new];
    f.delegateCopy = son;
    [f delegateRun];
}

// 推荐使用，
// 特点: 赋值代理的对象销毁后，代理便不再被调用
void weakDelegate_demo() {
    // 正确的使用delegate的修饰符，自始至终都不会出现两次[f delegateRun]两次打印
    Father *f;
    Mother *m;
    
    f = [Father new];
    m = [Mother new];
    f.delegateWeak = m;
    [f delegateRun];
    
    @autoreleasepool {
        m = nil;
    }
    [f delegateRun];
}

int main(int argc, const char * argv[]) {
//    assignDelegate_demo();
    
//    copyDelegate_demo();
    
    weakDelegate_demo();
    
    
    return 0;
}
