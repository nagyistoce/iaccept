//
//  Created by Pascal Roy on 12-01-28.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAThenExceptionReturnValue.h"

@implementation IAThenExceptionReturnValue

@synthesize exception;

+(IAThenResult*) makeExceptionReturnValue :  (NSString*)aMessage exception : (NSException*)anException {
    IAThenExceptionReturnValue* value = [[IAThenExceptionReturnValue alloc] initWithConditionMessage:aMessage exception:anException];
    value.thenConditionNotMetMessage = aMessage;
    value.exception = anException;
    return [value autorelease];                                     

}

-(id) initWithConditionMessage : (NSString*)aConditionMessage exception : (NSException*)anException {
    self = [super init];
    if (self) {
        self.thenConditionNotMetMessage = aConditionMessage;
        self.exception = anException;
    }
    return self;
}

-(void) dealloc {
    [exception release];
    [super dealloc];
}

-(BOOL) wasCausedByExceptionThrownByFixtureSelector {
    return YES;
}

@end
