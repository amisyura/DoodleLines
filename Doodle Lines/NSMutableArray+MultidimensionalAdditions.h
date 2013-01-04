//
//  NSMutableArray+MultidimensionalAdditions.h
//  Doodle Lines
//
//  Created by Andrey Misura on 02.01.13.
//  Copyright (c) 2013 Andrey Misura. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (MultidimensionalAdditions)

+ (NSMutableArray *) arrayOfRows:(NSInteger) rows andColumns:(NSInteger) columns;

- (id) initWithRows:(NSInteger) rows andColumns:(NSInteger) columns;

- (id) objectAtRow: (NSInteger) row andColumn: (NSInteger) column;

- (void) setObjectValue: (id) value atRow: (NSInteger) row andColumn: (NSInteger) column;

@end
