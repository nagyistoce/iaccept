//
//  Created by Pascal Roy on 11-12-09.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import "OCMock/OCMock.h"
#import "IATestTests.h"
#import "IATest.h"
#import "IATestSuite.h"
#import "SampleTestSuiteWithTwoTests.h"
#import "IARunner.h"
#import "IAAsyncMacros.h"
#import "SampleScenarioSuiteTwoScenariosWithStatements.h"
#import "IAExecuteStatement.h"
#import "IAWaitStatement.h"
#import "IAExecuteAndWaitStatement.h"
#import "SampleTestSuiteTestingGivenWhenThen.h"
#import "IAThenStatement.h"
#import "IAStatement.h"
#import "IAGivenStatement.h"
#import "IAWhenStatement.h"
#import "IAThenStatement.h"
#import "IAStatement.h"

@implementation IATestTests

@synthesize lastTestRun;

-(void) testDone:(id)aTest {
    lastTestRun = aTest;
}

-(void) assertStatementsToRunIsEmpty : (IATest*) aTest {
    STAssertEquals([aTest countStatementsToRun], 0, @"");    
}

- (void)testInit
{
    id mockTestSuite = [OCMockObject mockForProtocol:@protocol(IATestSuite)];
    NSString* testName = @"Some name";
 
    IATest* test = [[IATest alloc] initWithName:testName testSuite:mockTestSuite]; 
    
    STAssertEqualObjects(test.name, testName, @"");
    STAssertEqualObjects(test.testSuite, mockTestSuite, @"");
    STAssertFalse([test wasRun], @"");
    
    [test release];
}

- (void) testRun_setsWasRunToTrueWhenDone
{
    SampleTestSuiteWithTwoTests* testSuite = [[SampleTestSuiteWithTwoTests alloc]init];
    NSString* testName = @"scenarioOne";    
    IATest* test = [[IATest alloc] initWithName:testName testSuite:testSuite]; 

    
    [test run];
    
    
    IAAsyncAssertTrue([test wasRun], 5.0);
    [test release];
    [testSuite release];
}

- (void) testRun_callsObserverWhenTestIsDoneRunning
{
    SampleTestSuiteWithTwoTests* testSuite = [[SampleTestSuiteWithTwoTests alloc]init];
    NSString* testName = @"scenarioOne";    
    IATest* test = [[IATest alloc] initWithName:testName testSuite:testSuite]; 
    [test addObserver:self];
    

    [test run];
    
    
    IAAsyncAssertEqualObjects(lastTestRun, test, 5.0);
    [test release];
    [testSuite release];
}

-(void) testRecordExecuteStatementOnCurrentlySelectedTestToRun {
    IABaseScenarioSuite* testSuite = [[SampleScenarioSuiteTwoScenariosWithStatements alloc]init];    
    [testSuite selectTestToRun : @"scenarioOne"]; 
    void (^anExecuteBlock)() = ^() {NSLog(@"Hello world");};
    NSString* statementText = @"NSLog(\\@\"Hello world\")";
    int lineNo = 10;        
    IATest* test = [testSuite getTestNamed:@"scenarioOne"];
    STAssertEquals([test countStatementsToRun], 0, @"");
    
    
    [test recordExecuteStatement:anExecuteBlock statementText:statementText suiteLineNo:lineNo];
    
    
    STAssertEquals([test countStatementsToRun], 1, @"");
    IAExecuteStatement* executeStatement = (IAExecuteStatement* )[test peekStatementToRunAtIndex : 0];
    STAssertEquals([executeStatement getExecuteBlock], anExecuteBlock, @"");
    STAssertEquals(executeStatement.suiteLineNo, lineNo, @"");
    STAssertEquals(executeStatement.parentTest, test, @"");    

    [testSuite release];
}

-(void) testRecordWaitStatementOnCurrentlySelectedTestToRun {
    IABaseScenarioSuite* testSuite = [[SampleScenarioSuiteTwoScenariosWithStatements alloc]init];    
    [testSuite selectTestToRun : @"scenarioOne"];     
    BOOL (^aWaitConditionBlock)() = ^() {return YES;};
    int lineNo = 10;    
    IATest* test = [testSuite getTestNamed:@"scenarioOne"];
    STAssertEquals([test countStatementsToRun], 0, @"");
    
    
    [test recordWaitStatement:aWaitConditionBlock suiteLineNo:lineNo];
    
    
    STAssertEquals([test countStatementsToRun], 1, @"");
    IAWaitStatement* waitStatement = (IAWaitStatement* )[test peekStatementToRunAtIndex : 0];
    STAssertEquals([waitStatement getWaitConditionBlock], aWaitConditionBlock, @"");
    STAssertEquals(waitStatement.suiteLineNo, lineNo, @"");
    STAssertEquals(waitStatement.parentTest, test, @"");        
    [testSuite release];
}

