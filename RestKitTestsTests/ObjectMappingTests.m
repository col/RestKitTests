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
    // Create a dummy category
    Category *category = [Category object];
    category.categoryID = [NSNumber numberWithInt:1];
    category.name = @"Dummy Category";
    NSError *error = nil;
    [[category managedObjectContext] save:&error];
    
	id parsedJSON = [RKTestFixture parsedObjectWithContentsOfFixture:@"item_partial.json"];
	RKMappingTest *test = [RKMappingTest testForMapping:[Item objectMapping] object:parsedJSON];    
	[test expectMappingFromKeyPath:@"id" toKeyPath:@"itemID" withValue:[NSNumber numberWithInt:1]];
	[test expectMappingFromKeyPath:@"category_id" toKeyPath:@"categoryID" withValue:[NSNumber numberWithInt:1]];    
	[test expectMappingFromKeyPath:@"name" toKeyPath:@"name" withValue:@"Test Item"];    
	[test expectMappingFromKeyPath:@"price" toKeyPath:@"price"];
    // Category will be set to the 'Dummy Category' as it matches the foreign key
	[test expectMappingFromKeyPath:@"category" toKeyPath:@"category"];    
	STAssertNoThrow([test verify], nil);
}

- (void)testItemMappingWithCategoryForiegnKeyWithoutExistingCategory
{
	id parsedJSON = [RKTestFixture parsedObjectWithContentsOfFixture:@"item_partial.json"];
	RKMappingTest *test = [RKMappingTest testForMapping:[Item objectMapping] object:parsedJSON];    
	[test expectMappingFromKeyPath:@"id" toKeyPath:@"itemID" withValue:[NSNumber numberWithInt:1]];
	[test expectMappingFromKeyPath:@"category_id" toKeyPath:@"categoryID" withValue:[NSNumber numberWithInt:1]];    
	[test expectMappingFromKeyPath:@"name" toKeyPath:@"name" withValue:@"Test Item"];    
	[test expectMappingFromKeyPath:@"price" toKeyPath:@"price"];
    // Category will be set to nil as the foreign key doesn't exist
	[test expectMappingFromKeyPath:@"category" toKeyPath:@"category" withValue:nil];    
	STAssertNoThrow([test verify], nil);
}

- (void)testItemObjectMappingWithCategory
{   
	id parsedJSON = [RKTestFixture parsedObjectWithContentsOfFixture:@"item_partial_with_category.json"];
	RKMappingTest *test = [RKMappingTest testForMapping:[Item objectMapping] object:parsedJSON];    
	[test expectMappingFromKeyPath:@"id" toKeyPath:@"itemID" withValue:[NSNumber numberWithInt:1]];
	[test expectMappingFromKeyPath:@"name" toKeyPath:@"name" withValue:@"Test Item"];    
	[test expectMappingFromKeyPath:@"price" toKeyPath:@"price"];
    // Category will be loaded from category data embedded in the item JSON
    [test expectMappingFromKeyPath:@"category" toKeyPath:@"category"];        
	STAssertNoThrow([test verify], nil);
}
@end
