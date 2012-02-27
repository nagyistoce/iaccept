//
//  Created by Nicolas Desjardins on 12-01-13.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IABaseViewSearchParameters.h"
#import "IAViewOperator.h"

@interface IABaseViewSearchParameters() {
}
@end

@implementation IABaseViewSearchParameters

@synthesize viewOperator = _viewOperator;

-(BOOL)keepThisView:(UIView*)view {
    return NO;
}
@end
