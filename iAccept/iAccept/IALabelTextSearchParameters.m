//
//  Created by Nicolas Desjardins on 12-01-13.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IALabelTextSearchParameters.h"
#import "IAOperatorFactory.h"

@implementation IALabelTextSearchParameters

@synthesize text = _text;

+(IALabelTextSearchParameters*) initWithText:(NSString*)text {
    IALabelTextSearchParameters* parameters = [[IALabelTextSearchParameters alloc] init];
    [parameters setText:text];
    
    return [parameters autorelease];
}

-(BOOL)keepThisView:(UIView*)view {
    if ([view isKindOfClass:[UILabel class]]) {
        UILabel* label = (UILabel*)view;
        NSString* labelText = [label text];
        if ([labelText isEqualToString:_text]) {
            [self setViewOperator:[IAOperatorFactory createOperatorForUIView:view]];
            return YES;
        }
    }
    return NO;
}

@end
