//
//  Father.h
//  代理使用weak、copy、assign
//
//  Created by Silent on 2017/3/3.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FatherDelegate <NSObject>

@optional
- (void)fatherHahaha;

@end
@interface Father : NSObject

@property (assign, nonatomic) id<FatherDelegate> delegateAssign;

@property (copy, nonatomic) id<FatherDelegate> delegateCopy;

@property (weak, nonatomic) id<FatherDelegate> delegateWeak;

- (void)delegateRun;
@end
