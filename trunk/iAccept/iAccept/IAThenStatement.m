//
//  Created by Pascal Roy on 11-12-25.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import "objc/runtime.h"
#import "IAThenStatement.h"
#import "IATest.h"
#import "IAStatementResult.h"
#import "IAFixtureProvider.h"
#import "IAConfig.h"
#import "IATestSuite.h"
#import "IAThenResult.h"
#import "IAFixture.h"
#import "IAGivenThenStatementParser.h"
#import "IASelectorMatcher.h"
#import "IASelector.h"
#import "IAThenResult.h"
#import "IASelectorReturnValue.h"
#import "IASelectorObjectReturnValue.h"
#import "IAConfig.h"
#import "IAThenExceptionReturnValue.h"
#import "IAException.h"
#import "IAParsedStatement.h"

NSString* const IATHENSTATEMENT_INCORRECT_RETURN_TYPE_TEMPLATE = @"[%@ %@] must return an IAThenResult: at line %d";
NSString* const IATHENSTATEMENT_TIMEOUT_TEMPLATE =@"[%@ %@] test timed out (%.3f seconds) [%@]: at line %d";
NSString* const IATHENSTATEMENT_OBJC_TYPE_RETURN_CODE_OBJECT_INSTANCE = @"@";

@implementation IAThenStatement

@synthesize startTime;
@synthesize timeOutInSeconds;

- (id)initWithStatementText : (NSString*)theStatementText test : (IATest*) aTest suiteLineNo : (int)theSuiteLineNo timeoutInSeconds: (double) aTimeoutInSeconds {
    self = [self initWithStatementText : theStatementText test:aTest suiteLineNo:theSuiteLineNo];
    if (self) {
        self.selectorToCallOnTestFixture = nil;
        self.timeOutInSeconds = aTimeoutInSeconds;
    }
    return self;    
}

- (id)initWithStatementText : (NSString*)theStatementText test : (IATest*) aTest suiteLineNo : (int)theSuiteLineNo {
   self = [super initWithStatementText : theStatementText test:aTest suiteLineNo:theSuiteLineNo];
    if (self) {
        self.fixture = nil;
        self.selectorToCallOnTestFixture = nil;
        self.timeOutInSeconds = [IAConfig sharedInstance].timeoutToMeetThenStatementCondition;
    }
    return self;    
}


-(void) dealloc {
    [super dealloc];
}

-(IAThenResult*) runStatement {
    IAGivenThenStatementParser* statementParser = [[IAGivenThenStatementParser alloc] initWithText:self.statementText];
    IAParsedStatement* parsedStatement = [statementParser parse];
    if ([self fixture] == nil) {
        NSLog(@"ParsedStatement = %@", parsedStatement);
        [self setFixtureFromParsedStatement : parsedStatement];
    }
    
    IAThenResult* statementReturnValue = nil;
    id<IASelectorReturnValue> selectorReturnValue = nil;
    @try {        
        if (parsedStatement.selectorSourceText != nil) {
            IASelectorMatcher* matcher = [[IASelectorMatcher alloc] init];
            IASelector* iaSelector = [matcher match:parsedStatement.selectorSourceText onFixtureClass:[self.fixture class]];
            if (iaSelector != nil) {
                self.selectorToCallOnTestFixture = iaSelector.selector;
                selectorReturnValue = [iaSelector performOnFixture:(id<IAFixture>)self.fixture];
            }
            else {
                NSString* exceptionReason = [NSString stringWithFormat:IASTATEMENT_NO_MATCHING_SELECTOR_TEMPLATE, 
                        NSStringFromClass([self.fixture class]), parsedStatement.selectorSourceText, self.suiteLineNo];
                [IAException raise:exceptionReason];
            }
        }        
    }
    @catch (NSException *exception) {
        NSString* message = [NSString stringWithFormat:IASTATEMENT_SELECTOR_THROWS_EXCEPTION_TEMPLATE,
                              NSStringFromClass([self.fixture class]), NSStringFromSelector(self.selectorToCallOnTestFixture),
                             [exception name], [exception reason], self.suiteLineNo];
        statementReturnValue = [IAThenExceptionReturnValue makeExceptionReturnValue:message exception:exception];
    }
    @finally {
        if ([selectorReturnValue isKindOfClass : [IASelectorObjectReturnValue class]]) {
            IASelectorObjectReturnValue* selectorObjectReturnValue = (IASelectorObjectReturnValue*)selectorReturnValue;
            if ([selectorObjectReturnValue.value isKindOfClass:[IAThenResult class]]) {
                statementReturnValue = (IAThenResult*)selectorObjectReturnValue.value;
            }
        }
        else {
        }
        [statementParser release];
    }
    return statementReturnValue;
}

-(void) runUntilThenConditionIsMet {
    IAThenResult* result = [self runStatement];
    if (result == nil) {
        NSString* failureMessage = [NSString stringWithFormat:IATHENSTATEMENT_INCORRECT_RETURN_TYPE_TEMPLATE, 
                                    NSStringFromClass([self.fixture class]), NSStringFromSelector(self.selectorToCallOnTestFixture), self.suiteLineNo];
        [self.parentTest performSelector:NSSelectorFromString(IA_STATEMENT_DONE_RUNNING_CALLBACK_SELECTOR_NAME) withObject:[[IAStatementResult newFailure:self failureMessage:failureMessage] autorelease] ];        
        return;
    }
        
    if ([result thenStatementConditionMet]) {
        [self.parentTest performSelector:NSSelectorFromString(IA_STATEMENT_DONE_RUNNING_CALLBACK_SELECTOR_NAME) withObject:[[IAStatementResult newSuccess : self] autorelease] ];           
    }
    else {
        if ([result wasCausedByExceptionThrownByFixtureSelector]) {
            IAThenExceptionReturnValue* exceptionReturnValue = (IAThenExceptionReturnValue*)result;
            NSString* failureMessage = exceptionReturnValue.thenConditionNotMetMessage;
            [self.parentTest performSelector:NSSelectorFromString(IA_STATEMENT_DONE_RUNNING_CALLBACK_SELECTOR_NAME) withObject:[[IAStatementResult newFailure:self failureMessage:failureMessage] autorelease] ];            
        } 
        else {
            NSTimeInterval timeInterval = - [startTime timeIntervalSinceNow];
            
            if (![result recall] && timeInterval > timeOutInSeconds) {
                NSString* failureMessage = [NSString stringWithFormat:IATHENSTATEMENT_TIMEOUT_TEMPLATE,
                        NSStringFromClass([self.fixture class]), NSStringFromSelector(self.selectorToCallOnTestFixture), 
                        timeOutInSeconds, result.thenConditionNotMetMessage, self.suiteLineNo];
                [self.parentTest performSelector:NSSelectorFromString(IA_STATEMENT_DONE_RUNNING_CALLBACK_SELECTOR_NAME) withObject:[[IAStatementResult newFailure:self failureMessage:failureMessage] autorelease] ];
                return;
            }
                
            [self performSelector:@selector(runUntilThenConditionIsMet) withObject:nil afterDelay:[IAConfig sharedInstance].delayBetweenThenStatementConditionCheckslInSeconds];
        }
    }
}

-(void) run {
    [self setStartTime : [NSDate date]];

    [self performSelector:@selector(runUntilThenConditionIsMet) withObject:nil afterDelay:[IAConfig sharedInstance].delayBetweenThenStatementConditionCheckslInSeconds];
}

@end
