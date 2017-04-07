//
//  Father.h
//  指定初始化器Demo
//
//  Created by Silent on 2017/4/6.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "Person.h"

@interface Father : Person

@property (nonatomic, assign) NSUInteger childCount;

- (instancetype)initWithChildCount:(NSUInteger)childCount
__attribute__((objc_designated_initializer));

@end
