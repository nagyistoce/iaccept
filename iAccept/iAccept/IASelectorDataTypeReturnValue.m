//
//  Created by Pascal Roy on 12-01-23.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IASelectorDataTypeReturnValue.h"

@implementation IASelectorDataTypeReturnValue

@synthesize value;

-(id)initWithValue : (void*) aValue {
    self = [super init];
    if (self) {
        value = aValue;
    }
    return self;
}

-(void)dealloc {
    free(value);
    [super dealloc];
}

@end
