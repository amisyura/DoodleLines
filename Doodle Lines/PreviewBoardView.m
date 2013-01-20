//
//  PreviewBoardView.m
//  Doodle Lines
//
//  Created by Andrey Misura on 02.01.13.
//  Copyright (c) 2013 Andrey Misura. All rights reserved.
//

#import "PreviewBoardView.h"

@implementation PreviewBoardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        paddingY = -5;
        paddingX = 1;
    }
    return self;
}

@end
