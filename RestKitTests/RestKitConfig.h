//
//  RestKitConfig.h
//  RestKitTests
//
//  Created by Colin Harris on 29/04/12.
//  Copyright (c) 2012 Lambda Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface RestKitConfig : NSObject

//@property (nonatomic, retain) RKManagedObjectMapping* categoryObjectMapping;
//@property (nonatomic, retain) RKManagedObjectMapping* itemObjectMapping;

//@property (nonatomic, retain) RKManagedObjectStore* objectStore;

+ (RestKitConfig*)sharedConfig;

//+ (RKManagedObjectMapping *)categoryObjectMapping;

@end
