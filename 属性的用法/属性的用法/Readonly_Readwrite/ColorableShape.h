//
//  ColorableShape.h
//  属性的用法
//
//  Created by Silent on 2017/5/3.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "Shape.h"

@interface ColorableShape : Shape

@property (nonatomic, copy, readwrite) NSString *color;

@property (nonatomic, copy, readonly) NSString *name;

@end
