//
//  Created by Pascal Roy on 11-12-21.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import "IASelectorExecuteStatement.h"
#import "IAStatementResult.h"

@implementation IASelectorExecuteStatement

@synthesize suiteLineNo;
@synthesize parentTest;
@synthesize statementText;
@synthesize selector;
@synthesize targetOfSelector;

- (id)initWithSelector : (SEL)aSelector onTargetOfSelector : (NSObject*) aTargetOfSelector test : (IATest*) aTest suiteLineNo : (int)theSuiteLineNo {
    self = [super init];
    if (self) {
        self.suiteLineNo = theSuiteLineNo;
        self.parentTest = aTest;
        self.selector = aSelector;
        self.targetOfSelector = aTargetOfSelector;
    }
    return self;
}

-(void) dealloc {
    [parentTest release];
    [statementText release];
    [super dealloc];
}

- (SEL) getSelector {
    return selector;
}

- (NSObject*) getTargetOfSelector {
    return targetOfSelector;
}

-(void) run {
    @try {
        [targetOfSelector performSelector:selector withObject:nil];
        
        [parentTest performSelector:@selector(statementDoneRunning:) withObject:[IAStatementResult newSuccess : self]];
    }
    @catch (NSException *exception) {
        NSString* failureMessage = [NSString stringWithFormat:@"%@:%@ at line %d", [exception name], [exception reason], suiteLineNo];
        [parentTest performSelector:@selector(statementDoneRunning:) withObject:[IAStatementResult newFailure:self failureMessage:failureMessage]];
    }
}

-(int) getSuiteLineNo {
    return suiteLineNo;
}

-(IATest*) getParentTest {
    return parentTest;
}


@end
