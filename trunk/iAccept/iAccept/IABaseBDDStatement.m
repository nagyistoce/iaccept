//
//  Created by Pascal Roy on 12-01-29.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IABaseBDDStatement.h"
#import "IAException.h"
#import "IAFixtureProvider.h"
#import "IAStatementParser.h"
#import "IATest.h"
#import "IAParsedStatement.h"
#import "IASelectorMatcher.h"
#import "IAFixture.h"
#import "IAStatementResult.h"
#import "IASelector.h"
#import "IASelectorReturnValue.h"

@implementation IABaseBDDStatement

@synthesize fixture;
@synthesize selectorToCallOnTestFixture;


- (id)initWithStatementText : (NSString*)theStatementText test : (IATest*) aTest suiteLineNo : (int)theSuiteLineNo {
    self = [super initWithStatementText : theStatementText test:aTest suiteLineNo:theSuiteLineNo];
    if (self) {
        self.fixture = nil;
    }
    return self;    
}


-(void) dealloc {
    [fixture release];
    [super dealloc];
}

-(NSString*) description {
    return [NSString stringWithFormat:@"%@ : %@", NSStringFromClass([self class]), self.statementText]; 
}

-(void) run {
    [IAException raise:@"IABaseBDDStatement subclasses must implement run"];
}

-(void) performStatementSelector:(IAParsedStatement*)parsedStatement {
    @try {
        if (parsedStatement.selectorParsedText != nil) {
            IASelectorMatcher* matcher = [[IASelectorMatcher alloc] init];
            IASelector* iaSelector = [matcher match:parsedStatement.selectorParsedText onFixtureClass:[self.fixture class]];
            if (iaSelector != nil) {
                selectorToCallOnTestFixture = iaSelector.selector;
                [iaSelector performOnFixture:(id<IAFixture>)self.fixture];
                [self.parentTest performSelector:@selector(statementDoneRunning:) withObject:[IAStatementResult newSuccess : self]];
            }
            else {
                NSString* failureMessage = [NSString stringWithFormat:IASTATEMENT_NO_MATCHING_SELECTOR_TEMPLATE, 
                                            NSStringFromClass([self.fixture class]), parsedStatement.selectorParsedText, self.suiteLineNo];
                [self.parentTest performSelector:NSSelectorFromString(IA_STATEMENT_DONE_RUNNING_CALLBACK_SELECTOR_NAME) withObject:[IAStatementResult newFailure:self failureMessage:failureMessage]];
            }
        }
        
    }
    @catch (NSException *exception) {
        NSString* failureMessage = [NSString stringWithFormat:IASTATEMENT_SELECTOR_THROWS_EXCEPTION_TEMPLATE,
                                    NSStringFromClass([self.fixture class]), NSStringFromSelector(selectorToCallOnTestFixture),
                                    [exception name], [exception reason], self.suiteLineNo];
        [self.parentTest performSelector:NSSelectorFromString(IA_STATEMENT_DONE_RUNNING_CALLBACK_SELECTOR_NAME) withObject:[IAStatementResult newFailure:self failureMessage:failureMessage]];
    }
}
                                                                                 

-(void) setFixtureFromParsedStatement : (IAParsedStatement*) parsedStatement  {
    self.fixture = [[self newFixture:parsedStatement.fixtureClassName] autorelease];
    if ( self.fixture == nil) {
        if ( self.parentTest.currentFixture!= nil) {
            self.fixture = self.parentTest.currentFixture;
        }
        else {
            IABaseFixture* defaultAppFixture = (IABaseFixture*)[[IAFixtureProvider sharedInstance] getDefaultAppFixture];
            self.fixture = defaultAppFixture;
        }
    }
    [self.parentTest setCurrentFixture:self.fixture];

}
@end
