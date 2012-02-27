//
//  Created by Pascal Roy on 11-12-09.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import "OCMock/OCMock.h"
#import "IABaseScenarioSuiteTests.h"
#import "IATestSuite.h"
#import "IATest.h"
#import "SampleEmptyTestSuite.h"
#import "SampleTestSuiteWithTwoTests.h"
#import "SampleScenarioSuiteTwoScenariosWithStatements.h"
#import "IARunner.h"
#import "IAExecuteStatement.h"
#import "IAWaitStatement.h"
#import "IAExecuteAndWaitStatement.h"
#import "IAAsyncMacros.h"
#import "IATestSuiteResult.h"
#import "SampleTestSuiteTestingGivenWhenThen.h"
#import "IAStatement.h"
#import "IAGivenStatement.h"
#import "IAThenStatement.h"
#import "IATest.h"
#import "IAWhenStatement.h"


@implementation IABaseScenarioSuiteTests


-(id) init {
    self = [super init];
    if (self) {
        testSuiteRun = NO;
    }
    return self;
}

-(void) testSuiteDone : (id<IATestSuite>) aTestSuite {
    testSuiteRun = YES;
} 

-(void) testBaseInit_WithEmptyTestSuite {
    id<IATestSuite> testSuite = [[SampleEmptyTestSuite alloc]init];

    STAssertEquals([testSuite countTests], 0, @"");    
    
    [testSuite release];
}

-(void) testBaseInit_LoadsTestsFromSuite {
    id<IATestSuite> testSuite = [[SampleTestSuiteWithTwoTests alloc]init];
    
    
    STAssertEquals([testSuite countTests], 2, @"");    
    STAssertTrue([testSuite containsTestNamed: @"scenarioOne"], @"");
    STAssertTrue([testSuite containsTestNamed: @"scenarioTwo"], @"");    
    [testSuite release];
}

-(void) testContainsTestNamed_returnsFalseIfTheTestIsNotInTheTestSuite {
    id<IATestSuite> testSuite = [[SampleEmptyTestSuite alloc]init];
    
    
    STAssertFalse([testSuite containsTestNamed: @"scenarioOne"], @"");
    [testSuite release];
}

-(void) testSelectTestToRun {
    IABaseScenarioSuite* testSuite = [[SampleScenarioSuiteTwoScenariosWithStatements alloc]init];
    
    
    [testSuite selectTestToRun : @"scenarioOne"]; 
 
    
    STAssertEqualObjects(testSuite.currentlyRunningTest.name, @"scenarioOne", @"");    
    [testSuite release];    
}

-(void) testSelectTestToRun_unknownTest {
    IABaseScenarioSuite* testSuite = [[SampleScenarioSuiteTwoScenariosWithStatements alloc]init];
    
    
    [testSuite selectTestToRun : @"yo"]; 
    
    
    STAssertNil(testSuite.currentlyRunningTest, @"");
    [testSuite release];    
}


-(void) testRunTests_notifiesObserversWhenDone {
    id<IATestSuite> testSuite = [[SampleScenarioSuiteTwoScenariosWithStatements alloc]init];
    STAssertFalse(testSuiteRun, @"");
    [testSuite addObserver:self];
    
    
    [testSuite runTests];

    
    IAAsyncAssertTrue(testSuiteRun, 60.0);
    [testSuite release];
}

-(void) testRunTests_wasRun {
    id<IATestSuite> testSuite = [[SampleScenarioSuiteTwoScenariosWithStatements alloc]init];
    STAssertFalse([testSuite wasRun], @"");
    [testSuite addObserver:self];
    
    
    [testSuite runTests];
    
    
    IAAsyncAssertTrue(testSuiteRun, 60.0);
    STAssertTrue([testSuite wasRun], @"");
    
    [testSuite release];
}

-(void) testRunTests_accumulatesTestResultsInTestSuiteResult {
    id<IATestSuite> testSuite = [[SampleScenarioSuiteTwoScenariosWithStatements alloc]init];
    STAssertFalse(testSuiteRun, @"");
    [testSuite addObserver:self];
    
    
    [testSuite runTests];

    
    IAAsyncAssertTrue(testSuiteRun, 60.0);
    STAssertEquals([testSuite.testSuiteResult countTests], 2, @"");
    STAssertEquals([testSuite.testSuiteResult countSuccessfulTests], 1, @"");
    STAssertEquals([testSuite.testSuiteResult countFailedTests], 1, @"");
    
    [testSuite release];
}

