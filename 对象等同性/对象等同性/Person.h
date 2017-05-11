//
//  Person.h
//  对象等同性
//
//  Created by Silent on 2017/5/10.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSUInteger age;

@property (nonatomic, copy) NSString *sex;

@end
