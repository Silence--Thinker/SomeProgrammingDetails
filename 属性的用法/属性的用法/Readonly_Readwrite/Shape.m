//
//  Shape.m
//  属性的用法
//
//  Created by Silent on 2017/5/3.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "Shape.h"

@implementation Shape
@synthesize color;

- (instancetype)init {
    if (self = [super init]) {
        color = @"blue";
    }
    return self;
}

@end
