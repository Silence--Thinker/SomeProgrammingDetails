//
//  Person.m
//  指定初始化器Demo
//
//  Created by Silent on 2017/4/5.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)init {
    return [self initWithName:@"张三" age:20];
}

- (instancetype)initWithName:(NSString *)name age:(NSUInteger)age {
    if (self = [super init]) {
        _name = name;
        _age = age;
    }
    return self;
}
@end
