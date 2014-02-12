//
//  RecipeViewController.h
//  WZSwipeCell
//
//  Created by Waqar Zahour on 2/7/14.
//  Copyright (c) 2014 Waqar Zahour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeCell.h"

@interface RecipeViewController : UIViewController <RecipeCellDelegate> {
    
}

@property (retain , nonatomic) IBOutlet UITableView *recipeTableView;
@property (retain , nonatomic) NSArray *recipiesArray;
@property (retain , nonatomic) UITapGestureRecognizer *tap;

// To track back the Left Gesture View to Original Position
@property (retain , nonatomic) NSIndexPath * previousIndexPath;

@end
