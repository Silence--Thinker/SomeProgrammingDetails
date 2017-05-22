//
//  ViewController.m
//  iOS开发中几种锁机制
//
//  Created by Silent on 2017/5/22.
//  Copyright © 2017年 Silence. All rights reserved.
//

//#ifdef DEBUG
//#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
//#else
//#define NSLog(...)
//#endif

#import "ViewController.h"
#import <libkern/OSAtomic.h>
#import <pthread.h>
#import <os/lock.h>

@interface ViewController ()

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

void no_lock_demo () {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"first %@", [NSThread currentThread]);
        NSLog(@"first begin");
        NSLog(@"first 第二步");
        NSLog(@"first end");
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"second %@", [NSThread currentThread]);
        NSLog(@"second begin");
        NSLog(@"second 第二步");
        NSLog(@"second end");
    });
}

// 第一种锁:OSSpinLock 自选锁 苹果已经弃用，线程不安全
// #import <libkern/OSAtomic.h>
//os_unfair_lock_t unfairLock;
//unfairLock = &(OS_UNFAIR_LOCK_INIT);
//os_unfair_lock_lock(unfairLock);
//os_unfair_lock_unlock(unfairLock);
void osspinLock_demo() {
    os_unfair_lock_t unfairLock;
    unfairLock = &(OS_UNFAIR_LOCK_INIT);
    
//    OSSpinLock oslock = OS_SPINLOCK_INIT;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"first %@", [NSThread currentThread]);
        NSLog(@"first begin");
        
        if (os_unfair_lock_trylock(unfairLock) == YES) {
            
//        OSSpinLockLock(&oslock);
        
            sleep(4);
            NSLog(@"first 第二步");
            os_unfair_lock_unlock(unfairLock);
        }
//        OSSpinLockUnlock(&oslock);
        
        NSLog(@"first end");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"second %@", [NSThread currentThread]);
        NSLog(@"second begin");
        
        if (os_unfair_lock_trylock(unfairLock) == YES) {

//          OSSpinLockLock(&oslock);
        
            NSLog(@"second 第二步");
            os_unfair_lock_unlock(unfairLock);
//          OSSpinLockUnlock(&oslock);
        }
        NSLog(@"second end");
    });
}

// 第二种锁: dispatch_semaphore 信号量锁
// dispatch_semaphore_create(1) 传入值必须>=0,若传入为0，则阻塞线程并等待timeout，时间到后会执行其后的语句
// dispatch_semaphore_wait(signal, overTime); 可以理解为lock，会使signal值-1
// dispatch_semaphore_signal(signal); 可以理解为unlock，会使signal值+1
// dispatch_semaphore_create(1) 值为1的时候才能作为锁来用
void dispatch_semaphore_demo() {
    // 传入的值必须 >=0，若传入0则阻碍线程并等待timeout，时间到后会执行其后的语句
    dispatch_semaphore_t signal = dispatch_semaphore_create(1);
    dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"first %@", [NSThread currentThread]);
        NSLog(@"first begin");
        
        dispatch_semaphore_wait(signal, overTime); // signal 值 -1
        
        NSLog(@"first 第二步");
        dispatch_semaphore_signal(signal);  // signal 值 +1
        
        NSLog(@"first end");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"second %@", [NSThread currentThread]);
        NSLog(@"second begin");
        
        dispatch_semaphore_wait(signal, overTime);
        
        NSLog(@"second 第二步");
        dispatch_semaphore_signal(signal);
        
        NSLog(@"second end");
    });
    
/*  关于信号量，我们可以用停车来比喻：
    停车场剩余4个车位，那么即使同时来了四辆车也能停的下。如果此时来了五辆车，那么就有一辆需要等待。
    信号量的值（signal）就相当于剩余车位的数目，dispatch_semaphore_wait 函数就相当于来了一辆车，dispatch_semaphore_signal 就相当于走了一辆车。停车位的剩余数目在初始化的时候就已经指明了（dispatch_semaphore_create（long value）），调用一次 dispatch_semaphore_signal，剩余的车位就增加一个；调用一次dispatch_semaphore_wait 剩余车位就减少一个；当剩余车位为 0 时，再来车（即调用 dispatch_semaphore_wait）就只能等待。有可能同时有几辆车等待一个停车位。有些车主没有耐心，给自己设定了一段等待时间，这段时间内等不到停车位就走了，如果等到了就开进去停车。而有些车主就像把车停在这，所以就一直等下去。
 */
}

