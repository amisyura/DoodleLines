//
//  DLViewController.h
//  Doodle Lines
//
//  Created by Andrey Misura on 02.01.13.
//  Copyright (c) 2013 Andrey Misura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoardView.h"
#import "PreviewBoardView.h"
#import "DLBrain.h"

@interface DLViewController : UIViewController <DLBrainDelegate, BoardViewDelegate> {
    BOOL gameStarted;
}
@property (strong, nonatomic) IBOutlet UIButton *buttonStartStop;
@property (strong, nonatomic) IBOutlet UILabel *labelScore;
@property (strong, nonatomic) IBOutlet UILabel *labelScoreValue;
@property (strong, nonatomic) IBOutlet UILabel *labelTaps;
@property (strong, nonatomic) IBOutlet UILabel *labelTapsValue;

@property (strong, nonatomic) IBOutlet UILabel *labelSpeedValue;
@property (strong, nonatomic) BoardView *board;
@property (strong, nonatomic) PreviewBoardView *previewBoard;
@property (strong, nonatomic) DLBrain *brain;

@property (strong, nonatomic) NSTimer *timerBoardPreview;

- (IBAction) startStopGame:(id)sender;


@end
