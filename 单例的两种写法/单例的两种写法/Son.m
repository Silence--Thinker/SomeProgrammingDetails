//
//  Son.m
//  单例的两种写法
//
//  Created by Silent on 2017/5/9.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "Son.h"

@implementation Son
static Son *_instance = nil;

#warning  这种单例的写法简直自欺欺人
+ (instancetype)shareSon {
    if (_instance == nil) {
        _instance = [[self alloc] init];
    }
    return _instance;
}

//+ (instancetype)allocWithZone:(struct _NSZone *)zone {
//    return [self shareSon];
//}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}
@end
