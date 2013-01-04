//
//  DLBrain.h
//  Doodle Lines
//
//  Created by Andrey Misura on 02.01.13.
//  Copyright (c) 2013 Andrey Misura. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSMutableArray+MultidimensionalAdditions.h"

#define CELL_COUNT_X 10
#define CELL_COUNT_Y 11

#define MIN_SIMILAR_BLOCKS 3

#define SCORE_RANGE 1000
#define TAPS_DEFAULT 100
#define SPEED_DEFAULT 0.0f

@class DLBrain;

@protocol DLBrainDelegate <NSObject>

@optional
- (void) brainPreviewBoardIsFull: (NSArray *) previewBoardItems;
- (void) brainBoardIsFull: (NSArray *) boardItems;
- (void) brainTapIsEnd;
- (void) brainSppedChanged: (float) speed;

@end

@interface DLBrain : NSObject {
    NSArray *boardElementsEnum;   // Elements enum
    
    // Item storages
    NSMutableArray *boardItems; // Main board
    NSMutableArray *previewBoardItems; // Preview board
    
    int scores;
    int taps;
    float speed;
}

@property (assign, nonatomic) id<DLBrainDelegate> delegate;

- (id) initWithDelegate: (id<DLBrainDelegate>) delegate;

- (void) reset;

// Getters/Setters
- (NSArray *) getBoardItems;
- (NSArray *) getPreviewBoardItems;
- (int) getScores;
- (int) getTaps;
- (float) getSpeed;

// Mechanics
- (void) restructureBoardItemsWithCellsCoords: (NSNumber *) cellsCoords;
- (void) pushLineIntoBoardItems: (NSArray *) items;
- (void) generatePreviewItemElement;
- (NSArray *) generateLineWithElementCount: (int) count;
- (BOOL) similarCellsWithCoordinateX: (int) x andY: (int)y;
- (void) tapDecrement;


@end
