//
//  Created by Nicolas Desjardins on 12-01-13.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAButtonImageSearchParameters.h"
#import "IAOperatorFactory.h"

@interface IAButtonImageSearchParameters() {
}

@end

@implementation IAButtonImageSearchParameters

@synthesize image = _image;
@synthesize state = _state;

+(IAButtonImageSearchParameters*) initWithImage:(UIImage*)image andState:(UIControlState)state {
    IAButtonImageSearchParameters* parameters = [[IAButtonImageSearchParameters alloc] init];
    [parameters setImage:image];
    [parameters setState:state];
    
    return [parameters autorelease];
}

-(BOOL)keepThisView:(UIView*)view {
    if ([view isKindOfClass:[UIButton class]]) {
        UIButton* button = (UIButton*)view;
        UIImage* buttonImage = [button imageForState:_state];
        if ([buttonImage isEqual:_image] || [UIImagePNGRepresentation(buttonImage) isEqualToData:UIImagePNGRepresentation(_image)]) {
            [self setViewOperator:[IAOperatorFactory createOperatorForUIView:view]];
            return YES;
        }
    }
    return NO;
}


@end
