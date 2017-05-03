//
//  Person.h
//  协议protocol
//
//  Created by Silent on 2017/5/3.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PersonDelegate <NSObject>
@required
@property (nonatomic, copy) NSString *carName;
- (void)driving;

@optional

- (void)fix;

@end

@interface Person : NSObject

@property (nonatomic, weak) id<PersonDelegate> delegate;

- (void)driving;

@end
