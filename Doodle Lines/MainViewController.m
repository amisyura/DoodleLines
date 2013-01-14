//
//  MainViewController.m
//  Doodle Lines
//
//  Created by Andrey Misura on 08.01.13.
//  Copyright (c) 2013 Andrey Misura. All rights reserved.
//

#import "MainViewController.h"
#import "DLViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation MainViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    [UIApplication sharedApplication].statusBarHidden = YES;
}

- (IBAction) startGame:(id)sender {
    DLViewController *controller = [[DLViewController alloc] initWithNibName:nil bundle:nil];
    
//    CATransition *transition = [CATransition animation];
//    transition.duration = 0.5f;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = kCATransitionFade;
////    transition.subtype = kCATransitionFromBottom;
////    transitioning = YES;
//    transition.delegate = self;
//    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationController pushViewController:controller animated:NO];
}

- (IBAction) instructions:(id)sender {
    
}

@end
