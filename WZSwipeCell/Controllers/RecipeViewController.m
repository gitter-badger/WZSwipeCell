//
//  RecipeViewController.m
//  WZSwipeCell
//
//  Created by Waqar Zahour on 2/7/14.
//  Copyright (c) 2014 Waqar Zahour. All rights reserved.
//

#import "RecipeViewController.h"
#import "LeftGestureView.h"

#import "AboutViewController.h"

@interface RecipeViewController ()

@end

@implementation RecipeViewController

#pragma mark -
#pragma mark Initialization and Deallocation
#pragma mark -
- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) dealloc
{
    [_recipiesArray release];
    [_recipeTableView release];
    
    [_previousIndexPath release];
    
    [_tap release];
    [super dealloc];
}

#pragma mark -
#pragma mark View Life Cycle
#pragma mark -
- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self configureCustomUILayout];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Setup User Interface
#pragma mark -
- (void) configureCustomUILayout
{
    self.title = @"Recipe";
    
    NSString *thePath = [[NSBundle mainBundle]  pathForResource:@"Recipe" ofType:@"plist"];
	self.recipiesArray = [[[NSArray alloc] initWithContentsOfFile:thePath] autorelease];
    
    self.tap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnTableView:)] autorelease];
    [self.recipeTableView addGestureRecognizer:self.tap];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"About" style:UIBarButtonItemStyleDone target:self action:@selector(aboutScreen:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    [rightButton release];
}

#pragma mark -
#pragma mark TableView Delegates and DataSource
#pragma mark -
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.recipiesArray count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* MyIdentifier = @"RecipeCellIdentifier";
    
    RecipeCell * cell = (RecipeCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"RecipeCell" owner:self options:nil];
        cell = [nibs objectAtIndex:0];
        
    }
    
    // Configure the cell...
    cell.delegate = self;
	cell.indexPath = indexPath;
    cell.lblRecipeName.text = [self.recipiesArray objectAtIndex:indexPath.row];
    return cell;
    
    
}

- (CGFloat) tableView:(UITableView *) tableView heightForRowAtIndexPath:(NSIndexPath *) indexPath {
    
    return 50;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark Recipe Cell Delegate
#pragma mark -
- (NSIndexPath*) getPreviousExpandCellIndexPath
{
    return self.previousIndexPath;
}

- (void) setPreviousExpandCellIndexPath:(NSIndexPath*)indexPath
{
    self.previousIndexPath = indexPath;
}


#pragma mark -
#pragma mark - Tap On TableView
#pragma mark -
/**
 Cell Left View is off the screen button action not get so get the touch coordinate on the hit target (Button)
 @ModifiedDate: Feb 10, 2014
 @Version:1.0
 @Author: (Waqar Zahour)
 */
- (void) didTapOnTableView:(UIGestureRecognizer*) recognizer {
    
    CGPoint tapLocation = [recognizer locationInView:self.recipeTableView];
    NSIndexPath *indexPath = [self.recipeTableView indexPathForRowAtPoint:tapLocation];
    
    if (indexPath)
    {
        // we are in a tableview cell, let the gesture be handled by the view
        recognizer.cancelsTouchesInView = NO;
    }
    
    if ([indexPath compare:self.previousIndexPath] != NSOrderedSame)
    {
        return;
    }
    
    RecipeCell *recipeCell = (RecipeCell*) [self.recipeTableView cellForRowAtIndexPath:self.previousIndexPath];
    LeftGestureView *leftGestureView = [recipeCell leftGestureView];
    
    CGRect gestureRect = [recipeCell convertRect:leftGestureView.frame toView:self.recipeTableView];

    if (CGRectContainsPoint(gestureRect, tapLocation))
    {
        CGRect shareRect   = [leftGestureView convertRect:leftGestureView.btnShare.frame toView:self.recipeTableView];
        CGRect starRect   = [leftGestureView convertRect:leftGestureView.btnStar.frame toView:self.recipeTableView];
        CGRect trashRect = [leftGestureView convertRect:leftGestureView.btnTrash.frame toView:self.recipeTableView];
        
        if (CGRectContainsPoint(shareRect, tapLocation))
        {
            // Customize the Button Event
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:recipeCell.lblRecipeName.text
                                      message:@"Share Button Clicked"
                                      delegate:self
                                      cancelButtonTitle: nil
                                      otherButtonTitles:@"OK", nil];
            [alertView show];
            [alertView release];
        }
        else if (CGRectContainsPoint(starRect, tapLocation))
        {
            // Customize the Button Event
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:recipeCell.lblRecipeName.text
                                      message:@"Star Button Clicked"
                                      delegate:self
                                      cancelButtonTitle: nil
                                      otherButtonTitles:@"OK", nil];
            [alertView show];
            [alertView release];
        }
        else if (CGRectContainsPoint(trashRect, tapLocation))
        {
            // Customize the Button Event
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:recipeCell.lblRecipeName.text
                                      message:@"Trash Button Clicked"
                                      delegate:self
                                      cancelButtonTitle: nil
                                      otherButtonTitles:@"OK", nil];
            [alertView show];
            [alertView release];
        }
        
    }
}

#pragma mark -
#pragma mark - About Selector
#pragma mark -
- (void) aboutScreen:(id) sender
{
    AboutViewController *aboutController = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    [self.navigationController pushViewController:aboutController animated:YES];
    [aboutController release];
}


@end
