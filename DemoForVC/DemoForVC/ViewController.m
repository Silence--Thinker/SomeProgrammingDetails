//
//  ViewController.m
//  DemoForVC
//
//  Created by Silence on 2017/2/20.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import <objc/runtime.h>
#import <pthread.h>
#import "Father.h"
#import "Mother.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testRuntimeClass];
}

- (void)testRuntimeClass {
    Mother *mother = [[Mother alloc] init];
    NSLog(@"==%p==%p==", object_getClass(mother), object_getClass([Mother class]));
}

- (void)testCoding {
    FirstViewController *vc = [FirstViewController new];
    vc.view.frame = CGRectMake(0, 0, 250, 250);
    [self.view addSubview:vc.view];
}

void *ptheard_test(void * data) {
    NSLog(@"==%@==", [NSThread currentThread]);
    return NULL;
}

void testPtheard_demo_01() {
    pthread_t thread;
    pthread_create(&thread, NULL, ptheard_test, NULL);
}

void  testNSThread_demo_01() {
    Father *father = [Father new];
    NSThread *thread = [[NSThread alloc] initWithTarget:father selector:@selector(fatherRun) object:nil];
    [thread start];
    
     [father performSelectorInBackground:@selector(fatherRun) withObject:nil];
}

void testGCD_demo_03() {
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_async(group, queue, ^{
        for (NSInteger i = 0; i < 3; i ++) {
            NSLog(@"group 01 ====%@", [NSThread currentThread]);
        }
        NSLog(@"group 01 完成====");
    });
    
    dispatch_group_async(group, dispatch_get_main_queue(), ^{
        for (NSInteger i = 0; i < 3; i ++) {
            NSLog(@"group 02 ====%@", [NSThread currentThread]);
        }
        NSLog(@"group 02 完成====");
    });
    
    dispatch_group_async(group, queue, ^{
        for (NSInteger i = 0; i < 3; i ++) {
            NSLog(@"group 03 ====%@", [NSThread currentThread]);
        }
        NSLog(@"group 03 完成====");
    });
    
    dispatch_group_async(group, queue, ^{
        for (NSInteger i = 0; i < 3; i ++) {
            NSLog(@"group 04 ====%@", [NSThread currentThread]);
        }
        NSLog(@"group 04 完成====");
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"group end 完成====%@", [NSThread currentThread]);
    });
    
    dispatch_barrier_async(queue, ^{
        for (NSInteger i = 0; i < 3; i ++) {
            NSLog(@"group queue ====%@", [NSThread currentThread]);
        }
    });
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    testPtheard_demo_01();
//    testNSThread_demo_01();
    testGCD_demo_03();
}

@end
