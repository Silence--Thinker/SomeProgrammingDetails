//
//  Father.m
//  代理使用weak、copy、assign
//
//  Created by Silent on 2017/3/3.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "Father.h"

@implementation Father

- (void)delegateRun {
    if ([self.delegateAssign respondsToSelector:@selector(fatherHahaha)]) {
        [self.delegateAssign fatherHahaha];
    }
    
    if ([self.delegateCopy respondsToSelector:@selector(fatherHahaha)]) {
        [self.delegateCopy fatherHahaha];
    }
    
    if ([self.delegateWeak respondsToSelector:@selector(fatherHahaha)]) {
        [self.delegateWeak fatherHahaha];
    }
}
@end
