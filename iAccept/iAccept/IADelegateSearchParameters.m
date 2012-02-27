//
//  Created by Nicolas Desjardins on 12-01-19.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IADelegateSearchParameters.h"
#import "IAOperatorFactory.h"

@implementation IADelegateSearchParameters

@synthesize delegate = _delegate;

+(IADelegateSearchParameters*) initWithDelegate:(id)delegate {
    IADelegateSearchParameters* parameters = [[IADelegateSearchParameters alloc] init];
    [parameters setDelegate:delegate];
    return parameters;
}

-(BOOL)keepThisView:(UIView*)view {
    
    BOOL respond = [view respondsToSelector:@selector(delegate)];
    id genView = (id)view;
    if (respond && [genView delegate] == _delegate) {
        [self setViewOperator:[IAOperatorFactory createOperatorForUIView:view]];
        return YES;
    }
    return NO;
}


@end
