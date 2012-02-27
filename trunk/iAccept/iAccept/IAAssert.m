//
//  Created by Pascal Roy on 11-11-11.
//  Copyright 2011 Elapse Technologies. All rights reserved.
//

#import "IAAssert.h"
#import "IAIsEqualTo.h"
#import "IAException.h"

void IAAssertFail(NSString* errorMessage) {
    [IAException raise:[NSString stringWithFormat : @"%@", errorMessage]];
}

void IAAssertFalse(BOOL aValue, NSString* errorMessage) {
    if (aValue != FALSE) {
        [IAException raise:[NSString stringWithFormat : @"%@", errorMessage]];
    }
}

void IAAssertTrue(BOOL aValue, NSString* errorMessage) {
    if (aValue != TRUE) {
        [IAException raise:[NSString stringWithFormat : @"%@", errorMessage]];
    }
}

void IAAssertThat(NSObject* anObject, id<IAOperator> anOperator) {
    [anOperator operateOn : anObject];
}

