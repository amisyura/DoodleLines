//
//  AbstractCellView.h
//  Doodle Lines
//
//  Created by Andrey Misura on 21.01.13.
//  Copyright (c) 2013 Andrey Misura. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AbstractCellViewProtocol <NSObject>

- (NSString *) getImageName;

@end

@interface AbstractCellView : UIImageView <AbstractCellViewProtocol>

@end