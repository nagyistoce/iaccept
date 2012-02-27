//
//  Created by Nicolas Desjardins on 12-02-08.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IASegmentedControlSegmentSearchParameters.h"
#import "IASegmentedControlOperator.h"

@implementation IASegmentedControlSegmentSearchParameters

@synthesize segments = _segments;

+(IASegmentedControlSegmentSearchParameters*)initWithSegmentsTitles:(NSArray*)segments {
    IASegmentedControlSegmentSearchParameters* parameters = [[[IASegmentedControlSegmentSearchParameters alloc] init] autorelease];
    [parameters setSegments:segments];
    return parameters;
}

-(BOOL)controlContainsAllSegmentsTitles:(IASegmentedControlOperator*)operator {
    for (NSString* title in _segments) {
        if (![operator containsTitle:title]) {
            return NO;
        }
    }
    return YES;
}

-(BOOL)keepThisView:(UIView*)view {
    if ([view isKindOfClass:[UISegmentedControl class]]) {
        IASegmentedControlOperator* operator = [IASegmentedControlOperator segmentedControlOperatorForUISegmentedControl:(UISegmentedControl*)view];
        
        if ([self controlContainsAllSegmentsTitles:operator]) {
            [self setViewOperator:operator];
            return YES;
        }
    }
    return NO;
}

@end
