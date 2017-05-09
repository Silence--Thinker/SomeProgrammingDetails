//
//  Father.h
//  单例的两种写法
//
//  Created by Silent on 2017/5/9.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Father : NSObject <NSCopying>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSUInteger age;

+ (instancetype)shareFather;

@end
