//
//  Created by Pascal Roy on 11-11-20.
//  Copyright 2011 Elapse Technologies. All rights reserved.
//

#import "IATest.h"
#import "IAStatement.h"
#import "IATestResult.h"
#import "IATestSuite.h"
#import "IAConfig.h"
#import "IAStatementResult.h"
#import "IATestObserver.h"
#import "IAExecuteStatement.h"
#import "IAWaitStatement.h"
#import "IAExecuteAndWaitStatement.h"
#import "IASelectorExecuteStatement.h"
#import "IAGivenStatement.h"
#import "IAThenStatement.h"
#import "IAWhenStatement.h"
#import "IAConfigStatement.h"

NSString* const IA_BEFORE_TEST_METHOD_NAME = @"beforeTest";
NSString* const IA_AFTER_TEST_METHOD_NAME = @"afterTest";
NSString* const IA_STATEMENT_DONE_RUNNING_CALLBACK_SELECTOR_NAME = @"statementDoneRunning:";

@implementation IATest

@synthesize name;
@synthesize statementsToRunQueue;
@synthesize testSuite;
@synthesize testResult;
@synthesize observers;
@synthesize currentFixture;

- (id)initWithName : (NSString*) aName testSuite : (id<IATestSuite>) aTestSuite
{
    self = [super init];
    if (self) {
        [self setName : aName];
        [self setTestSuite: aTestSuite];
        observers = [[NSMutableArray alloc] init];
        statementsToRunQueue = [[NSMutableArray alloc] init];
        testResult = [[IATestResult alloc] initWithTest : self];
        currentFixture = nil;
        wasRun = NO;
    }
    
    return self;
}

-(void) dealloc {
    [observers release];
    [super dealloc];
}

-(void) addObserver : (id<IATestSuiteObserver>) anObserver {
    [observers addObject:anObserver];
}

-(void) recordExecuteStatement:(void (^)())aValidateBlock statementText : (NSString*) statementText suiteLineNo : (int)theSuiteLineNo {
    [self enqueueStatementToRun:[[[IAExecuteStatement alloc] initValidateBlock:aValidateBlock test : self suiteLineNo:theSuiteLineNo]autorelease]];
}

-(void) recordExecuteAndWaitStatement :(void (^)())aValidateBlock waitConditionBlock : (BOOL (^)())aWaitConditionBlock suiteLineNo : (int)theSuiteLineNo {
    [self enqueueStatementToRun:[[[IAExecuteAndWaitStatement alloc] initExecuteBlock:aValidateBlock waitConditionBlock:aWaitConditionBlock test : self suiteLineNo:theSuiteLineNo] autorelease]];
}

-(void) recordWaitStatement : (BOOL (^)())aWaitConditionBlock suiteLineNo : (int)theSuiteLineNo{
    [self enqueueStatementToRun:[[[IAWaitStatement alloc] initWithWaitConditionBlock:aWaitConditionBlock test:self suiteLineNo:theSuiteLineNo]autorelease]];
}

-(id<IAStatement>) recordGivenStatement : (NSString*) theStatementText suiteLineNo : (int)theSuiteLineNo {
    IAGivenStatement* statement = [[IAGivenStatement alloc] initWithStatementText:theStatementText test:self suiteLineNo:theSuiteLineNo];
    [self enqueueStatementToRun:statement];
    return [statement autorelease];
}

-(id<IAStatement>) recordThenStatement : (NSString*) theStatementText suiteLineNo : (int)theSuiteLineNo {
    NSLog(@"recordThenStatement %@", theStatementText);
    IAThenStatement* statement = [[IAThenStatement alloc] initWithStatementText:theStatementText test:self suiteLineNo:theSuiteLineNo];
    [self enqueueStatementToRun:statement];
    return [statement autorelease];
}

-(id<IAStatement>) recordWhenStatement : (NSString*) theStatementText suiteLineNo : (int)theSuiteLineNo {
    IAWhenStatement* statement = [[IAWhenStatement alloc] initWithStatementText:theStatementText test:self suiteLineNo:theSuiteLineNo];
    [self enqueueStatementToRun:statement];
    return [statement autorelease];
}

-(id<IAStatement>) recordConfigStatement : (NSString*) theStatementText suiteLineNo : (int)theSuiteLineNo; {
    IAConfigStatement* statement = [[IAConfigStatement alloc] initWithStatementText:theStatementText test:self suiteLineNo:theSuiteLineNo];
    [self enqueueStatementToRun:statement];
    return [statement autorelease];    
}

-(BOOL) wasRun {
    return wasRun;
}

-(int) countStatementsToRun {
    return [statementsToRunQueue count];
}

-(id<IAStatement>) peekStatementToRunAtIndex : (int) anIndex {
    return [statementsToRunQueue objectAtIndex: anIndex];
}

-(SEL) getTestMethodSelectorInTestSuite {
    return NSSelectorFromString(name);
}

-(BOOL) hasMoreStatementsToRun {
    return [statementsToRunQueue count] > 0;
}

-(void) removeAllStatementsToRun {
    [statementsToRunQueue removeAllObjects];
}

-(void) removeCurrentStatementToRun {
    if ([self hasMoreStatementsToRun]) {
        [statementsToRunQueue removeObjectAtIndex:0];
    }
}

-(void) enqueueStatementToRun:(id<IAStatement>)aStatement {
    [statementsToRunQueue addObject : aStatement];
}

-(id<IAStatement>) dequeueStatementToRun {
    id<IAStatement> nextStatement = [[statementsToRunQueue objectAtIndex : 0] retain];
    [statementsToRunQueue removeObjectAtIndex:0];
    return [nextStatement autorelease];
}

-(void) notifyObserversTestIsDoneRunning {
    for (id<IATestObserver> observer in observers) {
        [observer testDone : self];
    }
}

-(void) statementDoneRunning : (IAStatementResult*) aStatementResult {
     NSLog(@"%@ Done",aStatementResult.statement.statementText);
    [testResult addStatementResult : aStatementResult];
    
    if ([aStatementResult isFailure]) {
        [self removeAllStatementsToRun];
    }
    [self performSelector:@selector(runNextTestStatement) withObject:nil afterDelay:[IAConfig sharedInstance].delayBetweenTestStatementsInSeconds];
}

-(void) runNextTestStatement {
    
    if ([self hasMoreStatementsToRun]) {
        
        id<IAStatement> statement = [self dequeueStatementToRun];
        NSLog(@"Running %@ at line %d", statement.statementText, statement.suiteLineNo);
        [statement run];
    }
    else {
        [testResult stopChorno];
        [self notifyObserversTestIsDoneRunning];
    }
}

-(void) loadStatementsByPerformingSelector : (SEL) aTestSelector {
    [testSuite performSelector:aTestSelector];
}

-(void) prepareToRunTest {
    [self loadStatementsByPerformingSelector : [self getTestMethodSelectorInTestSuite]];
}

-(BOOL) wasStatementRun:(id<IAStatement>)aStatement {
    if ([testResult getStatementResult : aStatement]!=nil) {
        return YES;
    }
    else {
        return NO;
    }
}

-(void) run {
     wasRun = YES;
    
    [self prepareToRunTest]; 
    
    [testResult startChrono];
    // CRITICAL : the delay is absolutely necessary or the runloop will not gain back control and update the ui between tests
    [self performSelector:@selector(runNextTestStatement) withObject:nil afterDelay:[IAConfig sharedInstance].delayBetweenTestsInSeconds];
}

@end
