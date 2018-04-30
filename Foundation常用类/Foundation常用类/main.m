//
//  main.m
//  Foundation常用类
//
//  Created by Silence on 16/4/25.
//  Copyright © 2016年 ___SILENCE___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PrimeNumber.h"

    /* NSNumber         所有的基本数据类型都可以被封装成NSNumber
     * NSFileManager    文件管理类
     * NSProcessInfo    正在运行程序的进程信息
     * NSFileHandle     文件句柄，处理的文件的标记
    */
static void *dddd = &dddd;

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

// 获取目录下所有的文件 递归算法 方法完成
void getAllFiles(NSString *path, NSString *files) {
    NSFileManager *manager = [NSFileManager defaultManager];
//    NSString *newpath = @"/Users/Silence/Desktop/testTableView";
    NSError *error = nil;
    
    
    NSArray *array = [manager contentsOfDirectoryAtPath:path error:&error];
    for (NSString *pathEle in array) {
        BOOL isDirectory;
        BOOL result;
        NSString *path2 = [NSString stringWithFormat:@"%@/%@",path, pathEle];
        result = [manager fileExistsAtPath:path2 isDirectory:&isDirectory];
        if (isDirectory) {
            NSLog(@"    %@", pathEle);
            getAllFiles(path2, pathEle);
        }else {
            NSLog(@"    %@/%@",files, pathEle);
        }
    }
    
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
    
    // 改变当前目录
    path = [manager currentDirectoryPath];
    NSLog(@"current path = %@", path);
    result = [manager changeCurrentDirectoryPath:directory];
    if (result) {
        NSLog(@"目录改变成功");
    }else {
        NSLog(@"目录改变失败");
    }
    [manager createDirectoryAtPath:@"path" withIntermediateDirectories:YES attributes:nil error:&error];
}

// 枚举目录 苹果提供的子目录遍历，好强
void enumFileAtPath() {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *directoryE;
    NSString *newpath = @"/Users/Silence/Desktop/testTableView";
    NSString *path;
    NSError *error = nil;
    BOOL result;
    result = [manager changeCurrentDirectoryPath:newpath];
    if (result) {
        NSLog(@"改变当前文件目录成功");
    }else {
        NSLog(@"改变当前文件目录失败");
    }
    path = [manager currentDirectoryPath];
    directoryE = [manager enumeratorAtPath:path];
    NSLog(@"This is enumeratorAtPath function :");
    while ((path = [directoryE nextObject]) != nil) {
        NSLog(@"    %@", path);
    }
    
    NSArray *array = [manager contentsOfDirectoryAtPath:[manager currentDirectoryPath] error:&error];
    NSLog(@"This is array function : ");
    for (NSString *pathElem in array) {
        NSLog(@"    %@", pathElem);
    }
}

// 其他一些特定的文件目录 <Foundation/NSPathUtilities.h>
void otherFileFunction() {
    // 目录转化
    NSString *path = @"~Silence/Desktop/Working/../MyDemo/DownImage.zip";
    NSLog(@"before %@", path);
    path = [path stringByStandardizingPath];
    NSLog(@"after %@", path);
    
    // 获取文件的扩展名
    NSLog(@"Extension is = %@", [path pathExtension]);
    
    // 获取当前用户的登录名
    NSLog(@"当前用户的登录名：%@", NSUserName());
    
    // 获取当前用户的完整用户名
    NSLog(@"当前用户的完整用户名：%@", NSFullUserName());
    
    // 获取当前用户的主目录路径
    NSLog(@"当前用户的主目录路径：%@", NSHomeDirectory());
    
    // 获取用户user的主目录
    NSString *user = @"tt";
    NSLog(@"用户%@的主目录%@", user, NSHomeDirectoryForUser(user));
    
    // 获取可用于创建临时文件的路径目录
    NSLog(@"用于创建临时文件的路径目录：%@", NSTemporaryDirectory());
    
    path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSLog(@"%@", path);
}

