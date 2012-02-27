//
//  Created by Nicolas Desjardins on 12-01-18.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IATextFieldTextSearchParameters.h"
#import "IAOperatorFactory.h"

@implementation IATextFieldTextSearchParameters

@synthesize text = _text;

+(IATextFieldTextSearchParameters*) initWithText:(NSString*)text {
    IATextFieldTextSearchParameters* parameters = [[[IATextFieldTextSearchParameters alloc] init] autorelease];
    [parameters setText:text];
    return parameters;
}

-(BOOL)keepThisView:(UIView*)view {
    if ([view isKindOfClass:[UITextField class]]) {
        UITextField* textField = (UITextField*)view;
        NSString* fieldText = [textField text];
        if ([fieldText isEqualToString:_text]) {
            [self setViewOperator:[IAOperatorFactory createOperatorForUIView:view]];
            return YES;
        }
    }
    return NO;
}

@end