-(void) testRunTests_suiteCallBacksCalledInRightOrder {
    SampleTestSuiteWithTwoTests* testSuite = [[SampleTestSuiteWithTwoTests alloc]init];
    STAssertEquals(testSuite.beforeSuiteCount, 0, @"");
    STAssertEquals(testSuite.beforeTestCount, 0, @"");
    STAssertEquals(testSuite.afterTestCount, 0, @"");
    STAssertEquals(testSuite.afterSuiteCount, 0, @"");    
    [testSuite addObserver:self];


    [testSuite runTests];
    
    
    IAAsyncAssertTrue(testSuiteRun, 60.0);
    STAssertEquals(testSuite.beforeSuiteCount, 1, @"");
    STAssertEquals(testSuite.beforeTestCount, 2, @"");
    STAssertEquals(testSuite.afterTestCount, 2, @"");
    STAssertEquals(testSuite.afterSuiteCount, 1, @"");      
    STAssertEqualObjects([testSuite.calledSuiteMethods objectAtIndex:0], IA_BEFORE_SUITE_METHOD_NAME, @"");
    STAssertEqualObjects([testSuite.calledSuiteMethods objectAtIndex:1], IA_BEFORE_TEST_METHOD_NAME, @"");
    STAssertEqualObjects([testSuite.calledSuiteMethods objectAtIndex:2], IA_AFTER_TEST_METHOD_NAME, @"");
    STAssertEqualObjects([testSuite.calledSuiteMethods objectAtIndex:3], IA_BEFORE_TEST_METHOD_NAME, @"");
    STAssertEqualObjects([testSuite.calledSuiteMethods objectAtIndex:4], IA_AFTER_TEST_METHOD_NAME, @"");
    STAssertEqualObjects([testSuite.calledSuiteMethods objectAtIndex:5], IA_AFTER_SUITE_METHOD_NAME, @"");
    [testSuite release];
}

-(void) testPerformingSelectorForWithGivenStatement_addsIAGivenStatementToCurrentlyRunningTest {
    SampleTestSuiteTestingGivenWhenThen* testSuite = [[SampleTestSuiteTestingGivenWhenThen alloc]init];
    [testSuite selectTestToRun : @"scenarioWithGivenStatement"]; 
    IATest* currentlyRunningTest = testSuite.currentlyRunningTest;
    STAssertEquals([currentlyRunningTest countStatementsToRun], 0, @"");
    

    [testSuite performSelector:@selector(scenarioWithGivenStatement)]; 
    
    
    STAssertEquals([currentlyRunningTest countStatementsToRun], 1, @"");
    STAssertTrue([[currentlyRunningTest peekStatementToRunAtIndex:0] isKindOfClass : [IAGivenStatement class]], @"");
    [testSuite release];
}

-(void) testPerformingSelectorForWithThenStatement_addsIAThenStatementToCurrentlyRunningTest {
    SampleTestSuiteTestingGivenWhenThen* testSuite = [[SampleTestSuiteTestingGivenWhenThen alloc]init];
    [testSuite selectTestToRun : @"scenarioWithThenStatement"]; 
    IATest* currentlyRunningTest = testSuite.currentlyRunningTest;
    STAssertEquals([currentlyRunningTest countStatementsToRun], 0, @"");
    
    
    [testSuite performSelector:@selector(scenarioWithThenStatement)]; 
    
    
    STAssertEquals([currentlyRunningTest countStatementsToRun], 1, @"");
    STAssertTrue([[currentlyRunningTest peekStatementToRunAtIndex:0] isKindOfClass : [IAThenStatement class]], @"");
    [testSuite release];
}

-(void) testPerformingSelectorForWithWhenStatement_addsIAWhenStatementToCurrentlyRunningTest {
    SampleTestSuiteTestingGivenWhenThen* testSuite = [[SampleTestSuiteTestingGivenWhenThen alloc]init];
    [testSuite selectTestToRun : @"scenarioWithWhenStatement"]; 
    IATest* currentlyRunningTest = testSuite.currentlyRunningTest;
    STAssertEquals([currentlyRunningTest countStatementsToRun], 0, @"");
    
    
    [testSuite performSelector:@selector(scenarioWithWhenStatement)]; 
    
    
    STAssertEquals([currentlyRunningTest countStatementsToRun], 1, @"");
    STAssertTrue([[currentlyRunningTest peekStatementToRunAtIndex:0] isKindOfClass : [IAWhenStatement class]], @"");
    [testSuite release];
}

@end
