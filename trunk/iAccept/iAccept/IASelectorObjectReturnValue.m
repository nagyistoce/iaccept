//
//  Created by Pascal Roy on 12-01-23.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IASelectorObjectReturnValue.h"

@implementation IASelectorObjectReturnValue

@synthesize value;

-(id) initWithValue : (NSObject*) aValue {
    self = [super init];
    if (self) {
        self.value = aValue;
    }
    return self;
}

-(void)dealloc {
    [value release];
    [super dealloc];
}


@end
