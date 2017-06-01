//
//  main.m
//  块Block的使用
//
//  Created by Silent on 2017/5/17.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "Person.h"
#import "Woman.h"
#import "MRCBlock.h"
#import "ARCBlock.h"

// 排序 ascendingFlag =>> 是否是升序排列
NSInteger numericalSortFn(id obj1, id obj2, void * _Nullable ascendingFlag) {
    NSInteger value1 = [obj1 integerValue];
    NSInteger value2 = [obj2 integerValue];
    if (value1 == value2) {
        return NSOrderedSame;
    }
    if ( *(BOOL *)ascendingFlag) {
        return (value1 < value2) ? NSOrderedAscending : NSOrderedDescending;
        
    }else {
        return (value1 < value2) ? NSOrderedDescending : NSOrderedAscending;
    }
}

// 函数指针 用作回调 NSArray 排序demo
void functionPointer() {
    NSMutableArray *arrayM = [NSMutableArray array];
    arrayM = @[@(12), @(34), @(45), @(47), @(84), @(234), @(90), @(642), @(67)].mutableCopy;
    BOOL ascending = YES;
    
    NSInteger (* sortFunction)(id, id, void *);
    sortFunction = numericalSortFn;
    
    // =>>
//    [arrayM sortUsingFunction:numericalSortFn context:&ascending];
    [arrayM sortUsingFunction:*sortFunction context:&ascending];
    
    NSLog(@"%@", arrayM);
}

int function_01 (int argument) {
    return argument + 3;
}
typedef int(* function_pointer)(int a);

function_pointer function_03(function_pointer temp) {
    function_pointer t = function_01;
    int tempInt = temp(4);
    NSLog(@"%zd", tempInt);
    return t;
}
// 一个比较复杂的方法声明
void function_declaration () {
    // (* myFunctionPointer)(int (*)(int)) 是一个函数指针,他的返回值是一个int (* )(int) 这样的函数指针
    int (* (* myFunctionPointer)(int (*)(int))) (int);
    // ==>>
    function_pointer pointer1 = function_01;
    
    myFunctionPointer = function_03;
    function_pointer pointer2 = myFunctionPointer(pointer1);
    int result = pointer2(5);
    
    NSLog(@"%zd", result);
}



// NSInvocation 封装 回调
NSInvocation * invocation_callBack(const char * name, int age) {
    Person *person = [[Person alloc] initWithName:@"zhangsan" age:23];
    NSLog(@"%@==%p", person, person);
    
    NSMethodSignature *methodSignature = [person methodSignatureForSelector:@selector(setName:age:)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [invocation setTarget:person];
    [invocation setSelector:@selector(setName:age:)];
    
    // 如果不加这句话的话，person对象默认不会被NSInvocation对象保存起来， 在这个函数结束的时候
    // person对象就会被释放掉 导致 103行调用 invoke时 person 时出现野指针
    // Error : [Person setName:age:]: message sent to deallocated instance
    [invocation retainArguments];
    
    NSString *nameString = [NSString stringWithUTF8String:name];
    NSInteger ageVlaue = age;
    
    // objc 中消息的C 函数中第一个参数跟第二个参数是固定的 self 和 _cmd 具体看消息转发的函数实现
    [invocation setArgument:&nameString atIndex:2];
    [invocation setArgument:&ageVlaue atIndex:3];
    
    return invocation;
}

// NSInvocation 调用方式 以及 注意细节
void invocation_demo() {
    NSInvocation *invocation;
    @autoreleasepool {
        invocation = invocation_callBack("lisi", 26);
        [invocation invoke];
        NSLog(@"%@==%p", invocation.target, invocation.target);
        
        
        /*
         getReturnValue：仅仅是从invocation的返回值拷贝到指定的内存地址，如果返回值是一个NSObject对象的话，是没有处理起内存管理的。而我们在定义resultSet时使用的是__strong类型的指针对象，arc就会假设该内存块已被retain（实际没有），当resultSet出了定义域释放时，导致该crash。假如在定义之前有赋值的话，还会造成内存泄露的问题。
         解决办法：
         1、在接收对象前加__autoreleasing or __unsafe_unretained
         2、用void *指针来保存返回值，然后用__bridge来转化为OC对象
         */
        // [CFString release]: message sent to deallocated instance
        __autoreleasing NSString *returnValue;
        [invocation getReturnValue:&returnValue];
        NSLog(@"%@", returnValue);
        
        void *returnVa = NULL;
        [invocation getReturnValue:&returnVa];
        NSString *returnStr = (__bridge NSString *)returnVa;
        NSLog(@"%@", returnStr);
    }
}


// block 与 函数指针的对比
void block_different_functPoint () {
    Woman *m = [[Woman alloc] init];
    
    //    void (* point)(NSInteger value) = functionForPointer;
    [m functionWithFunctPointer:functionForPointer];
    
    [m functionWithBlockPointer:^(NSInteger value) {
        NSLog(@"%zd", value);
    }];
}


// block 字面量 =>> 块字面量
void block_literal() {
//    ^(argument_list){}; 块字面量的定义  没有名称，所以有时我们也叫匿名函数
//    ^(int n) {return  2 * n;};
    int j = ^(int n) { return 2 * n; }(9);
    NSLog(@"j = %zd", j);
}

// block 指针 =>> 块指针
void block_point() {
    // return_type (^name)(list of argument types); // block指针定义
    int (^doubler)(int a);
    doubler = ^(int a) {
        return 2 * a;
    };
    int j = doubler(3);
    NSLog(@"j = %zd", j);
}

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

// 块变量 使用__block修饰的变量
/*
 跟其他自动变量一样，块变量一开始是在栈上分配的。
 但是如果复制一个引用块变量的块，就会把块变量与块一起从栈上移到堆上
 */
void block_demo_02() {
    int j = 10;
    int (^blockPtr)(int) = ^(int n){ return j + n ;};
    int k = blockPtr(5);
    NSLog(@"k = %zd", k);
    
    __block int m = 10;
    int (^blockPtr2)(int) = ^(int n){
        m += 5;
        return m + n ;
    };
    int l = blockPtr2(5);
    NSLog(@"l = %zd", l);
}

void block_demo_03() {
    MRCBlock *mrcBlock = [MRCBlock new];
    NSLog(@"%@", mrcBlock);
}


int main(int argc, const char * argv[]) {
    
//    functionPointer();
//    invocation_demo();
//    function_declaration();
    
//    block_different_functPoint();
    
//    block_literal();
//    block_point();
//    block_demo_01();
    block_demo_02();
//    block_demo_03()
    
    return 0;
}
