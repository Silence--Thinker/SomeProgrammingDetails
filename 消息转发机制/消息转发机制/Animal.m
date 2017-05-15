//
//  Animal.m
//  消息转发机制
//
//  Created by Silent on 2017/5/15.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "Animal.h"

@implementation Animal 

- (instancetype)init {
    if (self = [super init]) {
        _person = [Person new];
    }
    return self;
}


- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSString *selectorString = NSStringFromSelector(aSelector);
    
    if ([selectorString hasPrefix:@"person"]) {
        return _person;
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (void)plantDemo {
    NSLog(@"%s", __func__);
}

@end
