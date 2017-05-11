//
//  main.m
//  NSString继承
//
//  Created by Silent on 2017/4/21.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

/**
 NSString 类族默认alloc创建的是一个 常量String类(即__NSCFConstantString)
 当我们赋值给不同的sring 时，类族会在内部 重新 给我们分配为其他子类
 
 NSString                   // NSString 抽象类
 NSMutableString            // NSMutableString 抽象类
 __NSCFConstantString       // 字符常量子类
 NSTaggedPointerString      // format 等创建的子类 用处应该最多(自认为)
 __NSCFString               // NSMutableString 的抽象子类，NSMutableString 默认创建它
 
 */


/**
 NSSArray 类族默认alloc创建的是一个 占位子类(即__NSArray0)
 当我们赋值给不同的array 时，类族会在内部 重新 给我们分配为其他子类
 
 NSArray                   // NSArray 抽象类
 NSMutableArray            // NSMutableArray 抽象类
 __NSArray0                // NSArray 占位子类，NSArray alloc 默认创建它
 __NSArrayI                // format 字面量创建的子类 用处应该最多(自认为)
 __NSArrayM                // NSMutableArray 的抽象子类，NSMutableArray 默认创建它
 
 */

/** NSString 类族问题 */
void stringClass_Demo01 (){
    
    NSLog(@"%s", object_getClassName([NSString class]));        // NSString 类
    NSLog(@"%s", object_getClassName([NSMutableString class])); // NSMutableString 类
    int i = 23423;
    
    NSString *str = [[NSString alloc] init];    // =>> [NSString string]
    NSLog(@"%s", object_getClassName(str));     // __NSCFConstantString
    str = [NSString stringWithFormat:@"99999"];
    NSLog(@"%s", object_getClassName(str));     // NSTaggedPointerString
    str = [NSMutableString stringWithFormat:@"8888"];
    NSLog(@"%s", object_getClassName(str));     // __NSCFString
    
    NSMutableString *strM = [[NSMutableString alloc] init]; // =>> [NSMutableString string]
    NSLog(@"%s", object_getClassName(strM));                 // __NSCFString
    strM = [NSMutableString stringWithFormat:@"99999"];
    NSLog(@"%s", object_getClassName(strM));                 // __NSCFString
    strM = [NSMutableString stringWithFormat:@"8888"];
    NSLog(@"%s", object_getClassName(strM));                 // __NSCFString
    
    
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

    NSLog(@"test1==%zd test2==%zd", test1, test2); //  test1==0 test2==0
    NSLog(@"test3==%zd test4==%zd", test3, test4); //  test3==1 test4==0
}

/** NSSArray 类族的问题 */
void nsarray_class_Demo() {
    
    NSLog(@"%s", object_getClassName([NSArray class]));         // NSArray 类
    NSLog(@"%s", object_getClassName([NSMutableArray class]));  // NSMutableArray 类
    
    NSArray *array = [[NSArray alloc] init];    // =>> [NSArray array]
    NSLog(@"%s", object_getClassName(array));   // __NSArray0 类
    array = @[@"1", @"2"];
    NSLog(@"%s", object_getClassName(array));   // __NSArrayI 类
    array = [NSMutableArray arrayWithObjects:@"1", @"2", nil];
    NSLog(@"%s", object_getClassName(array));   // __NSArrayM 类
    
    
    NSMutableArray *arrayM = [[NSMutableArray alloc] init]; // =>> [NSMutableArray array]
    NSLog(@"%s", object_getClassName(arrayM));              // __NSArrayM 类
    arrayM = @[@"1", @"2"].mutableCopy;
    NSLog(@"%s", object_getClassName(arrayM));              // __NSArrayM 类
    arrayM = [NSMutableArray arrayWithObjects:@"1", @"2", nil];
    NSLog(@"%s", object_getClassName(arrayM));              // __NSArrayM 类
    
    
    
    NSArray *array1 = @[@"1", @"2"];
    NSArray *array2 = [NSArray arrayWithObjects:@"1", @"2", nil];
    NSMutableArray *array3 = [NSMutableArray arrayWithObjects:@"1", @"2", nil];
    
    NSLog(@"%s", object_getClassName(array1));  //  __NSArrayI类
    NSLog(@"%s", object_getClassName(array2));  //  __NSArrayI类
    NSLog(@"%s", object_getClassName(array3));  //  __NSArrayM类
    
    
    NSArray *tempArray = @[@"1", @"2"];         //  __NSArrayI类
    
    BOOL test1 = [tempArray isMemberOfClass:[NSArray class]];
    BOOL test2 = [tempArray isMemberOfClass:[NSMutableArray class]];
    
    BOOL test3 = [tempArray isKindOfClass:[NSArray class]];
    BOOL test4 = [tempArray isKindOfClass:[NSMutableArray class]];
    
    NSLog(@"test1==%zd test2==%zd", test1, test2); //  test1==0 test2==0
    NSLog(@"test3==%zd test4==%zd", test3, test4); //  test3==1 test4==0
}

/** C字符串与OC字符串互转 */
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
//        stringClass_Demo01();
//        string_Demo02();
//        nsArray_Demo01();
        
//        nsarray_class_Demo();
    }
    return 0;
}