// 第三种锁: pthread_mutex 互斥所
// #import <pthread.h>
// pthread_mutex 中也有个pthread_mutex_trylock(&Lock)，可以加锁返回0
// 特点:不允许多次lock
// 加锁后只能有一个线程访问该对象，后面的线程需要排队，并且 lock 和 unlock 是对应出现的
void pthread_mutex_demo() {
    static pthread_mutex_t pLock;
    pthread_mutex_init(&pLock, NULL);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"first %@", [NSThread currentThread]);
        NSLog(@"first begin");
        
        pthread_mutex_lock(&pLock);         // 加锁
        
        sleep(3);
        NSLog(@"first 第二步");
        pthread_mutex_unlock(&pLock);       // 解锁
        
        NSLog(@"first end");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"second %@", [NSThread currentThread]);
        NSLog(@"second begin");
        
        pthread_mutex_lock(&pLock);
        
        NSLog(@"second 第二步");
        pthread_mutex_unlock(&pLock);
        
        NSLog(@"second end");
    });
}

// 第四种锁: pthread_mutex_recursive 递归锁
// pthread_mutex 中也有个pthread_mutex_trylock(&Lock)，可以加锁返回0
// 特点: 允许多次lock
// 加锁后只能有一个线程访问该对象，后面的线程需要排队，并且 lock 和 unlock 是对应出现的，
// 同一线程多次 lock 是不允许的，而递归锁允许同一个线程在未释放其拥有的锁时反复对该锁进行加锁操作。
void pthread_mutex_recursive_demo() {
    static pthread_mutex_t pLock;
    
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);      // 初始化attr并且给它赋默认值
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);  // 设置锁类型为:递归锁
    
    pthread_mutex_init(&pLock, &attr);
    pthread_mutexattr_destroy(&attr);   // 销毁销毁一个对象，在重新初始化之前该结构不能重新使用
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static void (^RecursiveBlock)(int);
        RecursiveBlock = ^(int value){
            pthread_mutex_lock(&pLock);
            
            if (value > 0) {
                NSLog(@"recursive value = %zd", value);
                RecursiveBlock(value - 1);
            }
            pthread_mutex_unlock(&pLock);
        };
        
        RecursiveBlock(5);
    });
    
    // 互斥锁。执行相同的代码 会死锁
    static pthread_mutex_t pLock_mutex;
    pthread_mutex_init(&pLock_mutex, NULL);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static void (^MutexBlock)(int);
        MutexBlock = ^(int value){
            pthread_mutex_lock(&pLock_mutex);
            
            if (value > 0) {
                NSLog(@"mutex value = %zd", value);
                MutexBlock(value - 1);
            }
            pthread_mutex_unlock(&pLock_mutex);
        };
        
        MutexBlock(5);
    });
}

// 第五种锁: NSLock 普通锁
// 遵守了<NSLocking> 协议的锁
// lockBeforeDate : 这个方法表示会在传入的时间内尝试加锁，若能够加锁则执行加锁操作并返回YES，反之返回NO
// tryLock : 可以加锁返回YES，并加锁，反之返回NO
void nslock_demo() {
    NSLock *lock = [[NSLock alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"first %@", [NSThread currentThread]);
        NSLog(@"first begin");
        
        [lock lock];
        sleep(3);
        NSLog(@"first 第二步");
        [lock unlock];
        
        NSLog(@"first end");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"second %@", [NSThread currentThread]);
        NSLog(@"second begin");
        
        BOOL canLock = [lock lockBeforeDate:[NSDate dateWithTimeIntervalSinceNow:4]];
        if (canLock) {
            NSLog(@"second 第二步");
            [lock unlock];
        }else {
            NSLog(@"second 不可以加锁");
        }
        
        NSLog(@"second end");
    });
}

