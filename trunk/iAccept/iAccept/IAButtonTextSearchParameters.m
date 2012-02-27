//
//  Created by Nicolas Desjardins on 12-01-13.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAButtonTextSearchParameters.h"
#import "IAOperatorFactory.h"

@interface IAButtonTextSearchParameters() {
}
@end

@implementation IAButtonTextSearchParameters

@synthesize text = _text;
@synthesize state = _state;

+(IAButtonTextSearchParameters*) initWithText:(NSString*)text andState:(UIControlState)state {
    IAButtonTextSearchParameters* parameters = [[[IAButtonTextSearchParameters alloc] init] autorelease];
    [parameters setText:text];
    [parameters setState:state];

    return parameters;
}

-(BOOL)keepThisView:(UIView*)view {
    if ([view isKindOfClass:[UIButton class]]) {
        UIButton* button = (UIButton*)view;
        NSString* titleLabel = [button titleForState:_state];
        if ([titleLabel isEqualToString:_text]) {
            [self setViewOperator:[IAOperatorFactory createOperatorForUIView:view]];
            return YES;
        }
    }
    return NO;
}

@end
