//
//  LeftGestureView.m
//  WZSwipeCell
//
//  Created by Waqar Zahour on 2/7/14.
//  Copyright (c) 2014 Waqar Zahour. All rights reserved.
//

#import "LeftGestureView.h"

@implementation LeftGestureView

#pragma mark -
#pragma mark Intialization and Deallocation
#pragma mark -
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) dealloc
{
    [_btnShare release];
    [_btnStar release];
    [_btnTrash release];
    [super dealloc];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
