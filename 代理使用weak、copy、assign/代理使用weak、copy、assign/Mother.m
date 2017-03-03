//
//  Mother.m
//  代理使用weak、copy、assign
//
//  Created by Silent on 2017/3/3.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "Mother.h"

@implementation Mother

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (id)copyWithZone:(NSZone *)zone {
    Mother *copy = [[Mother alloc] init];
    copy.name = [_name copy];
    return copy;
}

- (void)fatherHahaha {
    NSLog(@"mother……delegate……");
}

@end
