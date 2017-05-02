//
//  Person.m
//  隐藏实例变量
//
//  Created by Silent on 2017/5/2.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "Person.h"

@interface Person ()

@end
@implementation Person{
    // 默认的修饰词是 @private
@private
    NSString *instanceVariableOne;
    NSString *instanceVariableTwo;
    
    // 在.m 中的拓展或者实现中添加的实例变量都是 @private 即使写了@protected 也没有用
@protected
    NSString *name;
}

- (void)personFunction {
    name = @"person";
    instanceVariableOne = @"person one";
    instanceVariableTwo = @"person two";
}


- (NSString *)description {
    return [NSString stringWithFormat:@"\n name = %@\n one = %@\n two = %@", name, instanceVariableOne, instanceVariableTwo];
}
@end
