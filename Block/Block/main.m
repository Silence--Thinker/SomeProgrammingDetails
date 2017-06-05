//
//  main.m
//  Block
//
//  Created by Silent on 2017/6/2.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


typedef int(^Block_double)(int a);
Block_double block_d;
void block_demo(Block_double blk_) {
    block_d = blk_;
    NSLog(@"blk_ %@", [blk_ class]);
    NSLog(@"block_d %@", [block_d class]);
}

NSMutableArray *captureArray () {
    NSMutableArray *arrayM = [NSMutableArray array];
    __block int i = 10;
    NSString *stirng = [NSString stringWithFormat:@"12"];
    NSLog(@"i = %p", &i);
    NSLog(@"stirng = %p", stirng);
    [arrayM addObject:^(void){
        NSLog(@"i = %p", &i);
        NSLog(@"stirng = %p", stirng);
        NSLog(@"this ia block %zd", i++);
    }];
    return arrayM;
}

int main(int argc, const char * argv[]) {
//    int value = 3;       
//    Block_double blk = ^(int a) {
//        return a * value;
//    };
//    NSLog(@"%@", [blk class]);
    
//    block_demo(^(int a) {
//        NSLog(@"double %zd", a);
//        return a * value;
//    });
//    
//    block_d(3);
    
    
//    NSMutableArray *array = captureArray();
//    NSLog(@"%@", [array[0] class]);
//    ((void(^)(void))array[0])();
//    ((void(^)(void))array[0])();
//    ((void(^)(void))array[0])();
    
//    int (^tempBlock)(int a);
//    tempBlock = ^(int a){
//        return 2 * a;
//    };
    
//    int tempValue = tempBlock(3);
//    NSLog(@"%zd", tempValue);
    
    __block int j = 10;
    void (^blockPtr_1)() = ^(){ j += 15; NSLog(@"j = %zd", j);};
    blockPtr_1();
    
    return 0;
}
