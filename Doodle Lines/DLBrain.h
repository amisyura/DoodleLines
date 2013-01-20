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
- (void) brainHasBonus: (int) bonus withCellX: (int) cellX andCellY: (int) cellY;

@end

@interface DLBrain : NSObject {
    NSArray *boardElementsEnum;   // Elements enum
    
    // Item storages
    NSMutableArray *boardItems; // Main board
    NSMutableArray *previewBoardItems; // Preview board

    // Scores counter
    int scores;

    // Taps counter
    int taps;

    // Speed state
    float speed;

    // Counter of removed blocks
    int removedBlocks;
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
- (int) getRemovedBlocks;

// Mechanics
- (void) restructureBoardItemsWithCellsCoords: (NSMutableSet *) cellsCoords;
- (void) pushLineIntoBoardItems: (NSArray *) items;
- (void) generatePreviewItemElement;
- (NSArray *) generateLineWithElementCount: (int) count;
- (BOOL) similarCellsWithCoordinateX: (int) x andY: (int)y;
- (void) tapDecrement;


@end
