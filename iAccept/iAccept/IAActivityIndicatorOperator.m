//
//  Created by Nicolas Desjardins on 12-02-09.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAActivityIndicatorOperator.h"

@implementation IAActivityIndicatorOperator

+(IAActivityIndicatorOperator*) activityIndicatorOperatorForUIActivityIndicatorView:(UIActivityIndicatorView*)uiActivityIndicatorView {
    IAActivityIndicatorOperator* operator = [[IAActivityIndicatorOperator alloc] init];
    [operator setUiView:uiActivityIndicatorView];
    return [operator autorelease];
}

-(UIActivityIndicatorView*)uiActivityIndicatorView {
    return (UIActivityIndicatorView*)[self uiView];
}

-(BOOL)isAnimating {
    return [self.uiActivityIndicatorView isAnimating];
}

@end
