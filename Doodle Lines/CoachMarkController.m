//
//  CoachMarkController.m
//  Doodle Lines
//
//  Created by Andrey Misura on 07.01.13.
//  Copyright (c) 2013 Andrey Misura. All rights reserved.
//

#import "CoachMarkController.h"

@interface CoachMarkController () {
    CGFloat endAlpha;
}

@end

@implementation CoachMarkController

@synthesize delegate;
@synthesize labelTitle, labelNotice;
@synthesize labelBlocks, labelScores, labelTime, labelBlocksValue, labelScoreValue, labelTimeValue;
@synthesize viewButtons, viewClickNotifier;
@synthesize buttonRetry, buttonMainMenu;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    gameEnded = NO;

    endAlpha = self.view.alpha;
//    self.view.hidden = YES;
    self.view.alpha = 0.0f;

    self.labelTitle.font = [UIFont fontWithName:@"Architects Daughter" size: 36];
    self.labelNotice.font = [UIFont fontWithName:@"Architects Daughter" size: 14];
    
    self.viewResult.hidden = YES;

    self.labelMessage.font = [UIFont fontWithName:@"Architects Daughter" size: 16];
    self.labelBlocks.font = [UIFont fontWithName:@"Architects Daughter" size: 14];
    self.labelScores.font = [UIFont fontWithName:@"Architects Daughter" size: 14];
    self.labelTime.font = [UIFont fontWithName:@"Architects Daughter" size: 14];
    self.labelBlocksValue.font = [UIFont fontWithName:@"Architects Daughter" size: 14];
    self.labelScoreValue.font = [UIFont fontWithName:@"Architects Daughter" size: 14];
    self.labelTimeValue.font = [UIFont fontWithName:@"Architects Daughter" size: 14];

    self.buttonRetry.titleLabel.font = [UIFont fontWithName:@"Architects Daughter" size: 18];
    self.buttonMainMenu.titleLabel.font = [UIFont fontWithName:@"Architects Daughter" size: 18];

    self.viewResult.hidden = YES;
    self.viewButtons.hidden = YES;
    self.viewClickNotifier.hidden = YES;
    
    [self fadeInWithDuration:0.3f andDelay:0];
}

- (void) showPause {
    gameEnded = NO;

    self.viewResult.hidden = YES;
    self.viewButtons.hidden = YES;
    self.viewClickNotifier.hidden = NO;

    self.labelTitle.text = @"Pause";
    self.labelMessage.text = @"";
}

- (void) showResultWithBoard:(DLBrain *) brain andMessage:(NSString *)message {
    gameEnded = YES;

    self.viewResult.hidden = NO;
    self.viewButtons.hidden = NO;
    self.viewClickNotifier.hidden = YES;

    self.labelTitle.text = @"Game over!";
    self.labelMessage.text = message;
    
    self.labelScoreValue.text = [NSString stringWithFormat:@"%i", [brain getScores]];
    self.labelBlocksValue.text = [NSString stringWithFormat:@"%i", [brain getRemovedBlocks]];
}

- (void)fadeInWithDuration: (float) duration andDelay: (float) delay  {
    self.view.alpha = 0.0f;
    
    [UIView animateWithDuration:duration delay:delay options:0 animations:^{
        self.view.alpha = endAlpha;
    } completion:^(BOOL finished) {
//        self.view.hidden = NO;
    }];
}

- (void)fadeOutWithDuration: (float) duration andDelay: (float) delay  {
    self.view.alpha = endAlpha;
    
    [UIView animateWithDuration:duration delay:delay options:0 animations:^{
        self.view.alpha = 0.0f;
    } completion:^(BOOL finished) {
    }];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (gameEnded) return; // Disabled screen tap if game ended!

    [self fadeOutWithDuration:0.3f andDelay:0];
    
    [self.delegate coachMarkControllerTouchesEnded:touches withEvent:event];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) retryGame:(id)sender {
    if (self.delegate) {
        [self.delegate coachMarkControllerGameRetry];
    }

    gameEnded = NO;
    [self fadeOutWithDuration:0.3f andDelay:0];
}

- (IBAction) backToMainMenu:(id)sender {
    if (self.delegate) {
        [self.delegate coachMarkControllerBackToMainMenu];
    }

}

- (void)viewDidUnload {
    [self fadeOutWithDuration:0.3f andDelay:0];
    
    [self setLabelTitle:nil];
    [self setLabelNotice:nil];
    [self setLabelScores:nil];
    [self setLabelBlocks:nil];
    [self setLabelTime:nil];
    [self setLabelScoreValue:nil];
    [self setLabelBlocksValue:nil];
    [self setLabelTimeValue:nil];
    [self setViewResult:nil];
    [self setLabelMessage:nil];
    [self setViewClickNotifier:nil];
    [self setViewButtons:nil];
    [self setButtonRetry:nil];
    [self setButtonMainMenu:nil];
    [super viewDidUnload];
}
@end
