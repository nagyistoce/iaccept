//
//  Created by Nicolas Desjardins on 12-01-25.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAImageSearchParameters.h"
#import "IAOperatorFactory.h"

@implementation IAImageSearchParameters

@synthesize image = _image;

+(IAImageSearchParameters*) initWithImage:(UIImage*)image {
    IAImageSearchParameters* parameters = [[IAImageSearchParameters alloc] init];
    [parameters setImage:image];
    return [parameters autorelease];
}

-(BOOL)keepThisView:(UIView*)view {
    if ([view isKindOfClass:[UIImageView class]]) {
        UIImageView* imageView = (UIImageView*)view;
        UIImage* image = [imageView image];
        if ([UIImagePNGRepresentation(image) isEqualToData:UIImagePNGRepresentation(_image)]) {
            [self setViewOperator:[IAOperatorFactory createOperatorForUIView:view]];
            return YES;
        }
    }
    return NO;
}


@end
