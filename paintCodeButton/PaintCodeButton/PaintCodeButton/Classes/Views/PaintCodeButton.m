//
//  PaintCodeButtonView.m
//  PaintCodeButton
//
//  Created by Mihaela Mihaljević Jakić on 25/01/14.
//  Copyright (c) 2014 Token d.o.o. All rights reserved.
//

#import "PaintCodeButton.h"

@interface PaintCodeButton ()

//private properties calculated from public red, green and blue color values
@property (nonatomic, strong) UIColor *lightColor;
@property (nonatomic, strong) UIColor *darkColor;

@end

@implementation PaintCodeButton

- (id)initWithFrame:(CGRect)frame redPart:(NSUInteger)redPart greenPart:(NSUInteger)greenPart bluePart:(NSUInteger)bluePart
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //set colors
        _redPart = redPart;
        _greenPart = greenPart;
        _bluePart = bluePart;
    }
    [self setNeedsDisplay];
    return self;
}

#pragma mark - Public Properties

- (void)setRedPart:(NSUInteger)redPart
{
    _redPart = redPart;
    [self setNeedsDisplay];
}

- (void)setGreenPart:(NSUInteger)greenPart
{
    _greenPart = greenPart;
    [self setNeedsDisplay];
}

- (void)setBluePart:(NSUInteger)bluePart
{
    _bluePart = bluePart;
    [self setNeedsDisplay];
}

//overrides of standard UIControl methods to re-draw butoon upon changing it's state
#pragma mark - Overrides UIControl

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    [self setNeedsDisplay];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self setNeedsDisplay];
}

#pragma mark - Private

//drawing routine, pasted from PaintCode and modified to be able to dynamically change colors
- (void)drawRect:(CGRect)rect
{
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
//replaced PaintCode generated code - BEGIN
    //// Color Declarations
//    UIColor *buttonColorLight = [UIColor colorWithRed: 1 green: 0 blue: 0 alpha: 1];
//    UIColor *buttonColorDark = [UIColor colorWithRed: 0.439 green: 0.004 blue: 0 alpha: 1];
    
   
    
    //// Gradient Declarations
//    NSArray* redGradientColors = [NSArray arrayWithObjects:
//                                  (id)buttonColorLight.CGColor,
//                                  (id)buttonColorDark.CGColor, nil];
    
//    NSArray *redGradientColors = @[(id)buttonColorLight.CGColor,
//                                  (id)buttonColorDark.CGColor];
    
//replaced PaintCode generated code - END
    
    NSArray *redGradientColors = @[(id)self.lightColor.CGColor, (id)self.darkColor.CGColor];
    
    CGFloat redGradientLocations[] = {0, 1};
    CGGradientRef redGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)redGradientColors, redGradientLocations);
    
    
     UIColor *color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    //// Shadow Declarations
    UIColor *outerGlow = [color colorWithAlphaComponent: 0.5];
    CGSize outerGlowOffset = CGSizeMake(0.1, -0.1);
    CGFloat outerGlowBlurRadius = 3;
    
    UIColor *innerGlow = [color colorWithAlphaComponent: 0.55];
    CGSize innerGlowOffset = CGSizeMake(3.1, 2.1);
    CGFloat innerGlowBlurRadius = 2;

//replaced PaintCode generated code - BEGIN
    //// Frames
//    CGRect frame = CGRectMake(4, 4, 473, 41);
//replaced PaintCode generated code - END
    
    CGRect frame = rect;
    
    //// Subframes
    CGRect button = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), CGRectGetHeight(frame));
    
    
    //// Button
    {
        //// Rounded Rectangle Drawing
        CGRect roundedRectangleRect = CGRectMake(CGRectGetMinX(button) + floor(CGRectGetWidth(button) * 0.00000 + 0.5), CGRectGetMinY(button) + floor(CGRectGetHeight(button) * 0.00000 + 0.5), floor(CGRectGetWidth(button) * 1.00000 + 0.5) - floor(CGRectGetWidth(button) * 0.00000 + 0.5), floor(CGRectGetHeight(button) * 1.00000 + 0.5) - floor(CGRectGetHeight(button) * 0.00000 + 0.5));
        UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: roundedRectangleRect cornerRadius: 4];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, outerGlowOffset, outerGlowBlurRadius, outerGlow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [roundedRectanglePath addClip];
        CGContextDrawLinearGradient(context, redGradient,
                                    CGPointMake(CGRectGetMidX(roundedRectangleRect), CGRectGetMinY(roundedRectangleRect)),
                                    CGPointMake(CGRectGetMidX(roundedRectangleRect), CGRectGetMaxY(roundedRectangleRect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        
        ////// Rounded Rectangle Inner Shadow
        CGRect roundedRectangleBorderRect = CGRectInset([roundedRectanglePath bounds], -innerGlowBlurRadius, -innerGlowBlurRadius);
        roundedRectangleBorderRect = CGRectOffset(roundedRectangleBorderRect, -innerGlowOffset.width, -innerGlowOffset.height);
        roundedRectangleBorderRect = CGRectInset(CGRectUnion(roundedRectangleBorderRect, [roundedRectanglePath bounds]), -1, -1);
        
        UIBezierPath* roundedRectangleNegativePath = [UIBezierPath bezierPathWithRect: roundedRectangleBorderRect];
        [roundedRectangleNegativePath appendPath: roundedRectanglePath];
        roundedRectangleNegativePath.usesEvenOddFillRule = YES;
        
        CGContextSaveGState(context);
        {
            CGFloat xOffset = innerGlowOffset.width + round(roundedRectangleBorderRect.size.width);
            CGFloat yOffset = innerGlowOffset.height;
            CGContextSetShadowWithColor(context,
                                        CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                        innerGlowBlurRadius,
                                        innerGlow.CGColor);
            
            [roundedRectanglePath addClip];
            CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(roundedRectangleBorderRect.size.width), 0);
            [roundedRectangleNegativePath applyTransform: transform];
            [[UIColor grayColor] setFill];
            [roundedRectangleNegativePath fill];
        }
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
        
        [[UIColor blackColor] setStroke];
        roundedRectanglePath.lineWidth = 1.5;
        [roundedRectanglePath stroke];
    }
    
    
    //// Cleanup
    CGGradientRelease(redGradient);
    CGColorSpaceRelease(colorSpace);
}

#pragma mark - Private Properties

- (UIColor *)lightColor
{
    CGFloat alpha = (self.state == UIControlStateHighlighted) ? 0.5 : 1;
    return [UIColor colorWithRed:self.redPart/255.0 green:self.greenPart/255.0 blue:self.bluePart/255.0 alpha:alpha];
}

- (UIColor *)darkColor
{
    //make dark color from light color, by changing the alpha value (making it lighter actually)
    CGFloat buttonColorLightRGBA[4];
    [self.lightColor getRed:&buttonColorLightRGBA[0]
                       green:&buttonColorLightRGBA[1]
                        blue:&buttonColorLightRGBA[2]
                       alpha:&buttonColorLightRGBA[3]];
    
    return [UIColor colorWithRed:(buttonColorLightRGBA[0] * 0.5)
                           green:(buttonColorLightRGBA[1] * 0.5)
                            blue:(buttonColorLightRGBA[2] * 0.5)
                           alpha:(buttonColorLightRGBA[3] * 0.5 + 0.5)];
}


@end
