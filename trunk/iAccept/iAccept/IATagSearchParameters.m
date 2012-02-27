//
//  Created by Nicolas Desjardins on 12-01-26.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IATagSearchParameters.h"
#import "IAOperatorFactory.h"

@implementation IATagSearchParameters

@synthesize tag = _tag;

+(IATagSearchParameters*) initWithTag:(int)tag {
    IATagSearchParameters* parameters = [[[IATagSearchParameters alloc] init] autorelease];
    [parameters setTag:tag];
    return parameters;
}

-(BOOL)keepThisView:(UIView*)view {
    if ([view tag] == _tag) {
        [self setViewOperator:[IAOperatorFactory createOperatorForUIView:view]];
        return YES;
    }
    return NO;
}
@end
