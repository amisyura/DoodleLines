//
//  CoachMarkController.h
//  Doodle Lines
//
//  Created by Andrey Misura on 07.01.13.
//  Copyright (c) 2013 Andrey Misura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLBrain.h"
#import "AbstractController.h"

@class CoachMarkController;

@protocol CoachMarkControllerDelegate <NSObject>

- (void) coachMarkControllerTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) coachMarkControllerGameRetry;

@optional
- (void) coachMarkControllerBackToMainMenu;

@end

@interface CoachMarkController : AbstractController  {
    BOOL gameEnded;
}

@property (assign, nonatomic) id <CoachMarkControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) IBOutlet UILabel *labelNotice;
@property (strong, nonatomic) IBOutlet UILabel *labelMessage;

@property (strong, nonatomic) IBOutlet UIView *viewResult;

@property (strong, nonatomic) IBOutlet UILabel *labelScores;
@property (strong, nonatomic) IBOutlet UILabel *labelBlocks;
@property (strong, nonatomic) IBOutlet UILabel *labelTime;

@property (strong, nonatomic) IBOutlet UILabel *labelScoreValue;
@property (strong, nonatomic) IBOutlet UILabel *labelBlocksValue;
@property (strong, nonatomic) IBOutlet UILabel *labelTimeValue;

@property (strong, nonatomic) IBOutlet UIView *viewClickNotifier;
@property (strong, nonatomic) IBOutlet UIView *viewButtons;

@property (strong, nonatomic) IBOutlet UIButton *buttonRetry;
@property (strong, nonatomic) IBOutlet UIButton *buttonMainMenu;


- (void) showPause;
- (void) showResultWithBoard: (DLBrain *) brain andMessage: (NSString *) message;

- (IBAction) retryGame:(id)sender;
- (IBAction) backToMainMenu:(id)sender;

@end
