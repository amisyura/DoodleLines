//
//  DLBrain.m
//  Doodle Lines
//
//  Created by Andrey Misura on 02.01.13.
//  Copyright (c) 2013 Andrey Misura. All rights reserved.
//

#import "DLBrain.h"

#define SUBTOTAL_SPEED_DEFAULT 0.1f

@interface DLBrain() {
    NSMutableSet *similarCell;
    int subtotalScores;
    float subtotalSpeed;
}

@end

@implementation DLBrain

- (id) init {
    if(self = [super init]) {
        boardElementsEnum = [[NSArray alloc] initWithObjects:
                        @"blue",
                        @"green",
                        @"orange",
//                        @"purple",
                        @"red",
//                        @"yellow",
                        nil];
        
        [self reset];
    }
    
    return self;
}

- (id) initWithDelegate:(id<DLBrainDelegate>)delegate {
    if (self = [self init]) {
        self.delegate = delegate;
    }
    
    return self;
}

- (void) reset {
    scores = 0;
    subtotalScores = 0;
    removedBlocks = 0;
    subtotalSpeed = SUBTOTAL_SPEED_DEFAULT;
    speed = SPEED_DEFAULT;
    taps = TAPS_DEFAULT;
    
    previewBoardItems = nil;
    previewBoardItems = [[NSMutableArray alloc] init];
    
    boardItems = nil;
    boardItems = [NSMutableArray arrayOfRows:CELL_COUNT_Y andColumns:CELL_COUNT_X];

    //for test
    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < [[boardItems objectAtIndex:i] count]; j++) {
            [boardItems setObjectValue:[self generateRandomElement] atRow:i andColumn:j];
        }
    }

//    [boardItems setObjectValue:@"red" atRow:0 andColumn:7];
//    [boardItems setObjectValue:@"red" atRow:0 andColumn:6];
//    [boardItems setObjectValue:@"red" atRow:1 andColumn:6];
//
//    [boardItems setObjectValue:@"green" atRow:0 andColumn:7];
//    [boardItems setObjectValue:@"green" atRow:1 andColumn:7];
//    [boardItems setObjectValue:@"green" atRow:2 andColumn:7];

//    [boardItems setObjectValue:@"yellow" atRow:0 andColumn:8];
//    [boardItems setObjectValue:@"yellow" atRow:1 andColumn:8];
//    [boardItems setObjectValue:@"yellow" atRow:2 andColumn:8];
//
//    [boardItems setObjectValue:@"green" atRow:0 andColumn:9];
//    [boardItems setObjectValue:@"green" atRow:1 andColumn:9];
//    [boardItems setObjectValue:@"green" atRow:2 andColumn:9];
//
//    [boardItems setObjectValue:@"red" atRow:0 andColumn:4];
//    [boardItems setObjectValue:@"red" atRow:1 andColumn:4];
//    [boardItems setObjectValue:@"red" atRow:2 andColumn:4];
//
//    [boardItems setObjectValue:@"purple" atRow:0 andColumn:5];
//    [boardItems setObjectValue:@"purple" atRow:1 andColumn:5];
//    [boardItems setObjectValue:@"purple" atRow:2 andColumn:5];

}


#pragma mark getters and setters

- (NSArray *) getBoardItems {
    return [NSArray arrayWithArray:boardItems];
}

- (NSArray *) getPreviewBoardItems {
    return [NSArray arrayWithObject:[NSArray arrayWithArray:previewBoardItems]];
}

- (int) getScores {
    return scores;
}

- (int) getTaps {
    return taps;
}

- (float)getSpeed {
    return speed;
}

- (int)getRemovedBlocks {
    return removedBlocks;
}

#pragma mark mechanics

- (void)restructureBoardItemsWithCells:(NSMutableSet *)cellsCoords {
    NSMutableSet *columnsForCheck = [[NSMutableSet alloc] init];
    for (NSValue *value in cellsCoords) {
        NSNumber *column = [NSNumber numberWithInteger:[value CGPointValue].x];
        [columnsForCheck addObject:column];
    }

    for (NSNumber *column in columnsForCheck) {
        int x = [column integerValue];
        for (int y = 0; y < CELL_COUNT_Y; y++) {
            if ([[boardItems objectAtRow:y andColumn:x] isEqual:@""]) {
                for (int i = y; i < CELL_COUNT_Y; i++) {
                    NSString *tempCell = [boardItems objectAtRow:i andColumn:x];
                    if (![tempCell isEqual:@""]) {
                        [boardItems setObjectValue:tempCell atRow:y andColumn:x];
                        [boardItems setObjectValue:@"" atRow:i andColumn:x];
                        break;
                    }
                }
            }
        }
    }

    // Сдвиг!!
    for (NSNumber *column in columnsForCheck) {
        int x = [column integerValue];
        int emptyColCount = 0;
        for (int y = 0; y < CELL_COUNT_Y; y++) {
            NSString *currentRow = [boardItems objectAtRow:y andColumn:x];
            if ( currentRow == @"" || ![currentRow isKindOfClass:[NSString class]]) {
                emptyColCount++;
            }
        }

        if (emptyColCount == CELL_COUNT_Y && x > 0 && x < (CELL_COUNT_Y - 1) ) {
            NSLog(@"drop column %i!!", x);
            for (int j = 0; j < CELL_COUNT_Y; j++) {
                NSMutableArray *currentLine = [boardItems objectAtIndex:j];
                [currentLine removeObjectAtIndex:x];

                if ( x < (CELL_COUNT_Y / 2)) {
                    NSMutableArray *newLine = [NSMutableArray arrayWithObject:@""];
                    [newLine addObjectsFromArray:currentLine];
                    [boardItems setObject:newLine atIndexedSubscript:j];
                } else {
                    NSMutableArray *newLine = [NSMutableArray arrayWithArray:currentLine];
                    [newLine addObject:@""];
                    [boardItems setObject:newLine atIndexedSubscript:j];
                }
            }
        }

//        NSLog(@"empty for %i count: %i", x, emptyColCount);
    }
}

