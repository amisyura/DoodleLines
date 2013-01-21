//
//  AbstractCellView.m
//  Doodle Lines
//
//  Created by Andrey Misura on 21.01.13.
//  Copyright (c) 2013 Andrey Misura. All rights reserved.
//

#import "AbstractCellView.h"

@implementation AbstractCellView

- (NSString *) getImageName {
    return @"";
}

- (id) init {
    self = [super init];

    if (self) {
        self.frame = CGRectMake(0, 0, 29, 29);
        self.image = [UIImage imageNamed:[self getImageName]];
    }

    return self;
}

@end
