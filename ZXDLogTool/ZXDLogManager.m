//
//  ZXDLogManager.m
//  ZXDLogTool
//
//  Created by 张雪东 on 16/5/7.
//  Copyright © 2016年 ZXD. All rights reserved.
//

#import "ZXDLogManager.h"
#import "ZXDLogView.h"

#define kLogFileName  @"logFile.log"
#define kLogFilePath   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:kLogFileName]

@interface ZXDLogManager()

@property (nonatomic,strong) ZXDLogView *logView;
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation ZXDLogManager

+(instancetype)shareInstance{

    static ZXDLogManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZXDLogManager alloc] init];
    });
    return manager;
}

+(void)saveLog{
    
    NSString *logFilePath = kLogFilePath;
    [[NSFileManager defaultManager] removeItemAtPath:logFilePath error:nil];
    
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "w", stderr);
    
}

- (void)loadLog {
    
    NSString *logFilePath = kLogFilePath;
    
    NSData * logData = [NSData dataWithContentsOfFile:logFilePath];
    NSString * logText = [[NSString alloc]initWithData:logData encoding:NSUTF8StringEncoding];
    [self.logView updateText:logText];
}

-(void)showLogView{

    ZXDLogView *logView = [[ZXDLogView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveLogView:)];
    [logView addGestureRecognizer:panGesture];
    self.logView = logView;
    [[UIApplication sharedApplication].keyWindow addSubview:logView];
}

-(void)moveLogView:(UIPanGestureRecognizer *)gesture{

    CGPoint point = [gesture translationInView:[UIApplication sharedApplication].keyWindow];
    [gesture setTranslation:CGPointZero inView:[UIApplication sharedApplication].keyWindow];
    CGFloat logViewX = self.logView.center.x + point.x;
    CGFloat logViewY = self.logView.center.y + point.y;
    CGPoint logViewCenter = CGPointMake(logViewX, logViewY);
    self.logView.center = logViewCenter;
}

-(void)startLoadLog{

    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
        [self.logView removeFromSuperview];
    }else{
        [self showLogView];
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(loadLog) userInfo:nil repeats:YES];
        [timer fire];
        self.timer = timer;
    }
    
}

+(void)startLog{

    ZXDLogManager *manager = [ZXDLogManager shareInstance];
    [manager startLoadLog];
}

@end
