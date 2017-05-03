//
//  ColorableShape.m
//  属性的用法
//
//  Created by Silent on 2017/5/3.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ColorableShape.h"

@interface ColorableShape ()

/**
 name 在内部是可以访问的。但是外部只读
 */
@property (nonatomic, copy, readwrite) NSString *name;

@end
@implementation ColorableShape
@dynamic color;
@synthesize name;

- (void)setColor:(NSString *)newColor {
    color = [newColor copy];
    name = [NSString stringWithFormat:@"name = %@", newColor];
}

@end
