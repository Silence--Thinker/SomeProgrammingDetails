//
//  main.m
//  DemoForTest
//
//  Created by Silence on 2017/2/20.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Father.h"
#import <pthread.h>

// 面试题: http://blog.sunnyxx.com/2014/03/06/ios_exam_0_key/

void testFunction() {
    Father *father = [Father new];
    BOOL b1 = [father respondsToSelector:@selector(respondsToSelector:)];
    BOOL b2 = [Father respondsToSelector:@selector(respondsToSelector:)];
    NSLog(@"%d, %d", b1, b2);
}

void *pthread_test(void * data) {
    NSLog(@"==%@==", [NSThread currentThread]);
    
    return NULL;
}

// 多线程：第一套方案 =>> pthread
// 1、纯C语言框架编码，在类Unix操作系统（Unix、Linux、Mac OS X等）中，都使用Pthreads作为操作系统的线程
// 2、这是一套在很多操作系统上都通用的多线程API，所以移植性很强
// 3、需要手动处理线程的各个状态的转换即管理生命周期，比如，这段代码虽然创建了一个线程，但并没有销毁。
void testPthread_demo_01() {
    pthread_t thread;
    
    pthread_create(&thread, NULL, pthread_test, NULL);
    [NSThread sleepForTimeInterval:2.0];
}

// 多线程：第二套方案 =>> NSThread
// 1、这套方案是经过苹果封装后的，并且完全面向对象的
// 2、它的生命周期还是需要我们手动管理，所以这套方案也是偶尔用用
// 3、NSThread 用起来也挺简单的，因为它就那几种方法
// 4、只有在一些非常简单的场景才会用 NSThread, 毕竟它还不够智能，不能优雅地处理多线程中的其他高级概念
void testNSThread_demo_01() {
    NSLog(@"==%@==", [NSThread currentThread]);
    Father *father = [Father new];
    
    NSThread *thread = [[NSThread alloc] initWithTarget:father selector:@selector(fatherRun) object:nil];
    [thread start];
    [father performSelectorInBackground:@selector(fatherRun) withObject:nil];
    
    // 不休息的话主线出调用完毕，便不会去调用了
    [NSThread sleepForTimeInterval:2.0];
    
}

// 多线程：第三套方案 =>> GCD
// 1、是苹果为多核的并行运算提出的解决方案，所以会自动合理地利用更多的CPU内核（比如双核、四核）
// 2、最重要的是它会自动管理线程的生命周期（创建线程、调度任务、销毁线程），不需要我们管理，我们只需要告诉干什么就行
// 3、它使用的也是c语言

// 同步线程死锁 : 仅输出1然后死锁
// dispatch_sync 在主队列中加入block任务，block要等待主线程完成去执行，但是主线程又在等待dispatch_sync的返回，
// 所以陷入了相互等待的局面，进入了死锁。
void testGCD_demo_01() {
    NSLog(@"================1");
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"================2");
    });
    NSLog(@"================3");
}

// 异步线程执行 : 输出1和“阻塞主线程”顺序不一定  while和dispatch_sync中的main_queue进入了相互等待
// dispatch_sync 在主队列中加入了block任务，block要等到主线程空闲才能去执行，而主线程一直在while循环中所以死锁了
void testGCD_demo_02() {
    
    dispatch_async(dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{
        NSLog(@"================1");
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"================2");
        });
        NSLog(@"================3");
    });
    
    NSLog(@"=========阻塞主线程");
    while (1) {
        NSLog(@"================4");
    }
    NSLog(@"=======2===阻塞主线程");
}

