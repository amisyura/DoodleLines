//
//  DLAppDelegate.h
//  Doodle Lines
//
//  Created by Andrey Misura on 02.01.13.
//  Copyright (c) 2013 Andrey Misura. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DLViewController;

@interface DLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) DLViewController *viewController;

@end
