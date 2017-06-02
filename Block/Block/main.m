//
//  main.m
//  Block
//
//  Created by Silent on 2017/6/2.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

int main(int argc, const char * argv[]) {
    typedef int (^blk_t)(int);
    for (int rate = 0; rate < 10; ++rate) {
        blk_t blk = ^(int count){
            return rate * count;
        };
    }
//    NSLog(@"%s", object_getClassName(blk));

    return 0;
}
