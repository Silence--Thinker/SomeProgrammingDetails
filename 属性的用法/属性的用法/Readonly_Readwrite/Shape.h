//
//  Shape.h
//  属性的用法
//
//  Created by Silent on 2017/5/3.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shape : NSObject {
    NSString *_color;
}

@property (nonatomic, copy, readonly) NSString *color;

@end
