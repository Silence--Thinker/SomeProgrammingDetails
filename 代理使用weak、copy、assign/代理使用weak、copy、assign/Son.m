//
//  Son.m
//  代理使用weak、copy、assign
//
//  Created by Silent on 2017/3/3.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "Son.h"

@implementation Son

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (id)copyWithZone:(NSZone *)zone {
    Son *copy = [[Son alloc] init];
    copy.name = [_name copy];
    return copy;
}

- (void)fatherHahaha {
    NSLog(@"Son……delegate……");
}

@end
