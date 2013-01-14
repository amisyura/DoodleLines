//
//  DLViewController.m
//  Doodle Lines
//
//  Created by Andrey Misura on 02.01.13.
//  Copyright (c) 2013 Andrey Misura. All rights reserved.
//

#import "DLViewController.h"


@implementation DLViewController

@synthesize labelScore, labelScoreValue, labelTaps, labelTapsValue, buttonStartStop;
@synthesize board, previewBoard;

#pragma mark initialization

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.alpha = 0.3f;
    
    [UIView animateWithDuration:0.5f delay:0 options:0 animations:^{
        self.view.alpha = 1.0f;
    } completion:^(BOOL finished) {
        //        self.view.hidden = NO;
    }];
    
    gameStarted = NO;
    
    // Labels
    UIColor *penColor = [UIColor colorWithRed:0.02 green:0.325 blue:1 alpha:1];
    
    // View elements
    int width = self.view.frame.size.width;
    
    CGRect boardRect = CGRectMake(5, 14, width - 10, 326);
    self.board = [[BoardView alloc] initWithFrame:boardRect andBorderColor:penColor];
    self.board.delegate = self;
    
    CGRect previewBoardRect = CGRectMake(5, 363, width-10, 35);
    self.previewBoard = [[PreviewBoardView alloc] initWithFrame:previewBoardRect andBorderColor:penColor];
    
    [self.view addSubview:self.board];
    [self.view addSubview:self.previewBoard];
    
    self.brain = [[DLBrain alloc] initWithDelegate:self];

    self.board.board = [self.brain getBoardItems];
    [self.board setNeedsDisplay];
    
}

- (void) setCoachController: (CoachMarkController *) value {
    coachController = value;
}

- (CoachMarkController *) coachController {
    if (!coachController) {
        coachController = [[CoachMarkController alloc] initWithNibName:nil bundle:nil];
        coachController.delegate = self;
    }
    
    return coachController;
}

#pragma mark IBAction`s

- (IBAction) startStopGame:(id)sender {
    if (!gameStarted) {
        gameStarted = YES;
        [sender setImage:[UIImage imageNamed:@"stop-button.png"] forState:UIControlStateNormal];
        [self brainSppedChanged:[self.brain getSpeed]];
        
        if (self.coachController) {
            self.coachController = nil;
        }
    } else {
        gameStarted = NO;
        [sender setImage:[UIImage imageNamed:@"start-button.png"] forState:UIControlStateNormal];
        [self.timerBoardPreview invalidate];
        
        [self.view addSubview:self.coachController.view];
        [self.coachController showPause];
    }

    // Set labels value
    self.labelScoreValue.text = [NSString stringWithFormat:@"%i", [self.brain getScores]];
    self.labelTapsValue.text = [NSString stringWithFormat:@"%i", [self.brain getTaps]];
    self.labelSpeedValue.text = [NSString stringWithFormat:@"%f", [self.brain getSpeed]];
}

#pragma mark adoptiong delegates

- (void) boardViewUpdateItem: (NSTimer *) timer {
    [self.brain generatePreviewItemElement];
    self.previewBoard.board = [self.brain getPreviewBoardItems];
    [self.previewBoard setNeedsDisplay];
}

- (void) brainPreviewBoardIsFull:(NSArray *)previewBoardItems {
    if (gameStarted == NO) return;
    // WARNING: Return multiple array!!
    [self.brain pushLineIntoBoardItems:[previewBoardItems objectAtIndex:0]];
    self.board.board = [self.brain getBoardItems];
    [self.board setNeedsDisplay];
}

- (void) brainSppedChanged:(float)speed {
    float interval = 1.0f - speed;
    [self initializationTimerWithInterval:interval];
    self.labelSpeedValue.text = [NSString stringWithFormat:@"%f", speed];
}

- (void) brainBoardIsFull:(NSArray *)boardItems {
    gameStarted = NO;
    [self.buttonStartStop setImage:[UIImage imageNamed:@"start-button.png"] forState:UIControlStateNormal];
    
    [self.view addSubview:self.coachController.view];
    [coachController showResultWithBoard:self.brain andMessage:@""];
    
    [self.timerBoardPreview invalidate];
//    [self.brain reset];
//    self.board.board = self.brain.getBoardItems;
}

- (void)brainTapIsEnd {
    gameStarted = NO;
    [self.buttonStartStop setImage:[UIImage imageNamed:@"start-button.png"] forState:UIControlStateNormal];
    
    [self.view addSubview:self.coachController.view];
    [coachController showResultWithBoard:self.brain andMessage:@"Out of taps..."];
    
    [self.timerBoardPreview invalidate];
//    [self.brain reset];
//    self.board.board = self.brain.getBoardItems;
}

- (void) boardViewTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([touches count] && gameStarted) {
        UITouch *touch = [[touches allObjects] objectAtIndex:0];
        CGPoint touchLocation =  [touch locationInView:self.board];
        
        // Flip Y-coord
        int cellY = (touchLocation.y / CELL_HEIGHT - CELL_COUNT_Y) * (-1);
        int cellX = touchLocation.x / CELL_WIDTH;
        // Checking coords
        if (cellX > (CELL_COUNT_X - 1)) cellX = (CELL_COUNT_X - 1);
        if (cellY > (CELL_COUNT_Y - 1)) cellY = (CELL_COUNT_Y - 1);

//        NSLog(@"%i %i", cellX, cellY);

        if ([self.brain similarCellsWithCoordinateX:cellX andY:cellY]) {
            self.board.board = [self.brain getBoardItems];
            [self.board setNeedsDisplay];
            [self.labelScoreValue setText:[NSString stringWithFormat:@"%i", [self.brain getScores]]];
        }

        // Tap setting
        [self.labelTapsValue setText:[NSString stringWithFormat:@"%i", [self.brain getTaps]]];
    }
}

- (void) coachMarkControllerTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.buttonStartStop sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (void) coachMarkControllerGameRetry {
    [self.brain reset];
    
    gameStarted = NO;
    self.board.board = [self.brain getBoardItems];
    self.previewBoard.board = [self.brain getPreviewBoardItems];
    [self.board setNeedsDisplay];
    [self.previewBoard setNeedsDisplay];
    
    [self.buttonStartStop sendActionsForControlEvents:UIControlEventTouchUpInside];
}

#pragma mark support methods
- (void) initializationTimerWithInterval: (float) interval {
    [self.timerBoardPreview invalidate];
    self.timerBoardPreview = [NSTimer scheduledTimerWithTimeInterval:interval
                                                              target:self
                                                            selector:@selector(boardViewUpdateItem:)
                                                            userInfo:nil
                                                             repeats:YES];
}

#pragma mark memory management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setButtonStartStop:nil];
    [self setLabelScore:nil];
    [self setLabelScoreValue:nil];
    [self setLabelTaps:nil];
    [self setLabelTapsValue:nil];
    [self setLabelSpeedValue:nil];
    [super viewDidUnload];
}
@end
