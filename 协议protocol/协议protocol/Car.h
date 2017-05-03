//
//  Car.h
//  协议protocol
//
//  Created by Silent on 2017/5/3.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface Car : NSObject <PersonDelegate>

//@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *carName;

@end