// GCD队列组
void testGCD_demo_03() {
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_async(group, queue, ^{
        for (NSInteger i = 0; i < 3; i ++) {
            NSLog(@"group 01 ====%@", [NSThread currentThread]);
        }
        NSLog(@"group 01 完成====");
    });
    
    dispatch_group_async(group, dispatch_get_main_queue(), ^{
        for (NSInteger i = 0; i < 3; i ++) {
            NSLog(@"group 02 ====%@", [NSThread currentThread]);
        }
        NSLog(@"group 02 完成====");
    });
    
    dispatch_group_async(group, queue, ^{
        for (NSInteger i = 0; i < 3; i ++) {
            NSLog(@"group 03 ====%@", [NSThread currentThread]);
        }
        NSLog(@"group 03 完成====");
    });
    
    dispatch_group_async(group, queue, ^{
        for (NSInteger i = 0; i < 3; i ++) {
            NSLog(@"group 04 ====%@", [NSThread currentThread]);
        }
        NSLog(@"group 04 完成====");
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"group end 完成====%@", [NSThread currentThread]);
    });
    
    dispatch_barrier_async(queue, ^{
        for (NSInteger i = 0; i < 3; i ++) {
            NSLog(@"group queue ====%@", [NSThread currentThread]);
        }
    });
}

// 多线程：第四套方案 =>> NSOperation、NSOperationQueue
// NSOperation 是苹果公司对 GCD 的封装，完全面向对象
// NSOperation 和 NSOperationQueue 分别对应 GCD 的 任务 和 队列
// NSOperation 只是一个抽象类，所以不能封装任务。但它有 2 个子类用于封装任务。分别是：NSInvocationOperation 和 NSBlockOperation
// 创建一个 Operation 后，需要调用 start 方法来启动任务，它会 默认在 当前队列同步执行

// NSOperation 任务
void testNSOperation_demo_01() {
    // NSInvocationOperation 添加一个任务、执行
    Father *father = [Father new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:father selector:@selector(fatherRun) object:nil];
    [operation start];
    
    // NSBlockOperation 通过block初始化任务，通过addExecutionBlock添加任务、执行
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
       NSLog(@"==%@==", [NSThread currentThread]);
    }];
    [blockOperation addExecutionBlock:^{
       NSLog(@"addExecutionBlock==%@==", [NSThread currentThread]);
    }];
    
    // operation默认在 当前队列同步执行 addExecutionBlock是在主线程和其他线程并发执行的
    for (NSInteger i = 0; i < 5; i ++) {
        [blockOperation addExecutionBlock:^{
            NSLog(@"addExecutionBlock==%@==", [NSThread currentThread]);
        }];
    }
    [blockOperation start];
}

// NSOperationQueue 任务
// NSOperationQueue 只有两个队列。一个是主队列main队列、另一个是并行队列
// 不过NSOperationQueue可以当成串行队列用，maxConcurrentOperationCount 设置最大并发数，值为1是即为同步队列
// 任务添加到NSOperationQueue中，会自动执行start
void testNSOperation_demo_02() {
    //main queue
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    NSLog(@"==%@==", mainQueue);
    
    // other queue
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
       NSLog(@"operation1 task01 ==%@==", [NSThread currentThread]);
    }];
    // 有时先打印 task02 证明了,addExecutionBlock方法添加的任务是并行执行的
    for (NSInteger i = 0; i < 5; i ++) {
        [operation1 addExecutionBlock:^{
            NSLog(@"operation1 task02 ==%@==", [NSThread currentThread]);
        }];
    }
    [queue addOperation:operation1];
    sleep(3);// 调试用的
}

// NSOperation 任务依赖
void testNSOperation_demo_03() {
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"operation1 task01 ==%@==", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:1.0];
    }];
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"operation2 task01 ==%@==", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:1.0];
    }];

    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"operation3 task01 ==%@==", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:1.0];
    }];
    [operation3 addExecutionBlock:^{
        for (NSInteger i = 0; i < 3; i ++) {
        NSLog(@"operation3 task0%zd ==%@==", i+2, [NSThread currentThread]);
        [NSThread sleepForTimeInterval:1.0];
        }
    }];
    
    [operation2 addDependency:operation1];
    [operation3 addDependency:operation2];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperations:@[operation2, operation3, operation1] waitUntilFinished:NO];
    
    sleep(10);// 调试用的
}

int main(int argc, const char * argv[]) {
//    testFunction();
    
//    testPthread_demo_01();
    
//    testNSThread_demo_01();
    
//    testGCD_demo_01();
//    testGCD_demo_02();
//    testGCD_demo_03();
    
//    testNSOperation_demo_01();
//    testNSOperation_demo_02();
//    testNSOperation_demo_03();
    
    return 0;
}
