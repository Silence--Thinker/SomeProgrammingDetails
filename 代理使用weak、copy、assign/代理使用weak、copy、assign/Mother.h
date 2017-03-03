//
//  Mother.h
//  代理使用weak、copy、assign
//
//  Created by Silent on 2017/3/3.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Father.h"

@interface Mother : NSObject <FatherDelegate, NSCopying>

@property (copy, nonatomic) NSString *name;

@end
