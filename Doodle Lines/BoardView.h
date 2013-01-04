//
//  BoardView.h
//  Doodle Lines
//
//  Created by Andrey Misura on 02.01.13.
//  Copyright (c) 2013 Andrey Misura. All rights reserved.
//

#import "AbstractRectView.h"

@class BoardView;

@protocol BoardViewDelegate <NSObject>

@optional
- (void) boardViewTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

@end

@interface BoardView : AbstractRectView

@property (nonatomic, assign) id<BoardViewDelegate> delegate;

@end
