//
//  main.m
//  协议protocol
//
//  Created by Silent on 2017/5/3.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSObject+Protocol.h"
#import "Person.h"
#import "Father.h"
#import "Car.h"


/**
 * 1、对于协议中有属性的，而且属性是必须实现时，设置委托的类，有两种方法可以实现
     1. 在委托类中同样声明改属性。因为声明属性会生成 获取器 和 设置器
     2. 在委托类中重写属性的 获取器 和 设置器
注意:在协议中的属性，本质是生成 获取器 和 设置器 ，不会有生成实例变量的要求
 */
void protocol_demo() {
    Car *car = [Car new];
    
    Person *p = [Person new];
    p.delegate = car;
    p.delegate.carName = @"BMW";
    [p driving];
    [p informalProtocol];
    
    // 报错
//    [car informalProtocol];
    
//    Father *f = [Father new];
    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        protocol_demo();
    }
    return 0;
}
