//
//  Mother.m
//  DemoForVC
//
//  Created by Silence on 2017/2/24.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "Mother.h"

@implementation Mother

static Mother *_instance = nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [super allocWithZone:zone];
        });
    }
    return _instance;
}

- (instancetype)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

@end
