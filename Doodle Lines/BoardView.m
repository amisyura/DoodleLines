//
//  BoardView.m
//  Doodle Lines
//
//  Created by Andrey Misura on 02.01.13.
//  Copyright (c) 2013 Andrey Misura. All rights reserved.
//

#import "BoardView.h"

@implementation BoardView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        paddingY = 7;
        paddingX = 2;
    }
    return self;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.delegate boardViewTouchesEnded:touches withEvent:event];
}

@end
