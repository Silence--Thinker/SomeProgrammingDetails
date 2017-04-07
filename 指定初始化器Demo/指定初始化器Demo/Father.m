//
//  Father.m
//  指定初始化器Demo
//
//  Created by Silent on 2017/4/6.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "Father.h"

@implementation Father

- (instancetype)initWithName:(NSString *)name age:(NSUInteger)age {
    return [self initWithChildCount:1];
}

- (instancetype)initWithChildCount:(NSUInteger)childCount {
    if (self = [super initWithName:@"李四" age:30]) {
        _childCount = childCount;
    }
    return self;
}


@end
