//
//  Item+Additions.m
//  RestKitTests
//
//  Created by Colin Harris on 30/04/12.
//  Copyright (c) 2012 Lambda Software. All rights reserved.
//

#import "Item+Additions.h"
#import "Category.h"
#import "Category+Additions.h"

@implementation Item (Additions)

+ (void)registerMappings
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];

    // Object Mapping
    [objectManager.mappingProvider setObjectMapping:[Item objectMapping] forKeyPath:@"item"];    
    
    // Serilization Mapping
    [objectManager.mappingProvider setSerializationMapping:[Item serializationMapping] forClass:[Item class]];

    // Routes
    [objectManager.router routeClass:[Item class] toResourcePath:@"/items" forMethod:RKRequestMethodPOST];    
    [objectManager.router routeClass:[Item class] toResourcePath:@"/items/:itemID" forMethod:RKRequestMethodGET];
    [objectManager.router routeClass:[Item class] toResourcePath:@"/items/:itemID" forMethod:RKRequestMethodPUT];    
    [objectManager.router routeClass:[Item class] toResourcePath:@"/items/:itemID" forMethod:RKRequestMethodDELETE];        
}

+ (RKObjectMapping *)objectMapping
{
    RKManagedObjectMapping* mapping = [RKManagedObjectMapping mappingForClass:[Item class] inManagedObjectStore:[RKObjectManager sharedManager].objectStore];
    mapping.primaryKeyAttribute = @"itemID";
    mapping.rootKeyPath = @"item";                
    [mapping mapKeyPathsToAttributes:
     @"id", @"itemID",
     @"category_id", @"categoryID",         
     @"name", @"name",
     @"price", @"price",         
     nil];   
    
    // Category (to one relationship)
    [mapping mapKeyPath:@"category" toRelationship:@"category" withMapping:[Category objectMapping]];
    [mapping connectRelationship:@"category" withObjectForPrimaryKeyAttribute:@"categoryID"];
    
    return mapping;
}

+ (RKObjectMapping *)serializationMapping
{
    RKObjectMapping *mapping = [[Item objectMapping] inverseMapping];
    [[RKObjectManager sharedManager].mappingProvider setSerializationMapping:mapping forClass:[Item class]];
    return mapping;
}

@end
