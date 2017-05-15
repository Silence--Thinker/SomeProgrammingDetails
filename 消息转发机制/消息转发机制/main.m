//
//  main.m
//  消息转发机制
//
//  Created by Silent on 2017/5/15.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Animal.h"
#import "Plant.h"

/** 对象方法，或者类方法缺失，动态添加 方法 */
void resolveInstanceMethod_demo_01() {
    Person *p = [Person personInstance];
    [Person personNoReturn];
    
    p.name = @"xjcao";
//    p.age = 26;
//    p.height = 171.0;
    
    [p personWith:@"caoxj" age:12];
    NSLog(@"%@", p);
}

/** 方法缺失，没有动态添加缺失方法，消息转给备用接受者 */
void forwardingTargetForSelector_demo_02() {
    Animal *animal = [Animal new];
    SEL selector = @selector(personWith:age:);
    [animal performSelector:selector withObject:@"caocaocao"];
    NSLog(@"%@", animal.person);
}

/** 方法缺失，没有动态添加缺失方法，消息没有备用接受者, 系统创建invocation 对象在此给你去修改东东
    如果 forwardInvocation:方法中仍然没有解决消息的转发，记得一定要调用[super forwardInvocation]
    好让消息传递到NSObject 层中，NSObject forwardInvocation 的实现就是简单的调用doesNotRecognizeSelector
 */

void forwardInvocation_demo_03() {
    Plant *plant = [Plant new];
    [plant plantDemo];
    SEL selector = @selector(personWith:age:);
    [plant performSelector:selector withObject:@"caocaocao"];
    
//    NSLog(@"%@", plant.person);
}
    

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        resolveInstanceMethod_demo_01();
//        forwardingTargetForSelector_demo_02();
        forwardInvocation_demo_03();
    }
    return 0;
}
