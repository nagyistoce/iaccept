//
//  BaseFixture.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-01-09.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "BaseFixture.h"

@implementation BaseFixture 

- (id)init
{
    self = [super init];
    if (self) {
        appDelegate = [[UIApplication sharedApplication] delegate];
    }
    return self;
}


@end
