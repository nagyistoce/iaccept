//
//  Created by Nicolas Desjardins on 12-02-04.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IATextViewTextSearchParameters.h"
#import "IAOperatorFactory.h"
#import "IATextViewOperator.h"

@implementation IATextViewTextSearchParameters

@synthesize text = _text;

+(IATextViewTextSearchParameters*)initWithText:(NSString*)text {
    IATextViewTextSearchParameters* parameters = [[[IATextViewTextSearchParameters alloc] init] autorelease];
    [parameters setText:text];
    return parameters;
}

-(BOOL)keepThisView:(UIView*)view {
    if ([view isKindOfClass:[UITextView class]]) {
        IATextViewOperator* operator = (IATextViewOperator*)[IAOperatorFactory createOperatorForUIView:view];
        if ([operator containsText:_text]) {
            [self setViewOperator:operator];
            return YES;
        }
    }
    return NO;
}


@end
