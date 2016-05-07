//
//  ZXDLogView.m
//  ZXDLogTool
//
//  Created by 张雪东 on 16/5/7.
//  Copyright © 2016年 ZXD. All rights reserved.
//

#import "ZXDLogView.h"

@interface ZXDLogView()

@property (nonatomic,strong) UITextView *textView;
@end

@implementation ZXDLogView

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self initView];
    }
    return self;
}

-(void)initView{
    
    self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.6];
//    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
//    textField.borderStyle = UITextBorderStyleLine;
//    [self addSubview:textField];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    textView.backgroundColor = [UIColor clearColor];
    textView.editable = NO;
    textView.layoutManager.allowsNonContiguousLayout = NO;
    [self addSubview:textView];
    self.textView = textView;
}

-(void)updateText:(NSString *)logText{
    
    self.textView.text = logText;
    if (self.textView.contentSize.height - (self.textView.contentOffset.y + CGRectGetHeight(self.textView.bounds)) <= 30) {
        [self.textView scrollRangeToVisible:NSMakeRange(self.textView.text.length, 0)];
    }
}

@end
