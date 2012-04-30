//
//  CategoryLoaderTests.m
//  RestKitTests
//
//  Created by Colin Harris on 30/04/12.
//  Copyright (c) 2012 Lambda Software. All rights reserved.
//

#import "CategoryLoaderTests.h"
#import "Category.h"
#import "Category+Additions.h"

@implementation CategoryLoaderTests

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

- (void)testCategoryObjectLoader
{
	RKObjectMappingProvider *mappingProvider = [RKObjectMappingProvider new];
    
    // Either of these will work!
//    [mappingProvider setObjectMapping:[Category objectMapping] forResourcePathPattern:@"/categories/:categoryID"];
    [mappingProvider setObjectMapping:[Category objectMapping] forKeyPath:@"category"];    
    
	RKURL *URL = [RKURL URLWithBaseURLString:@"http://localhost:4567" resourcePath:@"/categories/1"];
	RKObjectLoader *loader = [RKObjectLoader loaderWithURL:URL mappingProvider:mappingProvider];
	
	RKTestResponseLoader *responseLoader = [RKTestResponseLoader new];
    responseLoader.timeout = 10;
	loader.delegate = responseLoader;
    [loader sendAsynchronously];
	[responseLoader waitForResponse];
	STAssertTrue([responseLoader wasSuccessful], @"Expected 200 response");
	STAssertTrue([responseLoader.objects count] == 1, @"Expected to load one category");
}

- (void)testCategoriesObjectLoader
{
	RKObjectMappingProvider *mappingProvider = [RKObjectMappingProvider new];
    
    // Either of these will work!
    //    [mappingProvider setObjectMapping:[Category objectMapping] forResourcePathPattern:@"/categories/:categoryID"];
    [mappingProvider setObjectMapping:[Category objectMapping] forKeyPath:@"category"];    
    
	RKURL *URL = [RKURL URLWithBaseURLString:@"http://localhost:4567" resourcePath:@"/categories"];
	RKObjectLoader *loader = [RKObjectLoader loaderWithURL:URL mappingProvider:mappingProvider];
	
	RKTestResponseLoader *responseLoader = [RKTestResponseLoader new];
    responseLoader.timeout = 10;
	loader.delegate = responseLoader;
    [loader sendAsynchronously];
	[responseLoader waitForResponse];
	STAssertTrue([responseLoader wasSuccessful], @"Expected 200 response");
	STAssertTrue([responseLoader.objects count] == 2, @"Expected to load two categories");
}

@end
