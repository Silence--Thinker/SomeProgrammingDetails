//
//  main.m
//  属性的用法
//
//  Created by Silent on 2017/5/3.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

// readonly readwrite
#import "Shape.h"
#import "ColorableShape.h"


/**
 在超类中声明一个属性用的是 readonly 在子类中，重新定义属性的 特性为 readwrite 时，由于ColorableShape 是
 继承Shape 的 需要用@dynamic销毁掉自己当前生成的获取器 否则会有警告
 #warning: waAuto property synthesis will not synthesize property 'color'; it will be 
 implemented by its superclass, use @dynamic to acknowledge intention
 */
void readonly_readwrite_demo() {
    Shape *shape = [Shape new];
    NSLog(@"%@", shape.color);
    
    ColorableShape *shapeM = [ColorableShape new];
    shapeM.color = @"yellow";
    NSLog(@"%@", shapeM.color);
    
    NSLog(@"%@", shapeM.name);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        readonly_readwrite_demo();
    }
    return 0;
}
