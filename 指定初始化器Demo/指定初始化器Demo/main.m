//
//  main.m
//  指定初始化器Demo
//
//  Created by Silent on 2017/4/5.
//  Copyright © 2017年 Silence. All rights reserved.
//

// http://www.cnblogs.com/smileEvday/p/designated_initializer.html

#import <Foundation/Foundation.h>

#import "Person.h"
#import "Father.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *person = [[Person alloc] init];
        NSLog(@"%@", person);
        
        
    }
    return 0;
}