- (void) pushLineIntoBoardItems:(NSArray *) items {
    // check top level
    for (NSString *item in [boardItems objectAtIndex:(CELL_COUNT_Y - 1)]) {
        if ([item isKindOfClass:[NSString class]] && ![item isEqual:@""]) {
            [self.delegate brainBoardIsFull:boardItems];
            return;
        }
    }

    for (int i = (CELL_COUNT_Y - 1); i >= 1 ; i--) {
        NSMutableArray *val = [boardItems objectAtIndex:(i - 1)];
        [boardItems setObject:val atIndexedSubscript:i];
    }
    
    [boardItems setObject:items atIndexedSubscript:0];
}

- (NSString *) generateRandomElement {
    return [boardElementsEnum objectAtIndex:(arc4random() % [boardElementsEnum count])];
}

- (void) generatePreviewItemElement {
    if ([previewBoardItems count] == CELL_COUNT_X) {
        if (self.delegate) {
            [self.delegate brainPreviewBoardIsFull:[self getPreviewBoardItems]];
        }
        
        previewBoardItems = nil;
        previewBoardItems = [[NSMutableArray alloc] init];
    }
    
    [previewBoardItems addObject:[self generateRandomElement]];
}

- (BOOL) similarCellsWithCoordinateX:(int)x andY:(int)y {
    NSString *cellValue = [boardItems objectAtRow:y andColumn:x];

    if (![cellValue isKindOfClass:[NSString class]]) return NO;

    // Searching similar blocks
    similarCell = nil;
    similarCell = [[NSMutableSet alloc] init];

    [self loopingOfCellX:x andY:y andValue:cellValue inArray:boardItems];

    if ([similarCell count] < MIN_SIMILAR_BLOCKS) return NO;

    // remove blocks
    for (NSValue *value in similarCell) {
        [boardItems setObjectValue:@"" atRow:value.CGPointValue.y andColumn:value.CGPointValue.x];
        removedBlocks++;
    }

    [self calculateScoreWithCellCount:[similarCell count]];
    [self restructureBoardItemsWithCells:similarCell];

    return YES;
}

- (void) loopingOfCellX: (int) x andY: (int) y andValue: (NSString *) cellValue inArray: (NSMutableArray *)array {
    // Cell is not equal!
    if ([[array objectAtRow:y andColumn:x] isEqual:cellValue] == NO)
        return;

    CGPoint coords = CGPointMake(x, y);
    NSValue *valueCoords = [NSValue valueWithCGPoint:coords];

    if ([similarCell containsObject:valueCoords]) return;

    // Add cell
    [similarCell addObject:valueCoords];

    if (x - 1 >= 0)
        [self loopingOfCellX:(x - 1) andY:y andValue:cellValue inArray:array];

    if (x + 1 < CELL_COUNT_X)
        [self loopingOfCellX:(x + 1) andY:y andValue:cellValue inArray:array];

    if (y - 1 >= 0)
        [self loopingOfCellX:x andY:(y - 1) andValue:cellValue inArray:array];

    if (y + 1 < CELL_COUNT_Y)
        [self loopingOfCellX:x andY:(y + 1) andValue:cellValue inArray:array];
}

- (void) calculateScoreWithCellCount: (int) count {
    int bonus = 2;
    if (count >= 5 && count < 7) {
        bonus = 3;
    } else if (count >= 7 && count < 10) {
        bonus = 4;
    } else if (count == 10) {
        bonus = 5;
    } else if (count == 11) {
        bonus = 6;
    } else if (count >= 12) {
        bonus = 8;
    }

    scores += count * bonus;
    subtotalScores += count * bonus;
    if (subtotalScores >= SCORE_RANGE) {
        NSLog(@"nulls %i > $i", subtotalScores, SCORE_RANGE);
        subtotalScores = subtotalScores - SCORE_RANGE;
        subtotalSpeed = SUBTOTAL_SPEED_DEFAULT;
        taps += TAPS_DEFAULT;
        speed = SPEED_DEFAULT;
        [self.delegate brainSppedChanged:speed];
    }

    if (subtotalSpeed < (subtotalScores / (float) SCORE_RANGE)) {
        speed += SUBTOTAL_SPEED_DEFAULT;
        subtotalSpeed += SUBTOTAL_SPEED_DEFAULT;
        [self.delegate brainSppedChanged:speed];
    }
}

- (void) tapDecrement {
    taps--;
    if (taps == 0) {
        [self.delegate brainTapIsEnd];
    }
}

@end
