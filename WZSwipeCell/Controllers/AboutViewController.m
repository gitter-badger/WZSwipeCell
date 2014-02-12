//
//  AboutViewController.m
//  WZSwipeCell
//
//  Created by Waqar Zahour on 2/11/14.
//  Copyright (c) 2014 Waqar Zahour. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    self.title = @"About";
    
    // get the current version
	NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    self.lblVersionNumber.text = [NSString stringWithFormat:@"Version %@",currentVersion];
}



@end
