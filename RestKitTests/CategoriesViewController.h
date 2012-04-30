//
//  CategoriesViewController.h
//  RestKitTests
//
//  Created by Colin Harris on 29/04/12.
//  Copyright (c) 2012 Lambda Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

@interface CategoriesViewController : UITableViewController <RKObjectLoaderDelegate>

@property (nonatomic, retain) NSArray *objects;

@end