-(void) testRecordExecuteAndWaitStatementOnCurrentlySelectedTestToRun {
    IABaseScenarioSuite* testSuite = [[SampleScenarioSuiteTwoScenariosWithStatements alloc]init];    
    [testSuite selectTestToRun : @"scenarioOne"];     
    void (^anExecuteBlock)() = ^() {NSLog(@"Hello world");};
    BOOL (^aWaitConditionBlock)() = ^() {return YES;};
    int lineNo = 10;    
    IATest* test = [testSuite getTestNamed:@"scenarioOne"];
    STAssertEquals([test countStatementsToRun], 0, @"");
    
    
    [test recordExecuteAndWaitStatement:anExecuteBlock waitConditionBlock:aWaitConditionBlock suiteLineNo:lineNo];
    
    
    STAssertEquals([test countStatementsToRun], 1, @"");
    IAExecuteAndWaitStatement* statement = (IAExecuteAndWaitStatement* )[test peekStatementToRunAtIndex : 0];
    STAssertEquals([statement getExecuteBlock], anExecuteBlock, @"");
    STAssertEquals([statement getWaitConditionBlock], aWaitConditionBlock, @"");
    STAssertEquals(statement.suiteLineNo, lineNo, @"");
    STAssertEquals(statement.parentTest, test, @"");        
    [testSuite release];
}

-(void) testRecordGivenStatement {
    IABaseScenarioSuite* testSuite = [[SampleScenarioSuiteTwoScenariosWithStatements alloc]init];    
    int lineNo = 10;    
    IATest* test = [testSuite getTestNamed:@"scenarioOne"];
    NSString* statementText = @"I setup the application in some state";

    
    [test recordGivenStatement:statementText suiteLineNo:lineNo];
    
    
    STAssertEquals([test countStatementsToRun], 1, @"");
    IAGivenStatement* statement = (IAGivenStatement* )[test peekStatementToRunAtIndex : 0];
    STAssertEquals([statement statementText], statementText, @"");
    STAssertEquals(statement.suiteLineNo, lineNo, @"");
    STAssertEquals(statement.parentTest, test, @"");        
    [testSuite release];
}

-(void) testWhenStatement {
    IABaseScenarioSuite* testSuite = [[SampleScenarioSuiteTwoScenariosWithStatements alloc]init];    
    int lineNo = 10;    
    IATest* test = [testSuite getTestNamed:@"scenarioOne"];
    NSString* statementText = @"I do something on an interaction context";
    
    
    [test recordThenStatement:statementText suiteLineNo:lineNo];
    
    
    STAssertEquals([test countStatementsToRun], 1, @"");
    IAWhenStatement* statement = (IAWhenStatement* )[test peekStatementToRunAtIndex : 0];
    STAssertEquals([statement statementText], statementText, @"");
    STAssertEquals(statement.suiteLineNo, lineNo, @"");
    STAssertEquals(statement.parentTest, test, @"");        
    [testSuite release];
}

-(void) testRecordThentatement {
    IABaseScenarioSuite* testSuite = [[SampleScenarioSuiteTwoScenariosWithStatements alloc]init];    
    int lineNo = 10;    
    IATest* test = [testSuite getTestNamed:@"scenarioOne"];
    NSString* statementText = @"I check some state on an interaction context";
    
    
    [test recordThenStatement:statementText suiteLineNo:lineNo];
    
    
    STAssertEquals([test countStatementsToRun], 1, @"");
    IAThenStatement* statement = (IAThenStatement* )[test peekStatementToRunAtIndex : 0];
    STAssertEquals([statement statementText], statementText, @"");
    STAssertEquals(statement.suiteLineNo, lineNo, @"");
    STAssertEquals(statement.parentTest, test, @"");        
    [testSuite release];
}

@end
