//
//  Person.h
//  消息转发机制
//
//  Created by Silent on 2017/5/15.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSUInteger age;

@property (nonatomic, assign) CGFloat height;


- (void)personWith:(NSString *)name age:(NSUInteger)age;

+ (void)personNoReturn;
+ (instancetype)personInstance;
@end
