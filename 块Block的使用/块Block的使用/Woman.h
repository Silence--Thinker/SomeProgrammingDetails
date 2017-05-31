//
//  Woman.h
//  块Block的使用
//
//  Created by Silent on 2017/5/31.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Woman : NSObject

void functionForPointer (NSInteger value);

- (void)functionWithFunctPointer:(void (*)(NSInteger value))pointer;

- (void)functionWithBlockPointer:(void (^)(NSInteger value))pointer;
@end
