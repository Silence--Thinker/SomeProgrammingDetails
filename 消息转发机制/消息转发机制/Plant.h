//
//  Plant.h
//  消息转发机制
//
//  Created by Silent on 2017/5/15.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Animal.h"

@interface Plant : NSObject
@property (nonatomic, strong) Person *person;

- (void)plantDemo;
@end
