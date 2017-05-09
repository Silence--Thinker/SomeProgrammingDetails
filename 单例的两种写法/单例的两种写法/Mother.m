//
//  Mother.m
//  单例的两种写法
//
//  Created by Silent on 2017/5/9.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "Mother.h"

@implementation Mother
static Mother *_instance = nil;

+ (instancetype)shareMother {
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_instance) {
            _instance = [super allocWithZone:zone];
#warning  初始化值这样写也是可行的
            _instance.name = @"223";
            _instance.age = 23;
        }
    });
    return _instance;
}

#warning  初始化值这样写也是可行的
//- (instancetype)init {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _instance = [super init];
//        _instance.name = @"223";
//        _instance.age = 23;
//    });
//    return _instance;
//}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"name = %@, age = %zd", _name, _age];
}
@end
