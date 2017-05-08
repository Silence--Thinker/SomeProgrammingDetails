//
//  Person.h
//  枚举NS_ENUM和NS_OPTIONS
//
//  Created by Silent on 2017/5/8.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 
 #if (__cplusplus && __cplusplus >= 201103L && (__has_extension(cxx_strong_enums) || __has_feature(objc_fixed_enum))) || (!__cplusplus && __has_feature(objc_fixed_enum))
 
    #define OBJC_ENUM(_type, _name) enum _name : _type _name; enum _name : _type
    #if (__cplusplus)
        #define OBJC_OPTIONS(_type, _name) _type _name; enum : _type
     #else
        #define OBJC_OPTIONS(_type, _name) enum _name : _type _name; enum _name : _type
    #endif
 #else
     #define OBJC_ENUM(_type, _name) _type _name; enum
     #define OBJC_OPTIONS(_type, _name) _type _name; enum
 #endif
 
 */


/**
 
 从上面的源代码可以看出来，apple对于枚举的定义分了好几种情况.
 第一个#if 表示是c++ 并且支持新的枚举特性(C++ 11标准出的新枚举特性:可以指定枚举数据为 C 基础类型)
 不支持枚举新特性，就直接使用老式语法定义
    如果支持枚举新特性的话，如果是C++语言的话 和 OC 的枚举定义不同，主要是因为，C++ 语法中对枚举类型的 
    按位或操作 之后的得到的类型是隐式的，即，必须显示转化为枚举类型。
 
所以，凡是需要以 按位或操作 来组合的枚举都应使用 NS_OPTIONS 定义。若是枚举不需要互相组合，则应使用 NS_ENUM 来定义。
 
 */

//OBJC_ENUM(<#_type#>, <#_name#>)

typedef enum ENUMType : NSInteger ENUMType;
enum ENUMType : NSInteger {
    ENUMTypeNone,
    ENUMTypeGood,
    ENUMTypeBad
};


// OBJC_ENUM (_type, _name) =>> NS_ENUM (_type, _name)
typedef NS_ENUM(NSInteger, PersonType) {
    PersonTypeNone,
    PersonTypeGood,
    PersonTypeBad
};

// OBJC_OPTIONS (_type, _name) =>> NS_OPTIONS (_type, _name)
typedef NS_OPTIONS(NSInteger, OccupationType) {
    OccupationTypeDoctor            = 1 << 0 ,
    OccupationTypeProgrammer        = 1 << 1 ,
    OccupationTypeAccountant        = 1 << 2
};

@interface Person : NSObject



@property (nonatomic, assign) PersonType type;

@property (nonatomic, assign) OccupationType occupation;
@property (nonatomic, assign) ENUMType enumType ;
@end
