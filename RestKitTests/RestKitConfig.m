//
//  RestKitConfig.m
//  RestKitTests
//
//  Created by Colin Harris on 29/04/12.
//  Copyright (c) 2012 Lambda Software. All rights reserved.
//

#import "RestKitConfig.h"
#import "Category.h"
#import "Category+Additions.h"
#import "Item.h"
#import "Item+Additions.h"

@interface RestKitConfig ()
- (void)configureRestKit;
@end

@implementation RestKitConfig

static RestKitConfig *sharedConfig = nil;

//@synthesize categoryObjectMapping;
//@synthesize itemObjectMapping;
//@synthesize objectStore;

NSString* const BaseURL = @"http://localhost:3000";

- (id)init 
{
    self = [super init];
    if( self )
    {
        [self configureRestKit];
    }
    return self;
}

+ (RestKitConfig*)sharedConfig
{
    if (sharedConfig == nil) {
        sharedConfig = [[super allocWithZone:NULL] init];
    }
    return sharedConfig;
}

- (void)configureRestKit
{    
    // Initialize the RestKit Object Manager
	RKObjectManager* objectManager = [RKObjectManager managerWithBaseURLString:BaseURL];    
    [objectManager setSerializationMIMEType:RKMIMETypeJSON];    

    // Create Object Store (without seed db)
    objectManager.objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:@"restkittests.sqlite"];
    
    // Set the cache strategy
    objectManager.objectStore.cacheStrategy = [RKInMemoryManagedObjectCache new];        

    // Register model mappings
    [Category registerMappings];    
    [Item registerMappings];
         
    // Configure RestKit Logging        
    RKLogConfigureByName("RestKit", RKLogLevelDebug);
    RKLogConfigureByName("RestKit/Network", RKLogLevelDebug);
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelDebug);
    RKLogConfigureByName("RestKit/Network/Queue", RKLogLevelDebug);
    
    //Enable verbose logging for the App component. 
    RKLogSetAppLoggingLevel(RKLogLevelDebug);    
}

#pragma mark - Singleton methods

+ (id)allocWithZone:(NSZone *)zone
{
    return [[self sharedConfig] retain];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;  //denotes an object that cannot be released
}

- (oneway void)release
{
    //do nothing
}

- (id)autorelease
{
    return self;
}

@end
