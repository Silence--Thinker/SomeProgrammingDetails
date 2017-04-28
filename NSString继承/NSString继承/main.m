//
//  main.m
//  NSString继承
//
//  Created by Silent on 2017/4/21.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

void stringClass_Demo01 (){
    int i = 23423;
    
    NSString *string = @"12312";
    NSString *string1 = [NSString stringWithFormat:@"%zd", i];
    NSMutableString *string2 = [NSMutableString stringWithFormat:@"%zd", i];

    NSLog(@"%s", object_getClassName(string));  // __NSCFConstantString 类
    NSLog(@"%s", object_getClassName(string1)); // NSTaggedPointerString 类
    NSLog(@"%s", object_getClassName(string2)); // _NSCFString 类
    
    NSString *temp = string1;
    
    BOOL test1 = [temp isMemberOfClass:[NSString class]];
    BOOL test2 = [temp isMemberOfClass:[NSMutableString class]];
    
    BOOL test3 = [temp isKindOfClass:[NSString class]];
    BOOL test4 = [temp isKindOfClass:[NSMutableString class]];

    NSLog(@"test1==%zd test2==%zd", test1, test2);
    NSLog(@"test3==%zd test4==%zd", test3, test4);
}

void string_Demo02 () {
    {
        char *cString = "hello world";
        NSString *nsString = [NSString stringWithUTF8String:cString];
        NSLog(@"%s===%@", cString, nsString);
    }
    {
        NSString *nsString = @"hello world";
        char const *cString = [nsString UTF8String];
        NSLog(@"%s===%@", cString, nsString);
    }
}

void nsArray_Demo01 () {
    NSArray *array = @[@"Raspberry", @"Peach", @"Banana", @"Blackberry", @"Blueberry", @"aPple",@"Apple", @"apple"];
    // 指定比较器 进行比较
    // NSString caseInsensitiveCompare 不区分大小写比较
    // NSString localizedCompare 本地化 区分大小写比较
    // NSString localizedCaseInsensitiveCompare 本地化 不区分大小写比较(苹果推荐)
    NSArray *array2 = [array sortedArrayUsingSelector:@selector(localizedCompare:)];
    NSLog(@"%@", array2);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        stringClass_Demo01();
        string_Demo02();
        nsArray_Demo01();
    }
    return 0;
}
