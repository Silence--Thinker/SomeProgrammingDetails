//
//  Son.m
//  指定初始化器Demo
//
//  Created by Silent on 2017/4/6.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "Son.h"

@implementation Son

- (instancetype)initWithChildCount:(NSUInteger)childCount {
    return [self initWithPartner:@"jack"];
}

- (instancetype)initWithPartner:(NSString *)partner {
    if(self = [super initWithChildCount:0]) {
        _partner = partner;
    }
    return self;
}
@end
