//
//  Created by Pascal Roy on 11-11-11.
//  Copyright 2011 Elapse Technologies. All rights reserved.
//

#import "IAStatementResult.h"
#import "IAStatement.h"

@implementation IAStatementResult

NSString * const IASTATEMENTRESULT_DESCRIPTION_TEMPLATE_PASSED = @"%@ : passed";
NSString * const IASTATEMENTRESULT_DESCRIPTION_TEMPLATE_FAILED = @"%@ : failed [%@]";


@synthesize statement;
@synthesize failureMessage;

-(id) initWithStatement : (id<IAStatement>) aStatement {
    self = [super init];
    if (self) {
        [self setStatement : aStatement];
        [self setFailureMessage : nil];
    }    
    return self;
}

-(id) initWithStatement : (id<IAStatement>) aStatement failureMessage : (NSString*) aFailureMessage {
    self = [super init];
    if (self) {
        [self setStatement : aStatement];
        failureMessage = [aFailureMessage copy];
    }    
    return self;
}

-(void) dealloc {
    [statement release];
    [failureMessage release];
    [super dealloc];
}

+(IAStatementResult*) newSuccess : (id<IAStatement>) aStatement {
    IAStatementResult* statementResult = [[IAStatementResult alloc] initWithStatement : aStatement];
    return statementResult;
}

+(IAStatementResult*) newFailure : (id<IAStatement>) aStatement failureMessage : (NSString*) aFailureMessage  {
    IAStatementResult* statementResult = [[IAStatementResult alloc] initWithStatement : aStatement failureMessage:aFailureMessage];
    return statementResult;
}

-(BOOL) isSuccess {
    if (failureMessage == nil)  {
        return YES;
    }
    else  {
        return NO;
    }
}

-(BOOL) isFailure {
    return ![self isSuccess];
}

-(NSString*) description {
    if ([self isSuccess]) {
        return [NSString stringWithFormat:IASTATEMENTRESULT_DESCRIPTION_TEMPLATE_PASSED, [statement description]];
    }
    else {
        return [NSString stringWithFormat:IASTATEMENTRESULT_DESCRIPTION_TEMPLATE_FAILED, [statement description], failureMessage];
    }
}


@end
