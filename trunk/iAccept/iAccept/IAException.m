//
//  Created by Pascal Roy on 12-01-29.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAException.h"

NSString* const IAEXCEPTION_NAME = @"IAException";

@implementation IAException

+(void) raise : (NSString*) aReason {
    NSException* exception = [NSException exceptionWithName:IAEXCEPTION_NAME reason:aReason userInfo:nil];
    [exception raise];
}

@end
