//
//  ObjectMappingTests.m
//  RestKitTests
//
//  Created by Colin Harris on 30/04/12.
//  Copyright (c) 2012 Lambda Software. All rights reserved.
//

#import "ObjectMappingTests.h"
#import "Category.h"
#import "Category+Additions.h"
#import "Item.h"
#import "Item+Additions.h"

@implementation ObjectMappingTests

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

- (void)testCategoryObjectMapping
{
	id parsedJSON = [RKTestFixture parsedObjectWithContentsOfFixture:@"category_partial.json"];
	RKMappingTest *test = [RKMappingTest testForMapping:[Category objectMapping] object:parsedJSON];
	[test expectMappingFromKeyPath:@"id" toKeyPath:@"categoryID" withValue:[NSNumber numberWithInt:1]];
	[test expectMappingFromKeyPath:@"name" toKeyPath:@"name" withValue:@"Test Category"];    
	STAssertNoThrow([test verify], nil);
}

- (void)testItemObjectMapping
{
	id parsedJSON = [RKTestFixture parsedObjectWithContentsOfFixture:@"item_partial.json"];
	RKMappingTest *test = [RKMappingTest testForMapping:[Item objectMapping] object:parsedJSON];    
	[test expectMappingFromKeyPath:@"id" toKeyPath:@"itemID" withValue:[NSNumber numberWithInt:1]];
	[test expectMappingFromKeyPath:@"category_id" toKeyPath:@"categoryID" withValue:[NSNumber numberWithInt:1]];    
	[test expectMappingFromKeyPath:@"name" toKeyPath:@"name" withValue:@"Test Item"];    
	[test expectMappingFromKeyPath:@"price" toKeyPath:@"price"];            
	STAssertNoThrow([test verify], nil);
}

@end
