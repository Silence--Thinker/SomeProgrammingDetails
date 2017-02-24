//
//  FirstViewController.m
//  DemoForVC
//
//  Created by Silence on 2017/2/20.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5);
    self.view.backgroundColor = [UIColor redColor];
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
