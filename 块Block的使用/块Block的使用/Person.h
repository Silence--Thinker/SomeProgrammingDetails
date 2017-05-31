//
//  Person.h
//  块Block的使用
//
//  Created by Silence on 2017/5/29.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;

- (instancetype)initWithName:(NSString *)name age:(NSInteger)age
__attribute__((objc_designated_initializer));

- (NSString *)setName:(NSString *)name age:(NSInteger)age;
@end
