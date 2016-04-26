//
//  main.m
//  Foundation常用类
//
//  Created by Silence on 16/4/25.
//  Copyright © 2016年 ___SILENCE___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PrimeNumber.h"


// NSNumber 所有的基本数据类型都可以被封装成NSNumber

// char unichar 字节数
void charByte(){
    char t = 's';       // 1个字节
    unichar s  = 's';   // 2个字节
    printf("%li===%li\n", sizeof(t), sizeof(s));
}

// 获取素数算法
void getPrimeNumeber() {
    NSArray *array = [PrimeNumber primeNumberWithEndNumber:100];
    NSLog(@"%@", array);
}

// 数组中是否包含某个对象，比较 isEquals:
void containsWithEqual() {
    NSMutableArray *arrayM = @[].mutableCopy;
    PrimeNumber *p = [PrimeNumber new];
    p.name = @"jack";
    
    PrimeNumber *p1 = [PrimeNumber new];
    p1.name = @"nick";
    [arrayM addObject:p];
    [arrayM addObject:p1];
    
    PrimeNumber *p2 = [PrimeNumber new];
    p2.name = @"jack";
    
    BOOL contain = [arrayM containsObject:p2];// 内部使用isEqual:逐个比较
    NSLog(@"%i", contain);
}

// 获取目录下所有的文件
void getAllFiles() {
    
}

// 获取文件属性
void getFileAttribtes() {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSDictionary *dict;
    //        dict = [manager attributesOfFileSystemForPath:@"/Users/Silence/Desktop/11.png" error:&error];
    dict = [manager attributesOfItemAtPath:@"/Users/Silence/Desktop/工作缓存.rtf" error:&error];
    
    if (!dict) {
        NSLog(@"error == %@", error);
    }else {
        NSLog(@"dict === %@", dict);
    }
}

// 创建、删除文件
void creatFileAndDeleteFile() {
    NSFileManager *manager = [NSFileManager defaultManager];
    
    // 创建文件
    NSString *str = @"this is a test data!!";
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSString *path = @"/Users/Silence/Desktop/1111.text";
    NSString *path2 = @"/Users/Silence/Desktop/2222.text";
    BOOL result, exist;
    exist = [manager fileExistsAtPath:path];
    if (exist) {
        NSLog(@"文件已经存在了");
    }else {
        [manager createFileAtPath:path2 contents:data attributes:nil];
        result = [manager createFileAtPath:path contents:data attributes:nil];
        if (result == NO)
            NSLog(@"创建文件失败");
        else
            NSLog(@"文件创建成功");
    }
    
    // 创建目录
    NSString *directory = @"/Users/Silence/Desktop/My Like";
    NSError *error = nil;
    exist = [manager fileExistsAtPath:directory];
    if (exist) {
        NSLog(@"文件夹已经存在");
    }else {
        result = [manager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:&error];
        if (result) {
            NSLog(@"文件夹创建成功");
        }else {
            NSLog(@"error = %@", error);
            NSLog(@"文件夹创建失败");
        }
    }
    
    // 删除文件
    exist = [manager fileExistsAtPath:path2];
    if (exist) {
        NSLog(@"文件存在");
        result = [manager removeItemAtPath:path2 error:&error];
        if (result) {
            NSLog(@"文件删除成功");
        }else {
            NSLog(@"error === %@", error);
            NSLog(@"文件删除失败");
        }
    }else {
        NSLog(@"要删除的文件不存在");
    }
    
    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        charByte();
//        getPrimeNumeber();
//        containsWithEqual()
//        getFileAttribtes();
        creatFileAndDeleteFile();
        
        
        
    }
    return 0;
}
