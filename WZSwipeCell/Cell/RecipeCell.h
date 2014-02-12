//
//  CustomCell.h
//  WZSwipeCell
//
//  Created by Waqar Zahour on 2/7/14.
//  Copyright (c) 2014 Waqar Zahour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftGestureView.h"

#define LEFT_GESTURE_VIEW_WIDTH 150

@protocol RecipeCellDelegate <NSObject>

- (NSIndexPath*) getPreviousExpandCellIndexPath;
- (void) setPreviousExpandCellIndexPath:(NSIndexPath*)indexPath;

@end


@interface RecipeCell : UITableViewCell <UIGestureRecognizerDelegate> {
	
    CGPoint _originalCenter;
    BOOL _markCompleteOnDragRelease;
}

@property (nonatomic , retain) NSIndexPath* indexPath;
@property (nonatomic , assign) id<RecipeCellDelegate> delegate;

@property (nonatomic , retain) IBOutlet UILabel  *lblRecipeName;
@property (nonatomic , retain) IBOutlet LeftGestureView  *leftGestureView;

- (CGRect) moveToLeft:(RecipeCell*)cell;
- (CGRect) moveToOrigin:(RecipeCell*)cell;
@end
