//
//  PaintCodeProgressViewController.m
//  PaintCodeProgressBar
//
//  Created by Mihaela Mihaljević Jakić on 26/01/14.
//  Copyright (c) 2014 Token d.o.o. All rights reserved.
//

#import "PaintCodeProgressViewController.h"
#import "PaintCodeProgressView.h"

@interface PaintCodeProgressViewController ()

//subviews
@property (nonatomic, strong) PaintCodeProgressView *progressView;
@property (nonatomic, strong) UIButton *startProgressButton;

//timer to show progress
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation PaintCodeProgressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.startProgressButton];
    
    //set progress percentage to 0
    [self.progressView setProgress:0];
}

#pragma mark - Actions

#define TIMER_INTERVAL 0.001
#define TIMER_DURATION 3.0

- (void)buttonClicked
{
    self.progressView.progress = 0.0;
    self.startProgressButton.enabled = NO;
    self.timer = [NSTimer timerWithTimeInterval:TIMER_INTERVAL
                                         target:self
                                       selector:@selector(updateProgressView)
                                       userInfo:nil
                                        repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    [self.timer fire];
}

- (void)updateProgressView;
{
    if (self.progressView.progress < 1.0) {
        self.progressView.progress += (TIMER_INTERVAL / TIMER_DURATION);
    } else {
        [self.timer invalidate];
        self.startProgressButton.enabled = YES;
    }
}

#pragma mark - Properties - Views

- (PaintCodeProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[PaintCodeProgressView alloc] initWithFrame:CGRectMake(10, 100, 300, 38)];
    }
    return _progressView;
}

- (UIButton *)startProgressButton
{
    if (!_startProgressButton) {
        _startProgressButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _startProgressButton.frame = CGRectMake(10, 30, 300, 30);
        [_startProgressButton setTitle:@"Start Progress" forState:UIControlStateNormal];
        
        [_startProgressButton addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startProgressButton;
}

@end
