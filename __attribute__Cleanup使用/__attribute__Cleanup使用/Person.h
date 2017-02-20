//
//  Person.h
//  __attribute__Cleanup使用
//
//  Created by Silence on 16/5/16.
//  Copyright © 2016年 ___SILENCE___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

- (void)personTTT
__attribute__((deprecated("This the function is deprecated")));

@end
