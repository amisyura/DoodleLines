//
//  AbstractRectView.h
//  Doodle Lines
//
//  Created by Andrey Misura on 02.01.13.
//  Copyright (c) 2013 Andrey Misura. All rights reserved.
//

#import <UIKit/UIKit.h>

#define STROKE_WIDTH 3.0
#define CELL_WIDTH 30.5f
#define CELL_HEIGHT 29.1

@interface AbstractRectView : UIView {
    UIColor *color;
    double paddingY;
    double paddingX;
}

@property (strong, nonatomic) NSArray *board;

- (id) initWithFrame:(CGRect)frame andBorderColor: (UIColor *) penColor;

@end
