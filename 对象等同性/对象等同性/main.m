//
//  main.m
//  对象等同性
//
//  Created by Silent on 2017/5/10.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

/**
 在NSSArray 和 NSSet 中要注意一点就是: 集合中的对象进行对比isEqual时候是先将，当前对象的hash值在 数组对象 中 的
 隐藏 hash表中查找相同的hash 值，如果没有找到，那两个对象肯定不相同，如果找到了，那么，再去从相同的hash 值中的 “数组”
 中查找是否有 isEqual 方法对比相同的，如果有，则相同，否则两个对象不同。
 
 对象的的 isEqual 等同性对比，遵循一个规则:
 1、如果两个对象 “相等”，那么他们的 hash 值一定 相等
 2、如果两个对象的 hash 值相等，那么他们不一定 “相等”
 */
void equal_Demo_01() {
    Person *p1 = [[Person alloc] init];
    p1.name = @" P1 ";
    p1.age = '1';
    p1.sex = @"男";
    
    Person *p2 = [[Person alloc] init];
    p2.name = @" P1 ";
    p2.age = '1';
    
    BOOL equal1 = [p1 isEqual:p2];
    NSLog(@"\np1 hash = %zd\n p2 hash = %zd", [p1 hash], [p2  hash]);
    NSLog(@"\np1 is equal to p2 %zd", equal1);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        equal_Demo_01();
    }
    return 0;
}
