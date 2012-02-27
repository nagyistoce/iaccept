//
//  Created by Pascal Roy on 12-01-26.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "OCMock/OCMock.h"
#import "IATestResultTests.h"
#import "IATestResult.h"
#import "IATest.h"
#import "IAStatementResult.h"

@implementation IATestResultTests

-(void) testInitWithTest {
    id mockTest = [OCMockObject mockForClass:[IATest class]];
    

    IATestResult* testResult = [[IATestResult alloc] initWithTest:mockTest];
    
    
    STAssertEquals(testResult.test, mockTest, @"");
    [testResult release];
}

-(void) testInitWithTest_ATestResultAssociatedToATestThatHasNotRunIsNotASuccess {
    id mockTest = [OCMockObject mockForClass:[IATest class]];
    BOOL wasRunReturn = NO;
    [[[mockTest stub] andReturnValue:OCMOCK_VALUE(wasRunReturn)] wasRun];
    
    
    IATestResult* testResult = [[IATestResult alloc] initWithTest:mockTest];
    
    
    STAssertFalse([testResult isSuccess], @"");
    STAssertEqualObjects([testResult getFailureMessageOfFailedStatement], IATEST_RESULT_FAILURE_MESSAGE_TEST_NOT_RUN, @"");
    [testResult release];
}


-(void) testAddStatementResult {
    id mockTest = [OCMockObject mockForClass:[IATest class]];
    id statementResult1 = [OCMockObject mockForClass:[IAStatementResult class]];
    id statementResult2 = [OCMockObject mockForClass:[IAStatementResult class]];
    IATestResult* testResult = [[IATestResult alloc] initWithTest:mockTest];
        

    [testResult addStatementResult:statementResult1];
    [testResult addStatementResult:statementResult2];

    
    STAssertEquals([testResult countStatementResults], 2, @"");
    [testResult release];
}

-(void) testGetStatementResult_returnsStatementResultIfStatementExists {
    id mockTest = [OCMockObject mockForClass:[IATest class]];
    id statement1 = [OCMockObject mockForProtocol:@protocol(IAStatement)];
    id statementResult1 = [OCMockObject mockForClass:[IAStatementResult class]];
    [[[statementResult1 stub] andReturn:statement1] statement];
    IATestResult* testResult = [[IATestResult alloc] initWithTest:mockTest];
    [testResult addStatementResult:statementResult1];
    
    
    STAssertEquals([testResult getStatementResult : statement1], statementResult1, @"");
    [testResult release];
}

-(void) testGetStatementResult_returnsNilIfStatementResultDoesNotExist {
    id mockTest = [OCMockObject mockForClass:[IATest class]];
    id statement1 = [OCMockObject mockForProtocol:@protocol(IAStatement)];
    IATestResult* testResult = [[IATestResult alloc] initWithTest:mockTest];
    
    
    STAssertNil([testResult getStatementResult : statement1], @"");
    [testResult release];
    
}


@end
