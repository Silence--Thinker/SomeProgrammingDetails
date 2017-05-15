//
//  Person.m
//  消息转发机制
//
//  Created by Silent on 2017/5/15.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person {
    NSMutableDictionary *_propertyDictM;
}
@dynamic name;
@dynamic age;
@dynamic height;

- (instancetype)init {
    if (self = [super init]) {
        _propertyDictM = [NSMutableDictionary dictionary];
    }
    return self;
}

void autoDictionarySetter (id self, SEL _cmd, id value) {
    Person *person = (Person *)self;
    NSMutableDictionary *dictM = person->_propertyDictM;
    NSString *selectorString = NSStringFromSelector(_cmd);
    
    NSMutableString *key = selectorString.mutableCopy;
    // 去 :
    [key deleteCharactersInRange:NSMakeRange(key.length -1, 1)];
    // 去 set
    [key deleteCharactersInRange:NSMakeRange(0, 3)];
    // 去首字母大写
    NSString *firstChar = [[key substringToIndex:1] lowercaseString];
    [key replaceCharactersInRange:NSMakeRange(0, 1) withString:firstChar];
    
    if (value) {
        [dictM setObject:value forKey:key];
    }else {
        [dictM removeObjectForKey:key];
    }
}

id autoDictionaryGetter (id self, SEL _cmd) {
    Person *person = (Person *)self;
    NSMutableDictionary *dictM = person->_propertyDictM;
    NSString *selectorString = NSStringFromSelector(_cmd);
    
    return [dictM objectForKey:selectorString];
}

void autoPerson (id self, SEL _cmd, id name, unsigned int age) {
    Person *person = (Person *)self;
    person.name = name;
//    NSString *selectorString = NSStringFromSelector(_cmd);
//    person.age = age;
}

void autoPersonNoReturn (id self, SEL _cmd) {
    NSLog(@"%@==%@", self, NSStringFromSelector(_cmd));
}

id autoPersonInstance (id self, SEL _cmd) {
    Person *person = [[self alloc] init];
    return person;
}

+ (NSMutableDictionary *)getPropertyGetterSetterList {
    unsigned int count = 0;
    NSMutableDictionary *propertyDictM = [NSMutableDictionary dictionary];
    objc_property_t *list = class_copyPropertyList(self, &count);
    for (unsigned int i = 0; i < count; i ++) {
        const char * name = property_getName(*list);
        
        NSMutableString *getterString = [NSMutableString stringWithUTF8String:name];
        NSMutableString *setterString = getterString.mutableCopy;
        NSString *firstChar = [[getterString substringToIndex:1] uppercaseString];
         [setterString deleteCharactersInRange:NSMakeRange(0, 1)];
        setterString = [NSMutableString stringWithFormat:@"set%@%@:", firstChar, setterString];
        
        [propertyDictM setObject:@"1" forKey:setterString];
        [propertyDictM setObject:@"1" forKey:getterString];
        list++;
    }
    return propertyDictM;
}

+ (BOOL)resolveInstanceMethod:(SEL)selector {
    NSString *selectorString = NSStringFromSelector(selector);
    NSMutableDictionary *dictM = [self getPropertyGetterSetterList];
    Class class = [self class];
    
    BOOL resolve = NO;
    // 是否属于属性setter getter 方法缺失
    if ([dictM objectForKey:selectorString]) {
        if ([selectorString hasPrefix:@"set"]) {
            
            resolve = class_addMethod(class,
                                      selector,
                                      (IMP)autoDictionarySetter,
                                      "v@:@");
        }else {
            resolve = class_addMethod(class,
                                      selector,
                                      (IMP)autoDictionaryGetter,
                                      "@@:");
        }
    }
    else if ([selectorString hasPrefix:@"person"]){
        resolve = class_addMethod(class,
                                  selector,
                                  (IMP)autoPerson,
                                  "v@:@i");
    }
    else {
        resolve = [super resolveInstanceMethod:selector];
    }
    
    return resolve;
}

+ (BOOL)resolveClassMethod:(SEL)selector {
    NSString *selectorString = NSStringFromSelector(selector);
    Class class = object_getClass(self);
    
    BOOL resolve = NO;
    if ([selectorString hasPrefix:@"personIn"]) {
        resolve = class_addMethod(class,
                                  selector,
                                  (IMP)autoPersonInstance,
                                  "@@:");
    }
    else if([selectorString hasPrefix:@"personNo"]) {
        resolve = class_addMethod(class,
                                  selector,
                                  (IMP)autoPersonNoReturn,
                                  "v@:");
    }
    else {
        resolve = [super resolveClassMethod:selector];
    }
    return resolve;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"{\n  name = %@,\n  age = %zd,\n  height = %0.2f\n}", self.name, self.age, self.height];
}
@end
