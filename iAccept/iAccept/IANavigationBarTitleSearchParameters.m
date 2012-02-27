//
//  Created by Nicolas Desjardins on 12-01-13.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IANavigationBarTitleSearchParameters.h"
#import "IANavigationBarOperator.h"

@implementation IANavigationBarTitleSearchParameters

@synthesize title = _title;

+(IANavigationBarTitleSearchParameters*) initWithTitle:(NSString*)title {
    IANavigationBarTitleSearchParameters* parameters = [[[IANavigationBarTitleSearchParameters alloc] init] autorelease];
    [parameters setTitle:title];
    
    return parameters;
}

-(BOOL)keepThisView:(UIView*)view {
    if ([view isKindOfClass:[UINavigationBar class]]) {
        UINavigationBar* bar = (UINavigationBar*)view;
        IANavigationBarOperator* operator = [IANavigationBarOperator navigationBarOperatorForUINavigationBar:bar];
        if ([[operator title] isEqualToString:_title]) {
            [self setViewOperator:operator];
            return YES;
        }
    }
    return NO;
}

@end
