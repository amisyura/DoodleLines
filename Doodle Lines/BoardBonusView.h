//
//  BoardBonusView.h
//  Doodle Lines
//
//  Created by Andrey Misura on 20.01.13.
//  Copyright (c) 2013 Andrey Misura. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoardBonusView : UILabel

- (id) initWithFrame:(CGRect) frame andBonus: (int) bonus;
- (void) animateToLeft: (BOOL) toLeft andTop: (BOOL) toTop;

@end
