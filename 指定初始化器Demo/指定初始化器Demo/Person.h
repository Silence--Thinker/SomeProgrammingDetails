//
//  Person.h
//  指定初始化器Demo
//
//  Created by Silent on 2017/4/5.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSUInteger age;

- (instancetype)initWithName:(NSString *)name age:(NSUInteger)age
__attribute__((objc_designated_initializer));
//NS_DESIGNATED_INITIALIZER


@end
