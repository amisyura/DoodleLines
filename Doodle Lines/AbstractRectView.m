//
//  AbstractRectView.m
//  Doodle Lines
//
//  Created by Andrey Misura on 02.01.13.
//  Copyright (c) 2013 Andrey Misura. All rights reserved.
//

#import "AbstractRectView.h"
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

@implementation AbstractRectView

@synthesize board;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andBorderColor:(UIColor *)penColor {
    if(self = [self initWithFrame:frame]) {
        color = penColor;
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    int width = self.frame.size.width;
    int height = self.frame.size.height;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [color CGColor]);
    CGContextSetLineWidth(context, STROKE_WIDTH);
    
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, 1, 1);
    CGContextAddLineToPoint(context, width-1, 1);
    CGContextAddLineToPoint(context, width-1, height -1);
    CGContextAddLineToPoint(context, 1, height-1);
    
    CGContextClosePath(context);
    
    CGContextStrokePath(context);
    
    if ([self.board count]) {
        int rowCount = [self.board count];
        if (rowCount == 0) return;

        int originX = paddingX;
        int originY = self.frame.size.height;

        for (int y = 0; y < rowCount; y++) {
            originY -= CELL_HEIGHT;
            NSArray *currentRow = [self.board objectAtIndex:y];

            int columnCount = [currentRow count];
            originX = paddingX;
            for (int x = 0; x < columnCount; x++) {
                NSString *currentCell = [currentRow objectAtIndex:x];

//                NSLog(@"DEBUG: %i %i", originX, originY);
                if ([currentCell isKindOfClass:[NSString class]] && ![currentCell isEqual:@""]) {
                    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", currentCell]];
                    CGRect cellRect = CGRectMake(originX, originY, CELL_WIDTH, CELL_HEIGHT);
                    CGContextDrawImage(context, cellRect, image.CGImage);
//                    NSLog(@"%i %i", originX, originY);
                }

                originX += CELL_WIDTH;
            }
        }
    }
}


@end

