//
//  UIImageToDataTransformer.m
//  PetShop
//
//  Created by Nicolas Desjardins on 11-11-18.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import "UIImageToDataTransformer.h"

@implementation UIImageToDataTransformer

+ (BOOL)allowsReverseTransformation {
    return YES;
}

+ (Class)transformedValueClass {
    return [NSData class];
}


- (id)transformedValue:(id)value {
    NSData *data = UIImagePNGRepresentation(value);
    return data;
}


- (id)reverseTransformedValue:(id)value {
    UIImage *uiImage = [[UIImage alloc] initWithData:value];
    return uiImage;
}

@end
