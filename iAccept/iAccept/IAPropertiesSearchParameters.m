//
//  Created by Nicolas Desjardins on 12-01-20.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAPropertiesSearchParameters.h"
#import "IAOperatorFactory.h"

@implementation IAPropertiesSearchParameters

@synthesize properties = _properties;

+(IAPropertiesSearchParameters*) initWithPropertiesToMatch:(NSDictionary*)properties {
    IAPropertiesSearchParameters* parameters = [[[IAPropertiesSearchParameters alloc] init] autorelease];
    [parameters setProperties:properties];
    return parameters;
}

-(BOOL)matchesAllPropertiesValues:(UIView*)view {
    NSEnumerator* keys = [_properties keyEnumerator];
    
    for (NSString* key in keys) {
        id value = [_properties valueForKey:key];
        id viewValue = [view valueForKey:key];
        if (![value isEqual:viewValue]) {
            return NO;
        }
    }
    return YES;
}

-(BOOL)keepThisView:(UIView*)view {
    if ([self matchesAllPropertiesValues:view]) {
        [self setViewOperator:[IAOperatorFactory createOperatorForUIView:view]];
        return YES;
    }
    return NO;
}

@end
