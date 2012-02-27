//
//  Created by Pascal Roy on 11-11-08.
//  Copyright 2011 Elapse Technologies. All rights reserved.
//

#import "IAOperator.h"
#import "IAIsEqualTo.h"

id isEqualTo(NSObject* aTargetObject) {
    return [[IAIsEqualTo alloc] initWithObject:aTargetObject];
}

id isEqualToWithMessage(NSObject* aTargetObject, NSString* aMessage) {
    return [[IAIsEqualTo alloc] initWithObject:aTargetObject errorMessage : aMessage];
}

