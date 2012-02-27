//
//  Created by Pascal Roy on 11-11-18.
//  Copyright 2011 Elapse Technologies. All rights reserved.
//

#import "IAWaitStatement.h"
#import "IAStatementResult.h"
#import "IATestSuite.h"
#import "IAConfig.h"
#import "IATest.h"

@implementation IAWaitStatement

@synthesize waitStartTime;
@synthesize parentTest;
@synthesize suiteLineNo;
@synthesize statementText;

- (id)initWithWaitConditionBlock : (BOOL (^)())aWaitConditionBlock test : (IATest*) aParentTest suiteLineNo : (int)theSuiteLineNo
{
    self = [super init];
    if (self) {
        waitConditionBlock = [aWaitConditionBlock copy];
        self.parentTest = aParentTest;
        isWaitConditionMet = NO;
        self.suiteLineNo = theSuiteLineNo;
    }
    
    return self;
}

-(void) dealloc {
    [parentTest release];
    [statementText release];
    [waitConditionBlock release];
    [super dealloc];
}

-(NSString*) description {
    NSString* aDescription = [NSString stringWithFormat:@"[ATWaitStatement : suiteLineNo=%d]", self.suiteLineNo];
    return aDescription;
}

-(void) checkIfWaitConditionIsMet {
    @try {
        isWaitConditionMet = waitConditionBlock();
        if (isWaitConditionMet) {
            [parentTest performSelector:NSSelectorFromString(IA_STATEMENT_DONE_RUNNING_CALLBACK_SELECTOR_NAME) withObject:[IAStatementResult newSuccess : self]];
        }
        else {
            NSTimeInterval timeInterval = - [waitStartTime timeIntervalSinceNow];
            if (timeInterval > [IAConfig sharedInstance].timeoutToMeetWaitStatementCondition) {
                NSString* failureMessage = [NSString stringWithFormat:@"Wait condition not met for %.3f seconds on line %d", [IAConfig sharedInstance].timeoutToMeetWaitStatementCondition, suiteLineNo];
                [parentTest.testSuite performSelector:NSSelectorFromString(IA_STATEMENT_DONE_RUNNING_CALLBACK_SELECTOR_NAME) withObject:[IAStatementResult newFailure:self failureMessage:failureMessage]];
            }
            [self performSelector:@selector(checkIfWaitConditionIsMet) withObject:nil afterDelay:0.1];
        }
        
    }
    @catch (NSException *exception) {
        [parentTest.testSuite performSelector:NSSelectorFromString(IA_STATEMENT_DONE_RUNNING_CALLBACK_SELECTOR_NAME) withObject:[IAStatementResult newFailure:self failureMessage:[exception name]]];
    }
}

-(void) run {
    [self setWaitStartTime : [NSDate date]];
    [self checkIfWaitConditionIsMet];
}


-(int) getSuiteLineNo {
    return suiteLineNo;
}

- (BOOL (^)()) getWaitConditionBlock {
    return waitConditionBlock;
}

- (IATest*) getParentTest {
    return parentTest;
}

@end
