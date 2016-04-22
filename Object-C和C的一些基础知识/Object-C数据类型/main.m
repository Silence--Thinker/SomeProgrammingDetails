//
//  main.m
//  Object-C数据类型
//
//  Created by Silence on 16/4/14.
//  Copyright © 2016年 ___SILENCE___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import <objc/runtime.h>


#define IS_LEAP_YEAR(year)      (year) % 4 == 0 && (year) % 100 != 0 || (year) % 400 == 0
#define DAY_OF_FEBRUARY(year)   IS_LEAP_YEAR(year) ? @"29天" : @"28天"

#define kStringTest(str)        #str
#define kString(str)            printf(#str "\n")
#define kPrintlnt(var)          printf(#var " = %i \n", var)

#define kPrintx(n)              printf(" %i \n", var ## n)
#define kPrintlntx(n)           kPrintlnt(var ## n)

#define kSystemTag              1
// 求最大公约数
int getGcdNum(int u , int v) {
    
    while (v != 0) {
        int temp = u % v;
        u = v;
        v = temp;
    }
    return u;
}

// 枚举的定义
void enumDefine() {
    enum month {January , February, Marth, April, May, July};
    enum month m = July;
    if (m == January) {
        NSLog(@"一月");
    }
    
    enum {Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday} week;
    if (week == Monday) {
        NSLog(@"星期一");
    }
    
    // typedef 作用:为一个数据类型定义别名
    typedef enum {Rat, Ox, Tiger, Hare, Dragon, Snake, Horse, Sheep, Monkey, Cock, Dog, Boar} Zodiac;
    
    typedef enum month Caoxiujin;
    Caoxiujin haha;
    haha = January;
    
    Zodiac dog = Dog;
    if (dog == Rat) {
        NSLog(@"这是个老鼠");
    }
    
    
    typedef enum : NSUInteger {
        AA,
        AB,
        AC,
    } A;
    
    enum : NSUInteger {ss, kkk}sss;
    if (sss == ss) {
        NSLog(@"我勒个去");
    }
    unsigned int i = (unsigned int)-129;
    
    NSLog(@"%i", i);
}

// 闰年 宏定义, 带参数的宏定义
void leapYear() {
    if (IS_LEAP_YEAR(2122)) {
        NSLog(@"是闰年");
    }else {
        NSLog(@"不是闰年");
    }
    int year = 2340;
    NSLog(@"%i年二月 %@", year, DAY_OF_FEBRUARY(year));
}

// 宏定义中的 #运算符(c字符串转换) ##运算符(标记链接符号)
void stringTest() {
    // #define 宏定义的值其实没有类型等之分，之后做了字符串替换
    
    printf(kStringTest(我就是我不一样的烟火\n));
    printf(kStringTest("我就是我不一样的烟火\n"\n));
    
    int var = 100;
    kPrintlnt(var);// =>> printf("100" " = %i \n", var)
//    printf("100" " = %i \n", var);
    
    int var1 = 199;
    int var2 = 299;
    int var3 = 499;
    kPrintx(1);// 199
    kPrintx(2);// 299
    kPrintx(3);// 499
    
    kPrintlntx(1);
    kPrintlntx(2);
    kPrintlntx(3);
}

