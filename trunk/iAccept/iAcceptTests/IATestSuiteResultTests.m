//
//  Created by Pascal Roy on 12-01-27.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "OCMock/OCMock.h"
#import "IATestSuiteResultTests.h"
#import "IATestSuiteResult.h"
#import "IATestSuite.h"
#import "IATestResult.h"

@implementation IATestSuiteResultTests

-(id<IATestSuite>) newEmptyTestSuite {
    id mockTestSuite = [OCMockObject mockForProtocol:@protocol(IATestSuite)];
    
    NSArray* tests = [[NSArray alloc] init];
    [[[mockTestSuite stub] andReturn:tests] tests];

    return mockTestSuite;
}

-(id) passingTest : (int) statementCount {
    id mockTest = [OCMockObject mockForClass:[IATest class]];
    id mockTestResult = [OCMockObject mockForClass:[IATestResult class]];
    [[[mockTest stub] andReturn:mockTestResult] testResult];
    BOOL yesValue = YES;
    BOOL noValue = NO;
    [[[mockTestResult stub] andReturnValue:OCMOCK_VALUE(noValue)] isFailure];
    [[[mockTestResult stub] andReturnValue:OCMOCK_VALUE(yesValue)] isSuccess];
    [[[mockTestResult stub] andReturnValue:OCMOCK_VALUE(statementCount)] countStatementResults];
    return mockTest;
}

-(id<IATestSuite>) suiteWithOnePassingTestResult {
    id mockTestSuite = [OCMockObject mockForProtocol:@protocol(IATestSuite)];
    

    NSMutableArray* tests = [[NSMutableArray alloc] init];
    [tests addObject : [self passingTest : 4]]; 
    [[[mockTestSuite stub] andReturn:tests] tests];

    return mockTestSuite;
}

-(id) failingTest : (int) statementCount {
    id mockTest = [OCMockObject mockForClass:[IATest class]];
    id mockTestResult = [OCMockObject mockForClass:[IATestResult class]];
    [[[mockTest stub] andReturn:mockTestResult] testResult];
    BOOL yesValue = YES;
    BOOL noValue = NO;
    [[[mockTestResult stub] andReturnValue:OCMOCK_VALUE(yesValue)] isFailure];
    [[[mockTestResult stub] andReturnValue:OCMOCK_VALUE(noValue)] isSuccess];
    [[[mockTestResult stub] andReturnValue:OCMOCK_VALUE(statementCount)] countStatementResults];
    return mockTest;
}

-(id<IATestSuite>) suiteWithOneFailingTestResult {
    id mockTestSuite = [OCMockObject mockForProtocol:@protocol(IATestSuite)];
    
    
    NSMutableArray* tests = [[NSMutableArray alloc] init];
    [tests addObject : [self failingTest : 2]]; 
    [[[mockTestSuite stub] andReturn:tests] tests];
    
    return mockTestSuite;
}

-(void) testInitWithTestSuite {
    id mockTestSuite = [self newEmptyTestSuite];


    IATestSuiteResult* testSuiteResult = [[IATestSuiteResult alloc] initWithTestSuite:mockTestSuite];
    
    
    STAssertEquals(testSuiteResult.testSuite, mockTestSuite, @"");
    STAssertEquals([testSuiteResult countTests], 0, @"");
    STAssertEquals([testSuiteResult countFailedTests], 0, @"");
    STAssertEquals([testSuiteResult countSuccessfulTests], 0, @"");
    STAssertEquals([testSuiteResult countStatementResults], 0, @"");
    STAssertTrue([testSuiteResult isSuccess], @"");
    STAssertFalse([testSuiteResult isFailure], @"");
    [testSuiteResult release];
}

-(void) testInitWithTestSuite_TestSuiteHasOnePassingTest {
    id mockTestSuite = [self suiteWithOnePassingTestResult];
    
    
    IATestSuiteResult* testSuiteResult = [[IATestSuiteResult alloc] initWithTestSuite:mockTestSuite];
    
    
    STAssertEquals(testSuiteResult.testSuite, mockTestSuite, @"");
    STAssertEquals([testSuiteResult countTests], 1, @"");
    STAssertEquals([testSuiteResult countFailedTests], 0, @"");
    STAssertEquals([testSuiteResult countSuccessfulTests], 1, @"");
    STAssertEquals([testSuiteResult countStatementResults], 4, @"");
    STAssertTrue([testSuiteResult isSuccess], @"");
    STAssertFalse([testSuiteResult isFailure], @"");
    [testSuiteResult release];
}

-(void) testInitWithTestSuite_TestSuiteHasOneFailingTest {
    id mockTestSuite = [self suiteWithOneFailingTestResult];
    
    
    IATestSuiteResult* testSuiteResult = [[IATestSuiteResult alloc] initWithTestSuite:mockTestSuite];
    
    
    STAssertEquals(testSuiteResult.testSuite, mockTestSuite, @"");
    STAssertEquals([testSuiteResult countTests], 1, @"");
    STAssertEquals([testSuiteResult countFailedTests], 1, @"");
    STAssertEquals([testSuiteResult countSuccessfulTests], 0, @"");
    STAssertEquals([testSuiteResult countStatementResults], 2, @"");
    STAssertFalse([testSuiteResult isSuccess], @"");
    STAssertTrue([testSuiteResult isFailure], @"");
    [testSuiteResult release];
}



@end
