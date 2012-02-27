//
//  Created by Pascal Roy on 11-12-21.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import "IAGivenStatement.h"
#import "IABaseStatement.h"
#import "IAStatementResult.h"
#import "IATest.h"
#import "IAFixtureProvider.h"
#import "IAGivenThenStatementParser.h"
#import "IASelectorMatcher.h"
#import "IAWhenStatement.h"
#import "IASelector.h"
#import "IAException.h"
#import "IAParsedStatement.h"

NSString* const IAGIVENSTATEMENT_MISSING_DEFAULT_APP_FIXTURE_TEMPLATE = @"Your test application must define an IADefaultAppFixture: at line %d";

@implementation IAGivenStatement


- (id)initWithStatementText : (NSString*)theStatementText test : (IATest*) aTest suiteLineNo : (int)theSuiteLineNo {
    self = [super initWithStatementText : theStatementText test:aTest suiteLineNo:theSuiteLineNo];
    if (self) {
        self.selectorToCallOnTestFixture = nil;
    }
    return self;    
}


-(void) dealloc {
    [super dealloc];
}

-(void) run {
    IAGivenThenStatementParser* statementParser = [[IAGivenThenStatementParser alloc] initWithText:self.statementText];
    IAParsedStatement* parsedStatement = [statementParser parse];
    [self setFixtureFromParsedStatement : parsedStatement];
    
    if (self.fixture == nil) {
        NSString* failureMessage = [NSString stringWithFormat:IAGIVENSTATEMENT_MISSING_DEFAULT_APP_FIXTURE_TEMPLATE, self.suiteLineNo];
        [self.parentTest performSelector:NSSelectorFromString(IA_STATEMENT_DONE_RUNNING_CALLBACK_SELECTOR_NAME) withObject:[[IAStatementResult newFailure:self failureMessage:failureMessage] autorelease] ];            
    }
    else {
        [self performStatementSelector : parsedStatement];
        [statementParser release];
    }    
}


@end
