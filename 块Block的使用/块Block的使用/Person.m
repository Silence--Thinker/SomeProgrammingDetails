//
//  Person.m
//  块Block的使用
//
//  Created by Silence on 2017/5/29.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (instancetype)init {
    return [self initWithName:@"" age:0];
}

- (instancetype)initWithName:(NSString *)name age:(NSInteger)age {
    if (self = [super init]) {
        _name = name;
        _age = age;
    }
    return self;
}

- (NSString *)setName:(NSString *)name age:(NSInteger)age {
    _name = [name copy];
    _age = age;
    return [NSString stringWithFormat:@"name = %@ age = %zd", _name, _age];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"\n name = %@\n age = %zd", _name, _age];
}
@end
