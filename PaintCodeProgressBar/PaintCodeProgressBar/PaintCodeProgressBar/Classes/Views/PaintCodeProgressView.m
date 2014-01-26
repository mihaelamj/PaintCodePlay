//
//  PaintCodeProgressView.m
//  PaintCodeProgressBar
//
//  Created by Mihaela Mihaljević Jakić on 26/01/14.
//  Copyright (c) 2014 Token d.o.o. All rights reserved.
//
// Based on tutorial from:
// http://www.raywenderlich.com/35720/paintcode-tutorial-custom-progress-bar

#import "PaintCodeProgressView.h"

@implementation PaintCodeProgressView

#pragma mark - Public Properties

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    [self setNeedsDisplay];
}

#pragma mark - Private

- (void)drawRect:(CGRect)rect
{
    // General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Color Declarations
    UIColor *fillColor = [UIColor colorWithRed:0.416 green:0.416 blue:0.416 alpha:1];
    UIColor *strokeColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    UIColor *gradientColor = [UIColor colorWithRed:0.322 green:0.322 blue:0.322 alpha:1];
    UIColor *shadowColor2 = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
    UIColor *shadowColor3 = [UIColor colorWithRed:0.671 green:0.671 blue:0.671 alpha:1];
    UIColor *fillColor2 = [UIColor colorWithRed:0.247 green:0.247 blue:0.247 alpha:1];
    UIColor *strokeColor2 = [UIColor colorWithRed:0.188 green:0.188 blue:0.188 alpha:1];
    UIColor *color = [UIColor colorWithRed:0 green:0.886 blue:0 alpha:1];
    
    // Gradient Declarations
    NSArray *outerRectGradientColors = @[(id)gradientColor.CGColor, (id)fillColor.CGColor];
    CGFloat outerRectGradientLocations[] = {0, 1};
    CGGradientRef outerRectGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)outerRectGradientColors, outerRectGradientLocations);
    NSArray *gradientColors = @[(id)strokeColor2.CGColor, (id)fillColor2.CGColor];
    CGFloat gradientLocations[] = {0, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    
    // Shadow Declarations
    UIColor *darkShadow = shadowColor2;
    CGSize darkShadowOffset = CGSizeMake(0.1, 1.1);
    CGFloat darkShadowBlurRadius = 1.5;
    UIColor *lightShadow = shadowColor3;
    CGSize lightShadowOffset = CGSizeMake(0.1, 1.1);
    CGFloat lightShadowBlurRadius = 0;
    
    // Frames
    CGRect progressIndicatorFrame = rect;
    
    // Subframes
    CGRect progressActiveGroup = CGRectMake(CGRectGetMinX(progressIndicatorFrame) + 13,
                                            CGRectGetMinY(progressIndicatorFrame) + 11,
                                            CGRectGetWidth(progressIndicatorFrame) - 28,
                                            14);
    CGRect activeProgressFrame = CGRectMake(CGRectGetMinX(progressActiveGroup) + floor(CGRectGetWidth(progressActiveGroup) * 0.00000 + 0.5),
                                            CGRectGetMinY(progressActiveGroup) + floor(CGRectGetHeight(progressActiveGroup) * 0.00000 + 0.5),
                                            floor(CGRectGetWidth(progressActiveGroup) * 1.00000 + 0.5) - floor(CGRectGetWidth(progressActiveGroup) * 0.00000 + 0.5),
                                            floor(CGRectGetHeight(progressActiveGroup) * 1.00000 + 0.5) - floor(CGRectGetHeight(progressActiveGroup) * 0.00000 + 0.5));
    
    // Abstracted Attributes
    CGRect progressTrackActiveRect = CGRectMake(CGRectGetMinX(activeProgressFrame) + 3,
                                                CGRectGetMinY(activeProgressFrame) + 2,
                                                (CGRectGetWidth(activeProgressFrame) - 4) * self.progress,
                                                10);
    
    // Progress Bar
    {
        // Border Drawing
        CGRect borderRect = CGRectMake(CGRectGetMinX(progressIndicatorFrame) + 2,
                                       CGRectGetMinY(progressIndicatorFrame) + 1,
                                       CGRectGetWidth(progressIndicatorFrame) - 4,
                                       34);
        UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:borderRect cornerRadius:4];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, darkShadowOffset, darkShadowBlurRadius, darkShadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [borderPath addClip];
        CGContextDrawLinearGradient(context, outerRectGradient,
                                    CGPointMake(CGRectGetMidX(borderRect), CGRectGetMinY(borderRect)),
                                    CGPointMake(CGRectGetMidX(borderRect), CGRectGetMaxY(borderRect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        
        // Border Inner Shadow
        CGRect borderBorderRect = CGRectInset([borderPath bounds], -lightShadowBlurRadius, -lightShadowBlurRadius);
        borderBorderRect = CGRectOffset(borderBorderRect, -lightShadowOffset.width, -lightShadowOffset.height);
        borderBorderRect = CGRectInset(CGRectUnion(borderBorderRect, [borderPath bounds]), -1, -1);
        
        UIBezierPath* borderNegativePath = [UIBezierPath bezierPathWithRect: borderBorderRect];
        [borderNegativePath appendPath: borderPath];
        borderNegativePath.usesEvenOddFillRule = YES;
        
        CGContextSaveGState(context);
        {
            CGFloat xOffset = lightShadowOffset.width + round(borderBorderRect.size.width);
            CGFloat yOffset = lightShadowOffset.height;
            CGContextSetShadowWithColor(context,
                                        CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                        lightShadowBlurRadius,
                                        lightShadow.CGColor);
            
            [borderPath addClip];
            CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(borderBorderRect.size.width), 0);
            [borderNegativePath applyTransform:transform];
            [[UIColor grayColor] setFill];
            [borderNegativePath fill];
        }
        
        CGContextRestoreGState(context);
        CGContextRestoreGState(context);
        
        // ProgressTrack Drawing
        CGRect progressTrackRect = CGRectMake(CGRectGetMinX(progressIndicatorFrame) + 14,
                                              CGRectGetMinY(progressIndicatorFrame) + 11,
                                              CGRectGetWidth(progressIndicatorFrame) - 28,
                                              14);
        UIBezierPath *progressTrackPath = [UIBezierPath bezierPathWithRoundedRect:progressTrackRect cornerRadius:7];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, lightShadowOffset, lightShadowBlurRadius, lightShadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [progressTrackPath addClip];
        CGContextDrawLinearGradient(context, gradient,
                                    CGPointMake(CGRectGetMidX(progressTrackRect), CGRectGetMinY(progressTrackRect)),
                                    CGPointMake(CGRectGetMidX(progressTrackRect), CGRectGetMaxY(progressTrackRect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        
        // ProgressTrack Inner Shadow
        CGRect progressTrackBorderRect = CGRectInset([progressTrackPath bounds], -darkShadowBlurRadius, -darkShadowBlurRadius);
        progressTrackBorderRect = CGRectOffset(progressTrackBorderRect, -darkShadowOffset.width, -darkShadowOffset.height);
        progressTrackBorderRect = CGRectInset(CGRectUnion(progressTrackBorderRect, [progressTrackPath bounds]), -1, -1);
        
        UIBezierPath *progressTrackNegativePath = [UIBezierPath bezierPathWithRect: progressTrackBorderRect];
        [progressTrackNegativePath appendPath: progressTrackPath];
        progressTrackNegativePath.usesEvenOddFillRule = YES;
        
        CGContextSaveGState(context);
        {
            CGFloat xOffset = darkShadowOffset.width + round(progressTrackBorderRect.size.width);
            CGFloat yOffset = darkShadowOffset.height;
            CGContextSetShadowWithColor(context,
                                        CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                        darkShadowBlurRadius,
                                        darkShadow.CGColor);
            
            [progressTrackPath addClip];
            CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(progressTrackBorderRect.size.width), 0);
            [progressTrackNegativePath applyTransform: transform];
            [[UIColor grayColor] setFill];
            [progressTrackNegativePath fill];
        }
        
        CGContextRestoreGState(context);
        CGContextRestoreGState(context);
        
        [strokeColor setStroke];
        progressTrackPath.lineWidth = 0.5;
        [progressTrackPath stroke];
        
        // ProgressActiveGroup
        {
            // ProgressTrackActive Drawing
            UIBezierPath *progressTrackActivePath = [UIBezierPath bezierPathWithRoundedRect:progressTrackActiveRect
                                                                               cornerRadius:5];
            [color setFill];
            [progressTrackActivePath fill];
        }
    }
    
    // Cleanup
    CGGradientRelease(outerRectGradient);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

@end
