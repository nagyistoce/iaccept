//
//  Created by Pascal Roy on 11-11-16.
//  Copyright 2011 Elapse Technologies. All rights reserved.
//

#import "IAExecuteStatement.h"
#import "IAStatementResult.h"
#import "IATest.h"

@implementation IAExecuteStatement

@synthesize parentTest;
@synthesize suiteLineNo;
@synthesize statementText;

- (id)initValidateBlock : (void (^)())anExecuteBlock test : (IATest*) aParentTest suiteLineNo : (int)theSuiteLineNo
{
    self = [super init];
    if (self) {
        executeBlock = [anExecuteBlock copy];
        self.parentTest = aParentTest;
        suiteLineNo = theSuiteLineNo;
    }
    
    return self;
}

- (void) dealloc {
    [parentTest release];
    [statementText release];
    [executeBlock release];
    [super dealloc];
}

-(NSString*) description {
    NSString* aDescription = [NSString stringWithFormat:@"[ATExecuteStatement : suiteLineNo=%d]", self.suiteLineNo];
    return aDescription;
}

-(void) run {
    @try {
        executeBlock(); 
        
        [parentTest performSelector:NSSelectorFromString(IA_STATEMENT_DONE_RUNNING_CALLBACK_SELECTOR_NAME) withObject:[IAStatementResult newSuccess : self]];
    }
    @catch (NSException *exception) {
        NSString* failureMessage = [NSString stringWithFormat:@"%@:%@ at line %d", [exception name], [exception reason], suiteLineNo];
        [parentTest performSelector:NSSelectorFromString(IA_STATEMENT_DONE_RUNNING_CALLBACK_SELECTOR_NAME) withObject:[IAStatementResult newFailure:self failureMessage:failureMessage]];
    }
}


-(int) getSuiteLineNo {
    return suiteLineNo;
}

- (void (^)()) getExecuteBlock {
    return executeBlock;
}

- (IATest*) getParentTest {
    return parentTest;
}


@end
