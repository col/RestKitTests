//
//  Item+Additions.h
//  RestKitTests
//
//  Created by Colin Harris on 30/04/12.
//  Copyright (c) 2012 Lambda Software. All rights reserved.
//

#import "Item.h"
#import <RestKit/RestKit.h>

@interface Item (Additions)

+ (void)registerMappings;

+ (RKObjectMapping *)objectMapping;

+ (RKObjectMapping *)serializationMapping;

@end
