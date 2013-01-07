//
//  CoachMarkController.h
//  Doodle Lines
//
//  Created by Andrey Misura on 07.01.13.
//  Copyright (c) 2013 Andrey Misura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLBrain.h"

@class CoachMarkController;

@protocol CoachMarkControllerDelegate <NSObject>

- (void) coachMarkControllerTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

@end

@interface CoachMarkController : UIViewController

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

- (void) showPause;
- (void) showResultWithBoard: (DLBrain *) brain andMessage: (NSString *) message;

@end