// 程序的进程信息 NSProcessInfo
void getPrecessInfo() {
    // 获取当前进程的信息
    NSProcessInfo *processInfo = [NSProcessInfo processInfo];
    
    // 获取当前进程的参数
    NSArray *arguments = [processInfo arguments];
    NSLog(@"当前进程的参数：%@", arguments);
    
    // 获取当前的环境变量
    NSDictionary *environment = [processInfo environment];
    NSLog(@"当前的环境变量：%@", environment);
    
    // 获取操作系统赋予进程的唯一数字
    int identifier = [processInfo processIdentifier];
    NSLog(@"进程identifier：%d", identifier);
    
    // 获取进程名称
    NSString *processName = [processInfo processName];
    NSLog(@"进程名称：%@", processName);
    
    // 每次调用产生不同的单值字符，可以用来生成单值临时文件名
    NSString *globalStr = [processInfo globallyUniqueString];
    NSLog(@"单值字符：%@", globalStr);
    
    // 获取主机系统名称
    NSString *hostName = [processInfo hostName];
    NSLog(@"主机系统名称：%@", hostName);
    
    // 获取系统版本号String
    NSString *systemStr = [processInfo operatingSystemVersionString];
    NSLog(@"系统版本号String%@", systemStr);
    
    // 设置当前进程名称
    [processInfo setProcessName:@"This is a Foundation "];
    NSLog(@"进程名称：%@", [processInfo processName]);
    NSLog(@"当前进程的参数：%@", [processInfo environment]);
}

// 文件句柄  NSFileHandle
// 什么是句柄：一个句柄就是你给一个文件，设备，套接字(socket)或管道的一个名字, 以便帮助你记住你正处理的名字, 并隐藏某些缓存等的复杂性。
// 文件句柄 就是给一个文件添加标记，表示是正在处理的文件。
void fileHandleOperation() {
    
    // 将testA中的数据拼接到testB之后，在存到testC中。
    NSFileHandle *handleA = [NSFileHandle fileHandleForReadingAtPath:@"/Users/Silence/Desktop/testA.text"];
    NSFileHandle *handleB = [NSFileHandle fileHandleForReadingAtPath:@"/Users/Silence/Desktop/testB.text"];
    NSFileHandle *handleC = [NSFileHandle fileHandleForWritingAtPath:@"/Users/Silence/Desktop/testC.text"];
    
    NSData *data1 = [handleA readDataToEndOfFile];
    NSData *data2 = [handleB readDataToEndOfFile];
    
    [handleC seekToFileOffset:0];
    [handleC writeData:data1];
    [handleC writeData:data2];
    
    [handleA closeFile];
    [handleB closeFile];
    [handleC closeFile];
}

// __attribute__ 语法
void attributeGrammar() {
    
//    NSString *str = @"1234\a56"@"789";
//    NSLog(@"%@", str);
    
    [PrimeNumber primeNumberWithEndNumber:100];

    typedef struct __attribute__((objc_boxable)){
        CGFloat x, y, width, height;
    }XXRect;
    
    typedef struct __attribute__((objc_boxable)) {
        NSUInteger x;
        NSInteger y;
    }XXPath;
    
//    CGRect rect1 = {1, 2, 3, 4};
//    NSValue *value1 = @(rect1); //can't auto boxed
    
    XXPath path = {1, 2};
    NSValue *va = @(path);
    NSLog(@"%s", va.objCType);
    
    XXRect rect2 = {1, 2, 3, 4};
    NSValue *value2 = @(rect2);
    NSLog(@"%s", value2.objCType);
    
    NSDictionary *dict = @{@"key" : @(path)};
    NSValue *keyV = [dict objectForKey:@"key"];
    NSLog(@"%@", keyV);
    
    NSUInteger x = NSNotFound;
    if (x == NSNotFound) {
        NSLog(@"%zd", x);
    }
    
}

// __attribute__ enable_if
void printValueAge(int age) __attribute__((enable_if(age > 0 && age < 120, "火星人？"))){
    NSLog(@"%d", age);
}

int main(int argc, const char * argv[]) {
    NSLog(@"main begin");
    @autoreleasepool {
//        charByte();
//        getPrimeNumeber();
//        containsWithEqual()
//        getFileAttribtes();
//        creatFileAndDeleteFile();
//        enumFileAtPath();
//        getAllFiles(@"/Users/Silence/Desktop/testTableView", nil);
//        otherFileFunction();
//        getPrecessInfo();
//        fileHandleOperation();
        attributeGrammar();
//        printValueAge(110);
    }
    return 0;
}
