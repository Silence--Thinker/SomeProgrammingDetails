//
//  Person.m
//  协议protocol
//
//  Created by Silent on 2017/5/3.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "Person.h"
#import "NSObject+Protocol.h"

@implementation Person

- (void)informalProtocol {
    NSLog(@"这就是一个非正式协议了？？");
}

- (void)driving {
    if ([self.delegate conformsToProtocol:@protocol(PersonDelegate)]) {
        [self.delegate driving];
    }
}

@end