// 第六种锁: NSCondition 普通锁
// 遵守了<NSLocking> 协议的锁
// wait : 进入等待状态
// waitUntilDate:(NSDate *)limit : 让一个线程等待一定的时间
// signal : 唤醒一个等待的线程
// broadcast : 唤醒所有等待的线程
void nsCondition_demo() {
    NSCondition *lock = [[NSCondition alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"first %@", [NSThread currentThread]);
        NSLog(@"first begin");
        
        [lock lock];
        
        NSLog(@"first 第二步");
        [lock wait];
        
        [lock unlock];

        NSLog(@"first end");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"second %@", [NSThread currentThread]);
        NSLog(@"second begin");
        
        [lock lock];
        
        NSLog(@"second 第二步");
        [lock wait];
        
        [lock unlock];
        
        NSLog(@"second end");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        sleep(2);
//        NSLog(@"解锁");
//        [lock signal];
//        
//        sleep(2);
//        NSLog(@"解锁");
//        [lock signal];
        
        sleep(2);
        NSLog(@"全部解锁");
        [lock broadcast];
    });
}

// 第七种锁: NSRecursiveLock 递归锁
// 遵守了<NSLocking> 协议的锁
// tryLock : 可以加锁返回YES，并加锁，反之返回NO
// lockBeforeDate : 这个方法表示会在传入的时间内尝试加锁，若能够加锁则执行加锁操作并返回YES，反之返回NO
void nsRecursivelock_demo() {
    
    NSRecursiveLock *lock = [[NSRecursiveLock alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static void (^RecursiveBlock)(int);
        RecursiveBlock = ^(int value){
            [lock lock];
            
            if (value > 0) {
                NSLog(@"recursive value = %zd", value);
                RecursiveBlock(value - 1);
            }
            [lock unlock];
        };
        RecursiveBlock(5);
    });
}

// 第八种锁: NSConditionLock 条件锁
// 遵守了<NSLocking> 协议的锁
void nsConditionLock_demo() {
    
    NSConditionLock *lock = [[NSConditionLock alloc] initWithCondition:0];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if ([lock tryLockWhenCondition:0]) {

            NSLog(@"first %@", [NSThread currentThread]);
            
            [lock unlockWithCondition:1];
        }else {
            NSLog(@"first 失败");
        }
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [lock lockWhenCondition:3];
        
        NSLog(@"second %@", [NSThread currentThread]);
        
        [lock unlockWithCondition:2];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [lock lockWhenCondition:1];
        NSLog(@"thrid %@", [NSThread currentThread]);
        
        [lock unlockWithCondition:3];
    });
    
/*  我们在初始化 NSConditionLock 对象时，给了他的标示为 0
    执行 tryLockWhenCondition:时，我们传入的条件标示也是 0,所 以线程1 加锁成功
    执行 unlockWithCondition:时，这时候会把condition由 0 修改为 1
    因为condition 修改为了 1， 会先走到 线程3，然后 线程3 又将 condition 修改为 3
    最后 走了 线程2 的流程
    从上面的结果我们可以发现，NSConditionLock 还可以实现任务之间的依赖。
*/
}

// 第九种锁: @Synchronized 条件锁
void synchronized_demo() {
    NSObject *object = [NSObject new];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized (object) {
            sleep(2);
            NSLog(@"first %@", [NSThread currentThread]);
        }
    });

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized (object) {
            NSLog(@"second %@", [NSThread currentThread]);
        }
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    no_lock_demo ();
    
    osspinLock_demo();
//    dispatch_semaphore_demo();
//    pthread_mutex_demo();
//    pthread_mutex_recursive_demo();
//    nslock_demo();
//    nsCondition_demo();
//    nsRecursivelock_demo();
    
//    nsConditionLock_demo();
//    synchronized_demo();
}
@end
