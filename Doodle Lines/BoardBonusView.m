//
//  BoardBonusView.m
//  Doodle Lines
//
//  Created by Andrey Misura on 20.01.13.
//  Copyright (c) 2013 Andrey Misura. All rights reserved.
//

#import "BoardBonusView.h"

@implementation BoardBonusView

- (id) initWithFrame:(CGRect)frame andBonus:(int)bonus {
    self = [super initWithFrame:frame];
    if (self) {
        self.text = [NSString stringWithFormat:@"+%i", bonus];
        self.textColor = [UIColor blackColor];
        self.font = [self.font fontWithSize:30.0f];
        
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void) animateToLeft:(BOOL)toLeft andTop:(BOOL)toTop {
    CGRect frame = self.frame;
    
    if (toTop) {
        frame.origin.y += 20;
    } else {
        frame.origin.y -= 20;
    }
    
    if (toLeft) {
        frame.origin.x += 20;
    } else {
        frame.origin.x -= 20;
    }
    
    self.frame = frame;
    
    [UIView animateWithDuration:1.0f animations:^(void) {
        CGRect frame = self.frame;
        if (toLeft) {
            frame.origin.x += 20;
        } else {
            frame.origin.x -= 20;
        }
        
        if (toTop) {
            frame.origin.y += 20;
        } else {
            frame.origin.y -= 20;
        }
        
        frame.size.height *= 2;
        frame.size.width *= 2;
        
//        self.minimumFontSize = 25.;
        
        self.frame = frame;
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

@end
