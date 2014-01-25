//
//  MMJAppDelegate.m
//  PaintCodeButton
//
//  Created by Mihaela Mihaljević Jakić on 25/01/14.
//  Copyright (c) 2014 Token d.o.o. All rights reserved.
//

#import "MMJAppDelegate.h"
#import "PaintCodeViewController.h"

@implementation MMJAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = [[PaintCodeViewController alloc] init];
    
    [self.window makeKeyAndVisible];
    return YES;
}


@end
