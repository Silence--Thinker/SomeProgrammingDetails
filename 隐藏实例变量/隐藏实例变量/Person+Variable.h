//
//  Person+Variable.h
//  隐藏实例变量
//
//  Created by Silent on 2017/5/2.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "Person.h"

@interface Person (Variable)

@property (nonatomic, copy) NSString *personName;

- (void)categoryFunction;

@end
