//
//  Category+Additions.m
//  RestKitTests
//
//  Created by Colin Harris on 30/04/12.
//  Copyright (c) 2012 Lambda Software. All rights reserved.
//

#import "Category+Additions.h"

@implementation Category (Additions)

+ (RKObjectMapping *)objectMapping
{
    RKManagedObjectMapping* mapping = [RKManagedObjectMapping mappingForClass:[Category class] inManagedObjectStore:[RKObjectManager sharedManager].objectStore];
    mapping.primaryKeyAttribute = @"categoryID";
    mapping.rootKeyPath = @"category";        
    [mapping mapKeyPathsToAttributes:
     @"id", @"categoryID",
     @"name", @"name",
     nil];
    return mapping;
}

@end
