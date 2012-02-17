//
//  Util.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-01-31.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "Util.h"

@implementation Util


+(BOOL)cardNumberValid:(NSString*)plainNumber {
    if ([plainNumber length] == 16) {
        return YES;
    } else {
        return NO;
    }
    
}

+(NSString*)formatCardNumber:(NSMutableString*)plainNumber {
    NSInteger i = 4; 
    int count = 16;
    while (i < count) {
        [plainNumber insertString:@" " atIndex:i];
        count ++; 
        i += 5; 
    }
    return plainNumber;
}

@end
