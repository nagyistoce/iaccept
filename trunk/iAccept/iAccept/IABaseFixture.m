//
//  Created by Pascal Roy on 12-01-05.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IABaseFixture.h"

@implementation IABaseFixture

@synthesize appDelegate;

-(id) init {
    self = [super init];
    if (self) {
        self.appDelegate = [[UIApplication sharedApplication] delegate];
    }
    return self;
}

-(void) dealloc {
    [appDelegate release];
    [super dealloc];
}

-(NSString*) description {
    return NSStringFromClass([self class]);
}

@end
