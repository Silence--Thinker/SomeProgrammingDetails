//
//  main.m
//  runtime--metaClass
//
//  Created by Silence on 16/5/17.
//  Copyright © 2016年 ___SILENCE___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import <objc/runtime.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        //  1、对象的isa 指针指向对象的类
        //  2、NSObject(基类)的父类是为空(nil)
        //  3、每个类对象(就是类本身)的isa指针指向一个meta-Class类
        //  4、所有子类的meta-Class的isa指针指向NSObject(基类)的meta-Class
        //  5、所有子类的meta-Class的super_class指针，指向父类的meta-Class
        //  6、NSObject(基类)的meta-Class的super_class指针，指向NSObject(基类)本身
        //  *  NSObject(基类)的meta-Class类是NSObject(基类)的子类
    
        // 下面的例子感受一下
        // 图：http://ww2.sinaimg.cn/mw690/979e2950gw1f3yeu91hg1j20fa0fztan.jpg
        NSObject *obj = [NSObject new];
        Class objMetaClass = objc_getMetaClass(class_getName(obj.class));
        NSLog(@"obj.class = %p", obj.class);
        NSLog(@"obj.superclass = %p", obj.superclass);
        NSLog(@"objMetaClass = %p", objMetaClass);
        NSLog(@"objMetaClass.superclass = %p",class_getSuperclass(objMetaClass));
        NSLog(@"objMetaClass.class = %p", object_getClass([objMetaClass class]));
        NSLog(@"\n");
        
        Person *p = [Person new];
        Class pMetaClass = objc_getMetaClass(class_getName(p.class));
        NSLog(@"p.class = %p", p.class);
        NSLog(@"p.superclass = %p", p.superclass);
        NSLog(@"pMetaClass = %p", pMetaClass);
        NSLog(@"pMetaClass.superclass = %p",class_getSuperclass(pMetaClass));
        NSLog(@"pMetaClass.class = %p", object_getClass([pMetaClass class]));
        
    }
    return 0;
}
