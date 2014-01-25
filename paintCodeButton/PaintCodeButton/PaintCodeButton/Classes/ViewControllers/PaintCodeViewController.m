//
//  PaintCodeViewController.m
//  PaintCodeButton
//
//  Created by Mihaela Mihaljević Jakić on 25/01/14.
//  Copyright (c) 2014 Token d.o.o. All rights reserved.
//

#import "PaintCodeViewController.h"
#import "PaintCodeButton.h"

@interface PaintCodeViewController ()

@property (nonatomic, strong) PaintCodeButton *button;

//color sliders
@property (nonatomic, strong) UISlider *redSlider;
@property (nonatomic, strong) UISlider *greenSlider;
@property (nonatomic, strong) UISlider *blueSlider;

@end

@implementation PaintCodeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.button];
    [self.view addSubview:self.redSlider];
    [self.view addSubview:self.greenSlider];
    [self.view addSubview:self.blueSlider];
    
    //set slider values to match button color parts
    [self.redSlider setValue:self.button.redPart/255.0];
    [self.greenSlider setValue:self.button.greenPart/255.0];
    [self.blueSlider setValue:self.button.bluePart/255.0];
}

#pragma mark - Actions

//change button's color properties (red, green and blue), whose setters will make it re-draw itself
- (void)colorSliderChanged:(UISlider *)sender
{
    if (sender == self.redSlider)
        self.button.redPart = self.redSlider.value*255;
    else if (sender == self.greenSlider)
        self.button.greenPart = self.greenSlider.value*255;
    else if (sender == self.blueSlider)
        self.button.bluePart = self.blueSlider.value*255;
}

- (void)buttonClicked:(PaintCodeButton *)sender
{
    NSLog(@"R:%d G:%d B:%d", sender.redPart, sender.greenPart, sender.bluePart);
}

#pragma mark - Properties

#define CONTROL_X_OFFSET 20
#define CONTROL_Y_OFFSET 10
#define CONTROL_WIDTH 280
#define SLIDER_HEIGHT 20
#define BUTTON_HEIGHT 30

- (PaintCodeButton *)button
{
    if (!_button) {
        _button = [[PaintCodeButton alloc] initWithFrame:CGRectMake(CONTROL_X_OFFSET, CONTROL_Y_OFFSET*2, CONTROL_WIDTH, BUTTON_HEIGHT) redPart:186 greenPart:86 bluePart:86];
        [_button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (UISlider *)redSlider
{
    if (!_redSlider) {
        _redSlider = [[UISlider alloc] initWithFrame:CGRectMake(CONTROL_X_OFFSET,
                                                                CGRectGetHeight(self.button.frame) + CGRectGetMaxY(self.button.frame),
                                                                CONTROL_WIDTH,
                                                                SLIDER_HEIGHT)];
        _redSlider.minimumTrackTintColor = [UIColor redColor];
        [_redSlider addTarget:self action:@selector(colorSliderChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _redSlider;
}

- (UISlider *)greenSlider
{
    if (!_greenSlider) {
        _greenSlider = [[UISlider alloc] initWithFrame:CGRectMake(CONTROL_X_OFFSET,
                                                                  CGRectGetHeight(self.redSlider.frame) + CGRectGetMaxY(self.redSlider.frame) + CONTROL_Y_OFFSET,
                                                                  CONTROL_WIDTH,
                                                                  SLIDER_HEIGHT)];
        _greenSlider.minimumTrackTintColor = [UIColor greenColor];
        [_greenSlider addTarget:self action:@selector(colorSliderChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _greenSlider;
}

- (UISlider *)blueSlider
{
    if (!_blueSlider) {
        _blueSlider = [[UISlider alloc] initWithFrame:CGRectMake(CONTROL_X_OFFSET,
                                                                 CGRectGetHeight(self.greenSlider.frame) + CGRectGetMaxY(self.greenSlider.frame) + CONTROL_Y_OFFSET,
                                                                 CONTROL_WIDTH,
                                                                 SLIDER_HEIGHT)];
        _blueSlider.minimumTrackTintColor = [UIColor blueColor];
        [_blueSlider addTarget:self action:@selector(colorSliderChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _blueSlider;
}

@end
