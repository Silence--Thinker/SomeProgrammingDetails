//
//  Son.h
//  指定初始化器Demo
//
//  Created by Silent on 2017/4/6.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "Father.h"

@interface Son : Father

@property (nonatomic, strong) NSString *partner;

- (instancetype)initWithPartner:(NSString *)partner
NS_DESIGNATED_INITIALIZER ;
//__attribute__((objc_designated_initializer));

@end
