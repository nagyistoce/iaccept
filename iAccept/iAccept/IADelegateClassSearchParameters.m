//
//  Created by Nicolas Desjardins on 12-01-19.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IADelegateClassSearchParameters.h"
#import "IAOperatorFactory.h"

@implementation IADelegateClassSearchParameters

@synthesize clazz = _clazz;

+(IADelegateClassSearchParameters*) initWithDelegateClass:(Class)clazz {
    IADelegateClassSearchParameters* parameters = [[[IADelegateClassSearchParameters alloc] init] autorelease];
    [parameters setClazz:clazz];
    return parameters;
}

-(BOOL)keepThisView:(UIView*)view {
    BOOL respondToDelegate = [view respondsToSelector:@selector(delegate)];
    BOOL respondToNextResponder = [view respondsToSelector:@selector(nextResponder)];
    
    if (respondToDelegate) {
        if ([[(id)view delegate] isKindOfClass:_clazz]) {
            [self setViewOperator:[IAOperatorFactory createOperatorForUIView:view]];
            return YES;
        }
    } else if (respondToNextResponder) {
        id nextResponder = [view nextResponder]; 
        if ([nextResponder isKindOfClass:_clazz]) {
            [self setViewOperator:[IAOperatorFactory createOperatorForUIView:view]];
            return YES;
        }
    }
    return NO;
}

@end