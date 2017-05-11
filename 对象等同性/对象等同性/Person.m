//
//  Person.m
//  对象等同性
//
//  Created by Silent on 2017/5/10.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "Person.h"

@implementation Person

- (BOOL)isEqual:(id)object {
    if ([self class] == [object class]) {
        return [self isEqualtoPerson:object];
    }else {
        return [super isEqual:object];
    }
    /*
    if (self == object) {
        return YES;
    }
    
    if ([self class] != [object class]) {
        return NO;
    }
    Person *otherPerson = (Person *)object;
    if (![_name isEqualToString:otherPerson.name]) {
        return NO;
    }
    if (_age != otherPerson.age) {
        return NO;
    }
    return YES;
     */
}

- (NSUInteger)hash {
    NSUInteger nameHash = [_name hash];
    NSUInteger ageHash = _age;
    return nameHash ^ ageHash;
}

- (BOOL)isEqualtoPerson:(Person *)otherPerson {
    if (self == otherPerson) {
        return YES;
    }
    
    if (![_name isEqualToString:otherPerson.name]) {
        return NO;
    }
    if (![_sex isEqualToString:otherPerson.sex]) {
        return NO;
    }
    if (_age != otherPerson.age) {
        return NO;
    }
    
    return YES;
}

@end
