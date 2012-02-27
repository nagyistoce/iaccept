//
//  Created by Nicolas Desjardins on 12-01-13.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAViewClassSearchParameters.h"
#import "IAOperatorFactory.h"

@interface IAViewClassSearchParameters() {
}
@end

@implementation IAViewClassSearchParameters

@synthesize clazz = _clazz;

+(IAViewClassSearchParameters*) initWithClass:(Class)clazz {
    IAViewClassSearchParameters* parameters = [[IAViewClassSearchParameters alloc] init];
    [parameters setClazz:clazz];
    
    return [parameters autorelease];
}

-(BOOL)keepThisView:(UIView*)view {
    if ([view isKindOfClass:_clazz]) {
        [self setViewOperator:[IAOperatorFactory createOperatorForUIView:view]];
        return YES;
    }
    return NO;
}

@end