// 自定义预处理宏 #ifdef、#endif、#else、#ifndef、#if、#undef
void ifDefineOrNdefine() {
    
#warning 提示
// #undef name 将已经定义的宏取消定义
    
//#undef kSystemTag
//#undef DEBUG
//#undef THIS_IS_MY
    
#ifdef kSystemTag
    kString(已经定义 kSystemTag);
    kPrintlnt(kSystemTag);
#else
    kString(没有定义 kSystemTag);
#endif
    
    
#ifndef kSystemTag
    kString(没有定义 kSystemTag);
#else
    kString(已经定义 kSystemTag);
    kPrintlnt(kSystemTag);
#endif

    
#ifdef DEBUG
    kString(是DEBUG模式);
#endif
    
    
// 这里设置了预处理宏的值在 debug 下等于200 release 下等于 300 不设置值，默认都是1
// 设置位置 Apple LLVM 7.1 - Preprocessing -->> Preprocessor Macros（预处理宏）
#ifdef THIS_IS_MY
    kString(我自己定义了 THIS_IS_MY 预处理宏);
    kPrintlnt(THIS_IS_MY);
#else
    kString(我没有定义 THIS_IS_MY 预处理宏);
#endif

// #if
#ifdef DEBUG
    kString(是DEBUG模式);
#else
    kString(是RELEASE模式);
#endif
    
// 上面的定义等价于 不同点:defined 过去时 宏要加括号()
#if defined (DEBUG)
    kString(是#if DEBUG模式);
#else
    kString(是RELEASE模式);
#endif
    
}

// struct 结构体的基本 定义 和 使用
void structDefine() {
#define kPrintDateDetail(x, y, z)        printf(#x" = %i, " #y" = %i, " #z" = %i \n", x, y, z)
#define kPrintDate(date)                 kPrintDateDetail(date.year, date.month, date.day)
#define kPrintTime(time)                 kPrintDateDetail(time.hour, time.minutes, time.seconds)
    
    // 定义方式 一 显示定义，有名称
    struct date {
        int year;
        int month;
        int day;
    } otherDay,oneDay = {.month = 12, .day = 30, .year = 2015};
    struct date today = {2016, 4, 22};
    
    kPrintDate(today);
    kPrintDate(oneDay);
    kPrintDate(otherDay);
    printf("\n");
    
    // 定义方式 二 显示定义，无名称
    struct  {
        int year;
        int month;
        int day;
    }someDay, twoDay = {.day = 20, .year = 2016, .month = 4}, three = {2013, 3 ,23};
    kPrintDate(someDay);
    kPrintDate(twoDay);
    kPrintDate(three);
    printf("\n");
    
    // 常见使用 一 嵌套定义 结合 typedef 使用
    struct time {
        int hour;
        int minutes;
        int seconds;
    };
    
    struct date_and_time {
        struct date date;
        struct time time;
    };
    typedef struct date_and_time whatTime;
    
    whatTime time = {2014, 07, 01, 12, 0, 0};
    kPrintDate(time.date);
    kPrintTime(time.time);
    printf("\n");
    
    struct date_and_time time2 = {{2014, 05, 29}, {11, 40, 0}};
    kPrintDate(time2.date);
    kPrintTime(time2.time);
    printf("\n");
    
    // 常见使用 二 结构体数组
    struct time anytime[100];
    whatTime whatthing[50];
    
    kPrintTime(anytime[20]);
    kPrintDate(whatthing[1].date);
    kPrintTime(whatthing[1].time);
    printf("\n");
}

// 重头戏 指针的基本 定义 与 使用
void pointerDefineAndUse() {
#define kCharacterP(char)       printf(#char " = %c\n", char)
#define kAddress(x)             printf(#x " = %p\n", x)
    
    // 指针 的定义   typeName *variableName;
    // 指针 的使用   typeName variable2Name; variableName = &variable2Name;
    char character = 'd';
    char *pointerChar = &character;
//    int num = 88;
//    pointerChar = &num;
    // char 类型说明在变量pointerChar所表示的地址下，*pointerChar的值是char类型的，
    // 如果不是例如：给pointerChar赋值了&num那么pointerChar输出时会将nun强转成char类型
    
    kCharacterP(character);
    kAddress(pointerChar);
    kCharacterP(*pointerChar);
    
    
    // Q：指针 是什么？
    // 1、指针是内存中一块具体数据的内存地址。
    // 2、指针的取值是一种间接寻址的方式，本身的值没有用处，而通过值的值确定想要的值是指针最大的特点。
    
    // Q：指针 的本质是什么？
    // 1、指针的本质是一块内存地址。
    // 2、内存地址本身不具有任何意义，然而内存地址处存储的数据是有意义的。
    
    // Q：指针 可以做什么？
    // 1、可以为一个变量var标记一个指针，通过指针的*运算可以得知该地址下的数据
    // 2、指针变量可以得到该变量var任何时候的数据（最新值）
    // 3、指针变量同时可以修改变量var的数据
    // 4、指针的应用非常的灵活（绝非吹比）
    
    // Q：指针 是如何进行赋值 和 取值的？
    // 1、赋值：指针的赋值运算是通过&符号，&运算符可以得到任何基本数据类型的地址
    // 2、取值：指针的取值运算时通过*符号，*运算符可以取出指针代表的地址存储的数据
    
    // Q：指针 是一种特殊的数据类型吗？
    // 1、指针不是一种数据类型
    // 2、指针可以说是一种运算符，地址运算符
}

// 指针 与 结构体的结合使用
void structPointer() {
    struct date {
        int year;
        int month;
        int day;
    };
    struct date today, *nextday;
    nextday = &today;
    (* nextday).year = 2016;// 括号是必须的，因为访问数据的点运算(.)优先级比*运算符高
    nextday -> month = 04;
    nextday -> day = 22;
    kPrintDate(today);
    
    // 插曲
    int x = 10, y = 20;
    x = x + y;
    y = x - y;
    x = x - y;
    kPrintlnt(x);
    kPrintlnt(y);
}

// 指针 与 数组、字符串的结合使用
void arrayPointer() {

}

// 函数指针的使用
void functionPointer() {}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        enumDefine();
//        leapYear();
//        stringTest();
//        ifDefineOrNdefine();
//        structDefine();
//        pointerDefineAndUse();
        structPointer();
    }
    return 0;
}
