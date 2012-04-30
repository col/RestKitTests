//
//  Category+Additions.m
//  RestKitTests
//
//  Created by Colin Harris on 30/04/12.
//  Copyright (c) 2012 Lambda Software. All rights reserved.
//

#import "Category+Additions.h"

@implementation Category (Additions)

+ (void)registerMappings
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    
    // Object Mapping
    [objectManager.mappingProvider setObjectMapping:[Category objectMapping] forKeyPath:@"category"];    
    
    // Serilization Mapping - not yet supported
//    [objectManager.mappingProvider setSerializationMapping:[Category serializationMapping] forClass:[Category class]];
    
    // Routes
//    [objectManager.router routeClass:[Category class] toResourcePath:@"/categories" forMethod:RKRequestMethodPOST];    
    [objectManager.router routeClass:[Category class] toResourcePath:@"/categories/:categoryID" forMethod:RKRequestMethodGET];
//    [objectManager.router routeClass:[Category class] toResourcePath:@"/categories/:categoryID" forMethod:RKRequestMethodPUT];    
//    [objectManager.router routeClass:[Category class] toResourcePath:@"/categories/:categoryID" forMethod:RKRequestMethodDELETE];        
}

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

+ (RKObjectMapping *)serializationMapping
{
    RKObjectMapping* mapping = [[Category objectMapping] inverseMapping];
    [[RKObjectManager sharedManager].mappingProvider setSerializationMapping:mapping forClass:[Category class]];    
    return mapping;
}

@end
