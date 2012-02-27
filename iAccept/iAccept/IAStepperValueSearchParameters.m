//
//  Created by Nicolas Desjardins on 12-02-06.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAStepperValueSearchParameters.h"
#import "IAStepperOperator.h"
#import "IAOperatorFactory.h"

@implementation IAStepperValueSearchParameters

@synthesize value = _value;

+(IAStepperValueSearchParameters*)initWithValue:(double)value {
    IAStepperValueSearchParameters* parameters = [[[IAStepperValueSearchParameters alloc] init] autorelease];
    [parameters setValue:value];
    return parameters;
}

-(BOOL)keepThisView:(UIView*)view {
    if ([view isKindOfClass:[UIStepper class]]) {
        IAStepperOperator* operator = (IAStepperOperator*)[IAOperatorFactory createOperatorForUIView:view];
        if ([operator value] == _value) {
            [self setViewOperator:operator];
            return YES;
        }
    }
    return NO;
}


@end
