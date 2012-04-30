//
//  RKTestFactory+AppExtensions.m
//  RestKitTests
//
//  Created by Colin Harris on 30/04/12.
//  Copyright (c) 2012 Lambda Software. All rights reserved.
//

#import "RKTestFactory+AppExtensions.h"
#import "AppDelegate.h"

@implementation RKTestFactory (AppExtensions)

// Perform any global initialization of your testing environment
+ (void)didInitialize
{
	// This is a great place to configure your test bundle
	NSBundle *testTargetBundle = [NSBundle bundleWithIdentifier:@"com.colharris.RestKitTestsTests"];
	[RKTestFixture setFixtureBundle:testTargetBundle];	    
    
    // Configure RestKit Logging        
    RKLogConfigureByName("RestKit", RKLogLevelTrace);
    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
    RKLogConfigureByName("RestKit/Network/Queue", RKLogLevelTrace);
    
    //Enable verbose logging for the App component. 
    RKLogSetAppLoggingLevel(RKLogLevelTrace);     
}

// Perform any actions you'd like to occur when [RKTestFactory setUp] is invoked
+ (void)didSetUp
{         
	// Clear the cache between tests
	[RKTestFactory clearCacheDirectory];
    
    // Create a new object manager
    RKObjectManager *objectManager = [RKTestFactory objectManager];
    
    // Create a new object store
    RKManagedObjectStore *objectStore = [RKTestFactory managedObjectStore];
    [objectManager setObjectStore:objectStore];
    
    NSLog(@"didSetUp");
}

// Perform any actions you'd like to occur when [RKTestFactory tearDown] is invoked
+ (void)didTearDown
{
    // no nothing
    NSLog(@"didTearDown");
}

// Add a new method that returns an Article
+ (Category *)category
{
	[RKTestFactory managedObjectStore];
	Category *category = [Category createEntity];
	category.name = @"Default Category";	
	return category;
}

@end
