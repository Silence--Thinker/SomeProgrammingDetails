//
//  ViewController.m
//  DomeForRunLoop
//
//  Created by Silence on 2017/3/1.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) dispatch_queue_t custom_global_queue;
@property (nonatomic, strong) NSTimer *timer;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self runLoop_timer_demo_01];
}

static int flage = 0;
- (dispatch_queue_t)custom_global_queue {
    if (_custom_global_queue == nil) {
        _custom_global_queue = dispatch_queue_create("wodequeue99999999", DISPATCH_QUEUE_CONCURRENT);
    }
    return _custom_global_queue;
}

// 创建一个异步线程，在异步线程中开一个定时器
- (void)runLoop_timer_demo_01 {
    __weak typeof(self) weakSelf = self;
    dispatch_async(self.custom_global_queue, ^{
        weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerRun:) userInfo:nil repeats:YES];

        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        NSLog(@"==%p==%p", runLoop, [NSRunLoop mainRunLoop]);

        [[NSRunLoop currentRunLoop] addTimer:weakSelf.timer forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop] run];
    });
}

- (void)timerRun:(NSTimer *)timer {
    NSLog(@"==%@==%@", [NSDate date], [NSThread currentThread]);
    flage ++;
    if ( [NSRunLoop mainRunLoop].currentMode == UITrackingRunLoopMode) {
        NSLog(@"==滑动了==");
    }else {
        NSLog(@"==这是没有滑动==");
    }
    if (flage == 5) {
        [self.timer invalidate];
        self.timer = nil;
        [[NSThread currentThread] cancel];
    }
}

// MARK: - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

@end
