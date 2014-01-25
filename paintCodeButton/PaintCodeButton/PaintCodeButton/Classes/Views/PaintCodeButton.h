//
//  PaintCodeButtonView.h
//  PaintCodeButton
//
//  Created by Mihaela Mihaljević Jakić on 25/01/14.
//  Copyright (c) 2014 Token d.o.o. All rights reserved.
//
// Based on http://www.raywenderlich.com/36341/paintcode-tutorial-dynamic-buttons
// made with PaintCode app
//

#import <UIKit/UIKit.h>

@interface PaintCodeButton : UIButton

//button color properties with red, green and blue values (0-255)
@property (nonatomic) NSUInteger redPart;
@property (nonatomic) NSUInteger greenPart;
@property (nonatomic) NSUInteger bluePart;

- (id)initWithFrame:(CGRect)frame redPart:(NSUInteger)redPart greenPart:(NSUInteger)greenPart bluePart:(NSUInteger)bluePart;

@end
