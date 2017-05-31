//
//  Woman.m
//  块Block的使用
//
//  Created by Silent on 2017/5/31.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "Woman.h"

@implementation Woman

void functionForPointer (NSInteger value) {
    NSLog(@"%zd", value);
}

- (void)functionWithFunctPointer:(void (*)(NSInteger value))pointer {
    pointer(1000);
}

- (void)functionWithBlockPointer:(void (^)(NSInteger value))pointer {
    if (pointer) {
        pointer(100);
    }
}

@end
