//
//  ViewController.m
//  RestKitTests
//
//  Created by Colin Harris on 29/04/12.
//  Copyright (c) 2012 Lambda Software. All rights reserved.
//

#import "ViewController.h"
#import "CategoriesViewController.h"
#import "ItemsViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"Menu";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)viewCategories:(id)sender
{
    CategoriesViewController *controller = [[[CategoriesViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)viewItems:(id)sender
{
    ItemsViewController *controller = [[[ItemsViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    [self.navigationController pushViewController:controller animated:YES];    
}

@end
