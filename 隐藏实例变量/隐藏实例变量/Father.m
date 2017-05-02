//
//  Father.m
//  隐藏实例变量
//
//  Created by Silent on 2017/5/2.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "Father.h"

@interface Person ()
{
    // 这里如果不写 @protected 去改变实例变量的访问权限会报错
    // Instance variable 'name' is private
    // 提示实例变量是被保护的
    @protected
    NSString *instanceVariableOne;
    NSString *instanceVariableTwo;
    
    NSString *name;
}
@end

@implementation Father

- (void)fatherFuntion {
    name = @"father";
    instanceVariableOne = @"father one";
    instanceVariableTwo = @"father two";
}

- (NSString *)description {
    return [NSString stringWithFormat:@"\n name = %@\n one = %@\n two = %@", name, instanceVariableOne, instanceVariableTwo];
}

@end
