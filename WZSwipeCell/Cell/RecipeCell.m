//
//  CustomCell.m
//  WZSwipeCell
//
//  Created by Waqar Zahour on 2/7/14.
//  Copyright (c) 2014 Waqar Zahour. All rights reserved.
//

#import "RecipeCell.h"



@implementation RecipeCell


#pragma mark -
#pragma mark Intialization and Deallocation
#pragma mark -
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) awakeFromNib
{
    UIGestureRecognizer* recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    recognizer.delegate = self;
    [self addGestureRecognizer:recognizer];
    
    // Set The Left View Off the Screen
    CGRect gestureFrame = self.leftGestureView.frame;
    gestureFrame.origin.x =  -LEFT_GESTURE_VIEW_WIDTH;
    self.leftGestureView.frame =  gestureFrame;
    
    self.clipsToBounds = NO;
    self.contentView.clipsToBounds = NO;
    [self.contentView.superview setClipsToBounds:NO];
}

- (void) dealloc
{
    [_lblRecipeName release];
    [_leftGestureView release];
    [super dealloc];
}

#pragma mark -
#pragma mark Setup User Interface
#pragma mark -

- (void) setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark -
#pragma mark - horizontal pan gesture methods
#pragma mark -
- (BOOL) gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    
    if([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]])
    {
        return NO;
    }
    CGPoint translation = [gestureRecognizer translationInView:[self superview]];
    
    // Check for horizontal gesture
    if (fabsf(translation.x) > fabsf(translation.y)) {
        return YES;
    }
    return NO;
}

- (void) handlePan:(UIPanGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
		// if the gesture has just started, record the current centre location
        _originalCenter = self.center;
    }
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        // translate the center
        CGPoint translation = [recognizer translationInView:self];
        
        // Restrict the cell to right gesture
        if (translation.x < 0 && self.frame.origin.x <= 0) {
            return;
        }

        self.center = CGPointMake(_originalCenter.x + translation.x, _originalCenter.y);
        
        // determine whether the item has been dragged far enough to initiate a complete
        _markCompleteOnDragRelease = self.frame.origin.x > self.frame.size.width / 10;
        
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        if (!_markCompleteOnDragRelease) {
            // if the item is not being deleted, snap back to the original location
            [UIView animateWithDuration:0.2
                             animations:^{
                                 
                                 self.frame = [self moveToOrigin:self];
                             }
             ];
        }
        if (_markCompleteOnDragRelease) {
            
            if ([self.indexPath compare:[self.delegate getPreviousExpandCellIndexPath]] != NSOrderedSame)
            {
                // mark the item as complete and update the UI state
                
                UITableView *tableView = (UITableView*)[[self superview] superview];
                RecipeCell *previousCell = (RecipeCell*)[tableView cellForRowAtIndexPath:[self.delegate getPreviousExpandCellIndexPath]];
                
                [UIView animateWithDuration:0.2
                                 animations:^{
                                     
                                     previousCell.frame = [self moveToOrigin:previousCell];
                                     self.frame = [self moveToLeft:self];
                                 }
                 ];
                
                [self.delegate setPreviousExpandCellIndexPath:self.indexPath];
            }
            else
            {
                [UIView animateWithDuration:0.2
                                 animations:^{
                                     
                                     self.frame = [self moveToLeft:self];
                                 }
                 ];
            }
        }
    }
}

#pragma mark -
#pragma mark - Cell Swipe / Origin Frame
#pragma mark -
- (CGRect) moveToLeft:(RecipeCell*)cell
{
    return CGRectMake(LEFT_GESTURE_VIEW_WIDTH, cell.frame.origin.y,cell.bounds.size.width, cell.bounds.size.height);
}

- (CGRect) moveToOrigin:(RecipeCell*)cell
{
    return CGRectMake(0, cell.frame.origin.y,cell.bounds.size.width, cell.bounds.size.height);
}
@end
