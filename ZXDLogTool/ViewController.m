//
//  ViewController.m
//  ZXDLogTool
//
//  Created by 张雪东 on 16/5/7.
//  Copyright © 2016年 ZXD. All rights reserved.
//

#import "ViewController.h"
#import "ZXDLogManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(log) userInfo:nil repeats:YES];
}

-(void)log{

    NSLog(@"------zxd---====");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
