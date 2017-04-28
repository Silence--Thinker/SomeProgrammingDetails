//
//  main.m
//  NSArray的几种遍历方式
//
//  Created by Silent on 2017/4/28.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

NSMutableArray * arrayWithCount (int count) {
    NSMutableArray *arrayM = @[].mutableCopy;
    for (NSInteger i = 0 ; i < count; i++) {
        [arrayM addObject: [NSString stringWithFormat:@"%zd", i]];
    }
    return arrayM;
}
// 使用传统 for statement
void traversal_way_01 () {
    int count = 100;
    NSMutableArray *array = arrayWithCount(count);
    
    for (NSInteger i = 0; i < count; i ++) {
        NSString *value = array[i];
        printf("%s      ", [value UTF8String]);
    }
    printf("\n");
}

// 使用 NSEnumerator 遍历器遍历
void traversal_way_02 () {
    int count = 100;
    NSMutableArray *array = arrayWithCount(count);
    NSString *string;
    NSEnumerator *enumrator = [array objectEnumerator];
    while (string = [enumrator nextObject]) {
        
        printf("%s      ", [string UTF8String]);
    }
    printf("\n");
}

// 使用 enumer block 遍历
void traversal_way_03 () {
    int count = 100;
    NSMutableArray *array = arrayWithCount(count);
    
    [array enumerateObjectsUsingBlock:^(NSString *string, NSUInteger index, BOOL * _Nonnull stop) {
        printf("%s      ", [string UTF8String]);
    }];
    
    printf("\n");
}

// 使用 for in 遍历
void traversal_way_04 () {
    int count = 100;
    NSMutableArray *array = arrayWithCount(count);
    
    for (NSString *string in array) {
        printf("%s      ", [string UTF8String]);
    }
    
    printf("\n");
}

void myls (int argc, const char * argv[]) {
    BOOL isDirectory;
    
    NSMutableArray *pathsToList = [NSMutableArray arrayWithCapacity:20];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // argv[0] is the command name
    // Any others are directories or files to list
    
    if (argc == 1) { // Just command name so list the current directory
        [pathsToList addObject:[fileManager currentDirectoryPath]];
    } else {
        // covert input argument to NSString and
        // and them to the array
        int j ;
        for (j = 1; j < argc; j++) {
            [pathsToList addObject:[NSString stringWithUTF8String:argv[j]]];
        }
    }
    
    for (NSString *path in pathsToList) {
        if ([fileManager fileExistsAtPath:path isDirectory:&isDirectory]) {
            if (isDirectory) {
                
                NSArray *directoryContents = [fileManager contentsOfDirectoryAtPath:path error:nil];
                for (NSString *contentPath  in directoryContents) {
                    printf("%s \n", [contentPath UTF8String]);
                }
            }else {
                printf("%s \n", [path UTF8String]);
            }
        }else {
            printf("myls : %s: No such file or diretory \n", [path UTF8String]);
        }
    }
}

// demo
void demo_01 () {
    NSMutableArray *arrayM = [NSMutableArray arrayWithObjects:@"Lion", @"Tiger", @"Elephant", @"Duck", @"Rhinoceros", nil];
    NSMutableArray *tempM = arrayM.mutableCopy;
    for (NSString *string in tempM) {
        if (string.length > 5) {
            [arrayM removeObject:string];
        }
    }
    NSLog(@"%@", arrayM);
}

void demo_02 () {
    NSMutableArray *arrayM = [NSMutableArray arrayWithObjects:@"Lion", @"Tiger", @"Elephant", @"Duck", @"Rhinoceros", nil];
    @try {
        NSString *string = arrayM[8];
        NSLog(@"%@", string);
    } @catch (NSException *exception) {
        NSLog(@"%@===%@", [exception name], [exception reason]);
    } @finally {
        NSLog(@" exception finally");
    }
    NSLog(@"%@", arrayM);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        for (int j = 0; j < argc; j++) {
            printf("%s      \n", argv[j]);
        }
//        traversal_way_01 ();
//        traversal_way_02 ();
//        traversal_way_03 ();
//        traversal_way_04 ();
//        myls(argc, argv);
//        demo_01 ();
        demo_02 ();
    }
    return 0;
}
