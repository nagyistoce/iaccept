//
//  Created by Pascal Roy on 11-11-16.
//  Copyright 2011 Elapse Technologies. All rights reserved.
//

#import "IAExecuteAndWaitStatement.h"
#import "IAStatementResult.h"
#import "IATestSuite.h"

@implementation IAExecuteAndWaitStatement

@synthesize parentTest;
@synthesize suiteLineNo;
@synthesize statementText;

- (id)initExecuteBlock : (void (^)())anExecuteBlock  waitConditionBlock : (BOOL (^)())aWaitConditionBlock test : (IATest*) aParentTest suiteLineNo : (int)theSuiteLineNo
{
    self = [super init];
    if (self) {
        executeBlock = [anExecuteBlock copy];
        waitConditionBlock = [aWaitConditionBlock copy];
        self.parentTest = aParentTest;
        done = NO;
        self.suiteLineNo = theSuiteLineNo;
    }
    
    return self;
}

-(void) dealloc {
    [parentTest release];
    [statementText release];
    [executeBlock release];
    [waitConditionBlock release];
    [super dealloc];
}

-(NSString*) description {
    NSString* aDescription = [NSString stringWithFormat:@"[ATExecuteAndWaitStatement : suiteLineNo=%d]", self.suiteLineNo];
    return aDescription;
}

-(void) checkIfWaitConditionIsMet {
    @try {
        done = waitConditionBlock();
        if (done) {
            [parentTest performSelector:NSSelectorFromString(IA_STATEMENT_DONE_RUNNING_CALLBACK_SELECTOR_NAME) withObject:[IAStatementResult newSuccess : self]];
        }
        else {
            [self performSelector:@selector(checkIfWaitConditionIsMet) withObject:nil afterDelay:0.1];
        }
    }
    @catch (NSException *exception) {
        [parentTest performSelector:NSSelectorFromString(IA_STATEMENT_DONE_RUNNING_CALLBACK_SELECTOR_NAME) withObject:[IAStatementResult newFailure:self failureMessage:[exception name]]];
    }
    

}

-(void) run {
    @try {
        executeBlock(); 
    }
    @catch (NSException *exception) {
        [parentTest performSelector:NSSelectorFromString(IA_STATEMENT_DONE_RUNNING_CALLBACK_SELECTOR_NAME) withObject:[IAStatementResult newFailure:self failureMessage:[exception name]]];
        return;
    }
    
    [self performSelector:@selector(checkIfWaitConditionIsMet) withObject:nil afterDelay:0.1];
}

-(int) getSuiteLineNo {
    return suiteLineNo;
}

- (IATest*) getParentTest {
    return parentTest;
}

- (void (^)()) getExecuteBlock {
    return executeBlock;
}

- (BOOL (^)()) getWaitConditionBlock {
    return waitConditionBlock;
}

@end
