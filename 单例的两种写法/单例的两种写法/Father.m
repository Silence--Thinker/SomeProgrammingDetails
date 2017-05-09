//
//  Father.m
//  单例的两种写法
//
//  Created by Silent on 2017/5/9.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "Father.h"

@implementation Father

static Father *_instance = nil;

+ (instancetype)shareFather {
    if (!_instance) {
        _instance = [[super allocWithZone:NULL] init];
#warning 初始化在这里写就是可行的
        _instance.name = @"father";
        _instance.age = 53;
    }
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self shareFather];
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"name = %@, age = %zd", _name, _age];
}
@end
