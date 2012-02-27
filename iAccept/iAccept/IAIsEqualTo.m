//
//  Created by Pascal Roy on 11-11-08.
//  Copyright 2011 Elapse Technologies. All rights reserved.
//

#import "IAIsEqualTo.h"
#import "IAException.h"

@implementation IAIsEqualTo

@synthesize  targetObject;
@synthesize  errorMessage;

-(id) initWithObject : (NSObject*) aTargetObject errorMessage : (NSString*)anErrorMessage {
    self = [super init];
    if (self) {
        [self setTargetObject : aTargetObject];
        [self setErrorMessage : anErrorMessage];
    }
    return self;
}

-(id) initWithObject : (NSObject*) aTargetObject {
    return [self initWithObject : aTargetObject errorMessage : nil];
}

-(void) dealloc {
    [targetObject release];
    [errorMessage release];
    [super dealloc];
}

-(void) validateObjectsAreEqual : (NSObject*) sourceObject {
    if (![targetObject isEqual : sourceObject]) {
        NSString* exceptionReason;
        
        if (errorMessage) {
            exceptionReason = [NSString stringWithFormat : @"Expected %@, was %@ : %@", [targetObject description], [sourceObject description], errorMessage];            
        }
        else {
            exceptionReason = [NSString stringWithFormat : @"Expected %@, was %@", [targetObject description], [sourceObject description]];
        }
        [IAException raise: exceptionReason];
    }
}

-(void) operateOn : (NSObject*) sourceObject {
    [self validateObjectsAreEqual : sourceObject];
}

@end
