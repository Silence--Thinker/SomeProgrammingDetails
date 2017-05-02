//
//  main.m
//  隐藏实例变量
//
//  Created by Silent on 2017/5/2.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Father.h"
#import "Person+Variable.h"

/**
 *  有时候我们需要对外界隐藏一个类的实例变量，但是在自己用到的时候实例变量是开放的，或者某些特定的变量可以开放
 *  这个时候我们可以采取这样的方法
 *  1、将实例变量声明在类的.m中
 *      1.1、声明在@implementation中或者类拓展中
 *  2、在子类或者分类中可以声明这个类(person)的一个拓展，可以在拓展中修改原始类的(person)变量 访问权限
 *      2.1、在子类中变量的访问权限跟父类相同，默认是@private， 要加@protected
 *      2.2、在分类中，分类本来默认就是可以访问私有的变量的，即可以访问@private 修饰的变量 所以可以不加@proteced
 *      2.3、你也可以通过分类中定义 property 来开放实例变量的访问，只能在子类或者分类中添加 原始类的拓展
 *           千万不要讲声明写到子类的实现中，这样就会有两个同名的实例变量了。
 *           分类中这样写会有提示错误的
 */

/**  书本原文
 *  尽管在超类类文件中的原始类扩展中使用@protected 指令时它将不起作用，但是当在添加到子类文件的类拓展中使用它时，
 *  它将改变实例变量的原始@private 的可访问性。如果是在编写一个类别文件，则不需要@protected。类别可以直接访问
 *  @private 变量
 */

void variableHide_demo(){
    Person *person = [Person new];
    [person personFunction];
    NSLog(@"%@", person);
    
    [person categoryFunction];
    NSLog(@"%@", person);
    
    Father *father = [Father new];
    [father fatherFuntion];
    NSLog(@"%@", father);
    
    // 这个例子中，person 和 father 都是只有一个 name ，一个instanceVariableOne，一个instanceVariableTwo的
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        variableHide_demo();
    }
    return 0;
}
