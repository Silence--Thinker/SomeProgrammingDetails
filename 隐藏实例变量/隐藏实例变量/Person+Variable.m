//
//  Person+Variable.m
//  隐藏实例变量
//
//  Created by Silent on 2017/5/2.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "Person+Variable.h"

@interface Person ()
// 在分类中 声明一个拓展， 在拓展里可以
{
    NSString *instanceVariableOne;
    NSString *instanceVariableTwo;
    
    NSString *name;
}
@end

@implementation Person (Variable)
@dynamic personName;


- (void)setPersonName:(NSString *)personName {
    name = [personName copy];
}

- (NSString *)personName {
    return name;
}

- (void)categoryFunction {
    name = @"person Variable";
    instanceVariableOne = @"person Variable one";
    instanceVariableTwo = @"person Variable two";
}

@end
