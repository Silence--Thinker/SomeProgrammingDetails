//
//  Plant.m
//  消息转发机制
//
//  Created by Silent on 2017/5/15.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "Plant.h"

@implementation Plant

- (instancetype)init {
    if (self = [super init]) {
        _person = [Person new];
    }
    return self;
}

- (void)plantLog {
    NSLog(@"%s", __func__);
}

/** 如果方法不是接受者本身的，即没有实现，需要生成方法签名  */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        signature = [_person methodSignatureForSelector:aSelector];
    }
    if (!signature) {
        signature = [[Animal new] methodSignatureForSelector:aSelector];
    }
    
    return signature;
}

/** 等到了这一步，可以直接修改调用者，也可以直接修改为其他的方法实现 */
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
    if ([_person respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:_person];
    }else {
        // 标准做法直接调用super
//        [super forwardInvocation:anInvocation];
        
        // 可以直接修改 方法的任何东西，参数个数，调用者等等。
        anInvocation.selector = @selector(plantLog);
        anInvocation.target = self;
        [anInvocation invoke];
    }
    
}

@end
