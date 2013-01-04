//
//  NSMutableArray+MultidimensionalAdditions.m
//  Doodle Lines
//
//  Created by Andrey Misura on 02.01.13.
//  Copyright (c) 2013 Andrey Misura. All rights reserved.
//

#import "NSMutableArray+MultidimensionalAdditions.h"

@implementation NSMutableArray (MultidimensionalAdditions)

+ (NSMutableArray *) arrayOfRows:(NSInteger) rows andColumns:(NSInteger) columns {
    return [[self alloc] initWithRows:rows andColumns:columns];
}

- (id) initWithRows:(NSInteger) rows andColumns:(NSInteger) columns {
    if((self = [self initWithCapacity:rows])) {
        for(int i = 0; i < rows; i++) {
            NSMutableArray *inner = [[NSMutableArray alloc] initWithCapacity:columns];
            for(int j = 0; j < columns; j++)
                [inner addObject:[NSNull null]];
            [self addObject:inner];
        }
    }
    return self;
}

- (id) objectAtRow: (NSInteger) row andColumn: (NSInteger) column {
    NSArray *rowArray = [NSArray arrayWithArray:[self objectAtIndex:row]];

    return [rowArray objectAtIndex:column];
}

- (void) setObjectValue: (id) value atRow: (NSInteger) row andColumn: (NSInteger) column {
    NSMutableArray *rowArray = [NSMutableArray arrayWithArray:[self objectAtIndex:row]];

    [rowArray setObject:value atIndexedSubscript:column];
    [self setObject:rowArray atIndexedSubscript:row];
}

@end
