//
//  ItemLoaderTests.m
//  RestKitTests
//
//  Created by Colin Harris on 30/04/12.
//  Copyright (c) 2012 Lambda Software. All rights reserved.
//

#import "ItemLoaderTests.h"
#import "Item.h"
#import "Item+Additions.h"

@implementation ItemLoaderTests

- (void)setUp
{
    [super setUp];
    
    [RKTestFactory setUp];
}

- (void)tearDown
{
    [RKTestFactory tearDown];    
    
    [super tearDown];
}

#pragma mark - The Hard Way

- (void)testItemObjectLoader
{
	RKObjectMappingProvider *mappingProvider = [RKObjectMappingProvider new];
    [mappingProvider setObjectMapping:[Item objectMapping] forKeyPath:@"item"];        
	RKURL *URL = [RKURL URLWithBaseURLString:@"http://localhost:4567" resourcePath:@"/items/1"];
	RKObjectLoader *loader = [RKObjectLoader loaderWithURL:URL mappingProvider:mappingProvider];
	
	RKTestResponseLoader *responseLoader = [RKTestResponseLoader new];
    responseLoader.timeout = 10;
	loader.delegate = responseLoader;
    [loader sendAsynchronously];
	[responseLoader waitForResponse];
	STAssertTrue([responseLoader wasSuccessful], @"Expected 200 response");
	STAssertTrue([responseLoader.objects count] == 1, @"Expected to load one item");
    
    // Validate the loaded object
    Item *item = (Item *)[responseLoader.objects objectAtIndex:0];
    STAssertTrue([item.name isEqualToString:@"Test Item"], @"Expected name to be 'Test Item'");
    STAssertTrue([item.price floatValue] == 9.99f, @"Expected price to be '9.99'");
}

- (void)testItemsObjectLoader
{
	RKObjectMappingProvider *mappingProvider = [RKObjectMappingProvider new];
    [mappingProvider setObjectMapping:[Item objectMapping] forKeyPath:@"item"];    
    
	RKURL *URL = [RKURL URLWithBaseURLString:@"http://localhost:4567" resourcePath:@"/items"];
	RKObjectLoader *loader = [RKObjectLoader loaderWithURL:URL mappingProvider:mappingProvider];
	
	RKTestResponseLoader *responseLoader = [RKTestResponseLoader new];
    responseLoader.timeout = 10;
	loader.delegate = responseLoader;
    [loader sendAsynchronously];
	[responseLoader waitForResponse];
	STAssertTrue([responseLoader wasSuccessful], @"Expected 200 response");
	STAssertTrue([responseLoader.objects count] == 2, @"Expected to load two items");
}

#pragma mark - The Easier Way

- (void)testItemGetFromResourcePath
{    
    [Item registerMappings];
    
	RKTestResponseLoader *responseLoader = [RKTestResponseLoader new];    
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/items/1" delegate:responseLoader];
    
	[responseLoader waitForResponse];
	STAssertTrue([responseLoader wasSuccessful], @"Expected 200 response");
	STAssertTrue([responseLoader.objects count] == 1, @"Expected to load one item");
    
    // Validate the loaded object
    Item *item = (Item *)[responseLoader.objects objectAtIndex:0];
    STAssertTrue([item.itemID intValue] == 1, @"Expected itemID to be 1");    
    STAssertTrue([item.name isEqualToString:@"Test Item"], @"Expected name to be 'Test Item'");
    STAssertTrue([item.price floatValue] == 9.99f, @"Expected price to be '9.99'");
}

- (void)testItemGetFromExistingObject
{    
    [Item registerMappings];
    
    Item *item = [Item object];
    item.itemID = [NSNumber numberWithInt:1];
    
	RKTestResponseLoader *responseLoader = [RKTestResponseLoader new];    
    [[RKObjectManager sharedManager] getObject:item delegate:responseLoader];

	[responseLoader waitForResponse];
	STAssertTrue([responseLoader wasSuccessful], @"Expected 200 response");
	STAssertTrue([responseLoader.objects count] == 1, @"Expected to load one item");
    
    // Validate the loaded object
    item = (Item *)[responseLoader.objects objectAtIndex:0];
    STAssertTrue([item.itemID intValue] == 1, @"Expected itemID to be 1");    
    STAssertTrue([item.name isEqualToString:@"Test Item"], @"Expected name to be 'Test Item'");
    STAssertTrue([item.price floatValue] == 9.99f, @"Expected price to be '9.99'");
}

- (void)testItemsGetIndex
{
    [Item registerMappings];
    
	RKTestResponseLoader *responseLoader = [RKTestResponseLoader new];    
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/items" delegate:responseLoader];

	[responseLoader waitForResponse];
	STAssertTrue([responseLoader wasSuccessful], @"Expected 200 response");
	STAssertTrue([responseLoader.objects count] == 2, @"Expected to load two items");
}

- (void)testItemPost
{   
    [Item registerMappings];
    
    Item *newItem = [Item object];
    newItem.name = @"New Item";
    newItem.price = [NSNumber numberWithFloat:100.0];    

    RKTestResponseLoader *responseLoader = [RKTestResponseLoader new];    
	[[RKObjectManager sharedManager] postObject:newItem delegate:responseLoader];
	[responseLoader waitForResponse];
    
	STAssertTrue([responseLoader wasSuccessful], @"Expected 200 response");
	STAssertTrue([responseLoader.objects count] == 1, @"Expected to load one item");        
}

- (void)testItemPostError
{   
    [Item registerMappings];
    
    Item *newItem = [Item object];
    newItem.name = nil;
    newItem.price = nil;    
    
    RKTestResponseLoader *responseLoader = [RKTestResponseLoader new];    
	[[RKObjectManager sharedManager] postObject:newItem delegate:responseLoader];
	[responseLoader waitForResponse];
    
	STAssertFalse([responseLoader wasSuccessful], @"Expected 422 response");    
    NSArray *errorMessages = [[responseLoader.error userInfo] valueForKey:RKObjectMapperErrorObjectsKey];
    STAssertNotNil(errorMessages, @"Expected some error messages");
    STAssertTrue([errorMessages count] == 2, @"Expected two error messages");
}

@end
