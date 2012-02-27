//
//  Created by Pascal Roy on 11-12-25.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "IAThenStatementTests.h"
#import "IAThenStatement.h"
#import "IATest.h"
#import "IAStatementResult.h"
#import "SampleDefaultAppFixture.h"
#import "SampleScreenFixture.h"
#import "IATestResult.h"
#import "IAAsyncMacros.h"
#import "IAConfig.h"

@implementation IAThenStatementTests

-(void) setUp {
    [[IAConfig sharedInstance] setTimeoutToMeetWaitStatementCondition:0.5]; 
}

-(void) tearDown {

}

-(void) test_WhenIInitializeTheStatement_ThenDefautValuesAreSet {
    NSString* statementText = @"Some statement text";
    id mockTest = [OCMockObject mockForClass:[IATest class]];
    int suiteLineNo = 11;
    

    IAThenStatement* statement = [[IAThenStatement alloc] initWithStatementText:statementText test:mockTest suiteLineNo:suiteLineNo];
    

    STAssertEqualObjects(statement.statementText, statementText, @"");
    STAssertEquals(statement.parentTest, mockTest, @"");
    STAssertEquals(statement.suiteLineNo, suiteLineNo, @"");
    STAssertEquals(statement.timeOutInSeconds, [IAConfig sharedInstance].timeoutToMeetThenStatementCondition, @"");
    [statement release];
}

-(void) test_WhenIInitializeTheStatementWithATimeout_ThenTimeoutValueIsSet {
    NSString* statementText = @"Some statement text";
    id mockTest = [OCMockObject mockForClass:[IATest class]];
    int suiteLineNo = 11;
    double timeout = 5.0;
    
    
    IAThenStatement* statement = [[IAThenStatement alloc] initWithStatementText:statementText test:mockTest suiteLineNo:suiteLineNo timeoutInSeconds:timeout];
    
    
    STAssertEqualObjects(statement.statementText, statementText, @"");
    STAssertEquals(statement.parentTest, mockTest, @"");
    STAssertEquals(statement.suiteLineNo, suiteLineNo, @"");
    STAssertEquals(statement.timeOutInSeconds, 5.0, @"");
    [statement release];
}


-(void) test_WhenIGetTheDescription {
    NSString* statementText = @"Some statement text";
    id mockTest = [OCMockObject mockForClass:[IATest class]];
    int suiteLineNo = 11;
    
    
    IAThenStatement* statement = [[IAThenStatement alloc] initWithStatementText:statementText test:mockTest suiteLineNo:suiteLineNo];
    
    
    STAssertEqualObjects([statement description], @"IAThenStatement : Some statement text", @"");
    [statement release];
}

-(void) test_GivenAThenStatementConditionThatWillNeverBeMet_WhenIRunTheStatement_ThenItWillTimeout {
    NSString* statementText = @"sample screen check for something that will never happen";
    id mockTestSuite = [OCMockObject mockForProtocol:@protocol(IATestSuite)];    
    IATest* test = [[IATest alloc] initWithName:@"Stub test" testSuite:mockTestSuite];
    IATest* stubTest = [self stubTestThatWasRun : test withCurrentFixture : nil];
    int suiteLineNo = 11;
    double timeout = 1.0;
    IAThenStatement* statement = [[IAThenStatement alloc] initWithStatementText:statementText test:stubTest suiteLineNo:suiteLineNo timeoutInSeconds:timeout];
    
    
    [statement run];
    IAAsyncWaitTrue([test wasStatementRun:statement], 10.0);

    
    STAssertEqualObjects(NSStringFromSelector(statement.selectorToCallOnTestFixture), @"checkForSomethingThatWillNeverHappen", @"");
    STAssertEqualObjects(NSStringFromClass([statement.fixture class]), NSStringFromClass([SampleScreenFixture class]), @"");
    STAssertFalse([stubTest.testResult isSuccess], @"");    
    NSString* failureMessage = [stubTest.testResult getFailureMessageOfFailedStatement];
    STAssertEqualObjects(failureMessage,  @"[SampleScreenFixture checkForSomethingThatWillNeverHappen] test timed out (1.000 seconds) [Value should be 4, was 5]: at line 11", @"");
    [statement release];
}

-(void) test_GivenTheStatementSelectorDoesNotReturnTheRightValueType_WhenIRunTheStatement_ThenTheStatementFailsImmediately {
    NSString* statementText = @"a then statement method that does not return a value";
    id mockTestSuite = [OCMockObject mockForProtocol:@protocol(IATestSuite)];
    IATest* test = [[IATest alloc] initWithName:@"Stub test" testSuite:mockTestSuite];
    IATest* stubTest = [self stubTestThatWasRun : test withCurrentFixture : nil];
    IABaseFixture* stubFixture = [[SampleScreenFixture alloc] init];
    stubTest.currentFixture = stubFixture;
    int suiteLineNo = 11;
    IAThenStatement* statement = [[IAThenStatement alloc] initWithStatementText:statementText test:stubTest suiteLineNo:suiteLineNo]; 
    
    
    [statement run];     
    IAAsyncWaitTrue([test wasStatementRun:statement], 10.0);
    
    
    STAssertTrue(statement.selectorToCallOnTestFixture == @selector(aThenStatementMethodThatDoesNotReturnAValue), @"");
    STAssertEqualObjects(NSStringFromClass([statement.fixture class]), NSStringFromClass([SampleScreenFixture class]), @"");
    STAssertFalse([stubTest.testResult isSuccess], @"");    
    NSString* failureMessage = [stubTest.testResult getFailureMessageOfFailedStatement];
    STAssertEqualObjects(failureMessage, @"[SampleScreenFixture aThenStatementMethodThatDoesNotReturnAValue] must return an IAThenResult: at line 11", @"");
    [statement release];
}

-(void) test_GivenAStatementSelectorThatThrowsAnException_WhenIRunTheStatement_ThenTheStatementFailsImmediately {
    NSString* statementText = @"assert something that throws an exception";
    id mockTestSuite = [OCMockObject mockForProtocol:@protocol(IATestSuite)];
    IABaseFixture* stubFixture = [[SampleScreenFixture alloc] init];
    IATest* test = [[IATest alloc] initWithName:@"Stub test" testSuite:mockTestSuite];
    IATest* stubTest = [self stubTestThatWasRun : test withCurrentFixture : stubFixture];

    stubTest.currentFixture = stubFixture;
    int suiteLineNo = 11;
    IAThenStatement* statement = [[IAThenStatement alloc] initWithStatementText:statementText test:stubTest suiteLineNo:suiteLineNo]; 
    
    
    [statement run];     
    IAAsyncWaitTrue([stubTest wasStatementRun:statement], 10.0);
    
    
    STAssertTrue(statement.selectorToCallOnTestFixture == @selector(assertSomethingThatThrowsAnException), @"");
    STAssertEqualObjects(NSStringFromClass([statement.fixture class]), NSStringFromClass([SampleScreenFixture class]), @"");
    STAssertFalse([stubTest.testResult isSuccess], @"");    
    NSString* failureMessage = [stubTest.testResult getFailureMessageOfFailedStatement];
    STAssertEqualObjects(failureMessage, @"[SampleScreenFixture assertSomethingThatThrowsAnException] threw a IAException [Something was wrong on assert]: at line 11", @"");
    [statement release];
}

-(void) test_GivenAStatementSelectorThatWantToHandleTheTimeout_WhenIRunTheStatement_ThenForceRecallIsSet {
    NSString* statementText = @"sample screen check for recall after delay expires";
    id mockTestSuite = [OCMockObject mockForProtocol:@protocol(IATestSuite)];    
    IATest* test = [[IATest alloc] initWithName:@"Stub test" testSuite:mockTestSuite];
    IABaseFixture* stubFixture = [[SampleScreenFixture alloc] init];
    IATest* stubTest = [self stubTestThatWasRun : test withCurrentFixture : stubFixture];
    int suiteLineNo = 11;
    double timeout = 0.1;
    IAThenStatement* statement = [[IAThenStatement alloc] initWithStatementText:statementText test:stubTest suiteLineNo:suiteLineNo timeoutInSeconds:timeout];
    
    
    [statement run];
    IAAsyncWaitTrue([test wasStatementRun:statement], 10.0);
    
    
    STAssertEqualObjects(NSStringFromSelector(statement.selectorToCallOnTestFixture), @"checkForRecallAfterDelayExpires", @"");
    STAssertEqualObjects(NSStringFromClass([statement.fixture class]), NSStringFromClass([SampleScreenFixture class]), @"");
    STAssertFalse([stubTest.testResult isSuccess], @"");    
    NSString* failureMessage = [stubTest.testResult getFailureMessageOfFailedStatement];
    STAssertEqualObjects(failureMessage, @"[SampleScreenFixture checkForRecallAfterDelayExpires] test timed out (0.100 seconds) [recall done, you can fail]: at line 11", @"");
    
    [statement release];
}

//-(void) testRun_Success_PerformFixtureOnSpecifiedFixture {
//    NSString* statementText = @"sample screen assert something";
//    id mockTestSuite = [OCMockObject mockForProtocol:@protocol(IATestSuite)];
////    IATest* stubTest = [[IATest alloc] initWithName:@"Stub test" testSuite:mockTestSuite];
////    stubTest.currentFixture = nil;
//    IATest* test = [[IATest alloc] initWithName:@"Stub test" testSuite:mockTestSuite];
//    IATest* stubTest = [self stubTestThatWasRun : test withCurrentFixture : nil];
//    int suiteLineNo = 11;
//    IAThenStatement* statement = [[IAThenStatement alloc] initWithStatementText:statementText test:stubTest suiteLineNo:suiteLineNo]; 
////    STAssertFalse([stubTest wasRun], @"");
//    
//    
//    NSLog(@"[testRun_Success_PerformFixtureOnSpecifiedFixture before run]");
//    [statement run]; 
//    NSLog(@"[testRun_Success_PerformFixtureOnSpecifiedFixture after run]");
////    sIAAsyncAssertTrue([stubTest wasRun], 1);
//    NSLog(@"[testRun_Success_PerformFixtureOnSpecifiedFixture after IASync]");
//    
//    
//    STAssertEqualObjects(NSStringFromSelector(statement.selectorToCallOnTestFixture),@"assertSomething", @"");    
//    STAssertEqualObjects(NSStringFromClass([statement.fixture class]), NSStringFromClass([SampleScreenFixture class]), @"");
//    STAssertEquals(stubTest.currentFixture, statement.fixture, @"");
//    STAssertTrue([stubTest.testResult isSuccess], @"");    
//    [statement release];
//}



//-(void) testRun_Success_PerformFixtureOnSpecifiedFixture {
//    NSString* statementText = @"sample screen assert something";
//    id mockTestSuite = [OCMockObject mockForProtocol:@protocol(IATestSuite)];
////    IATest* stubTest = [[IATest alloc] initWithName:@"Stub test" testSuite:mockTestSuite];
////    stubTest.currentFixture = nil;
//    IATest* test = [[IATest alloc] initWithName:@"Stub test" testSuite:mockTestSuite];
//    IATest* stubTest = [self stubTestThatWasRun : test withCurrentFixture : nil];
//
//    int suiteLineNo = 11;
//    IAThenStatement* statement = [[IAThenStatement alloc] initWithStatementText:statementText test:stubTest suiteLineNo:suiteLineNo]; 
//    STAssertFalse([stubTest wasRun], @"");
//    
//    
//    NSLog(@"[testRun_Success_PerformFixtureOnSpecifiedFixture before run]");
//    [statement run]; 
//    NSLog(@"[testRun_Success_PerformFixtureOnSpecifiedFixture after run]");
//    IAAsyncAssertTrue([stubTest wasRun], 1);
//    NSLog(@"[testRun_Success_PerformFixtureOnSpecifiedFixture after IASync]");
//    
//    
//    STAssertEquals(statement.selectorToCallOnTestFixture, @selector(assertSomething), @"");
//    STAssertEqualObjects(NSStringFromClass([statement.fixture class]), NSStringFromClass([SampleScreenFixture class]), @"");
//    STAssertEquals(stubTest.currentFixture, statement.fixture, @"");
//    STAssertTrue([stubTest.testResult isSuccess], @"");    
//    [statement release];
//}
//
//-(void) testRun_Success_PerformSelectorOnDefautlFixtureIfTheFixtureIsNotSpecified  {
//    NSString* statementText = @"assert something";
//    id mockTestSuite = [OCMockObject mockForProtocol:@protocol(IATestSuite)];
//    IATest* stubTest = [[IATest alloc] initWithName:@"Stub test" testSuite:mockTestSuite];
//    stubTest.currentFixture = nil;
//    int suiteLineNo = 11;
//    IAThenStatement* statement = [[IAThenStatement alloc] initWithStatementText:statementText test:stubTest suiteLineNo:suiteLineNo]; 
//    
//    
//    [statement run];     
//    IAAsyncAssertTrue([stubTest wasRun], 1);
//    
//    
//    STAssertTrue(statement.selectorToCallOnTestFixture == @selector(assertSomething), @"");
//    STAssertEqualObjects(NSStringFromClass([statement.fixture class]), NSStringFromClass([SampleDefaultAppFixture class]), @"");
//    STAssertTrue([stubTest.testResult isSuccess], @"");    
//    [statement release];
//}
//
//-(void) testRun_Success_PerformSelectorOnCurrentTestContextFixtureIfSetWhenNoFixtureIsSpecified {
//    NSString* statementText = @"assert something";
//    id mockTestSuite = [OCMockObject mockForProtocol:@protocol(IATestSuite)];
//    IATest* stubTest = [[IATest alloc] initWithName:@"Stub test" testSuite:mockTestSuite];
//    IABaseFixture* stubFixture = [[SampleScreenFixture alloc] init];
//    stubTest.currentFixture = stubFixture;
//    int suiteLineNo = 11;
//    IAThenStatement* statement = [[IAThenStatement alloc] initWithStatementText:statementText test:stubTest suiteLineNo:suiteLineNo]; 
//    
//    
//    [statement run];     
//    IAAsyncAssertTrue([stubTest wasRun], 1);
//    
//    
//    STAssertTrue(statement.selectorToCallOnTestFixture == @selector(assertSomething), @"");
//    STAssertEqualObjects(NSStringFromSelector(statement.selectorToCallOnTestFixture), @"assertSomething", @"");
//    STAssertEqualObjects(NSStringFromClass([statement.fixture class]), NSStringFromClass([SampleScreenFixture class]), @"");
//    STAssertTrue([stubTest.testResult isSuccess], @"");    
//    [statement release];
//}
//
//-(void) testRun_Success_StatementWithOneArgument {
//    NSString* statementText = @"sample screen some value is hello world";
//    id mockTestSuite = [OCMockObject mockForProtocol:@protocol(IATestSuite)];
//    IATest* stubTest = [[IATest alloc] initWithName:@"Stub test" testSuite:mockTestSuite];
//    int suiteLineNo = 11;
//    IAThenStatement* statement = [[IAThenStatement alloc] initWithStatementText:statementText test:stubTest suiteLineNo:suiteLineNo]; 
//    
//    
//    [statement run];     
//    IAAsyncAssertTrue([stubTest wasRun], 1);
//    
//    
//    STAssertEqualObjects(NSStringFromClass([statement.fixture class]), NSStringFromClass([SampleScreenFixture class]), @"");
//    SampleScreenFixture* sampleScreenFixture = (SampleScreenFixture*)statement.fixture;
//    STAssertTrue(sampleScreenFixture.someValueIsMethodCalled, @"");
//    STAssertEqualObjects(sampleScreenFixture.someValueIsMethodParam, @"HelloWorld", @"");
//    STAssertEqualObjects(NSStringFromSelector(statement.selectorToCallOnTestFixture), @"someValueIs:", @"");
////    STAssertTrue(statement.selectorToCallOnTestFixture == @selector(someValueIs:), @"");
//    STAssertTrue([stubTest.testResult isSuccess], @"");    
//    [statement release];
//}

//-(void) testRun_Fail_SomethingThatWillNeverHappenWillTimeout {
//    NSString* statementText = @"then check something that will never happen";
//    id mockTestSuite = [OCMockObject mockForProtocol:@protocol(IATestSuite)];
//    IATest* stubTest = [[IATest alloc] initWithName:@"Stub test" testSuite:mockTestSuite];
//    stubTest.testSuite = mockTestSuite;
//    stubTest.currentFixture = [[SampleScreenFixture alloc] init];
//    int suiteLineNo = 11;
//    IAThenStatement* statement = [[IAThenStatement alloc] initWithStatementText:statementText test:stubTest suiteLineNo:suiteLineNo]; 
//    STAssertFalse([stubTest.testResult isSuccess], @"");
//    
//    
//    [statement run];     
//    IAAsyncAssertFalse([stubTest.testResult isSuccess], 1);
//    
//    
//    STAssertEqualObjects(NSStringFromSelector(statement.selectorToCallOnTestFixture), @"thenCheckSomethingThatWillNeverHappen", @"");
//    STAssertEqualObjects(NSStringFromClass([statement.fixture class]), NSStringFromClass([SampleScreenFixture class]), @"");
//    STAssertFalse([stubTest.testResult isSuccess], @"");    
//    NSString* failureMessage = [stubTest.testResult getFailureMessageOfFailedStatement];
//    STAssertEqualObjects(failureMessage, @"Timeout (1.000 seconds):An error message: at line 11", @"");
//    [IAConfig reset]; 
//    [statement release];
//}

//-(void) testRun_Fail_NoSuchSelectorOnSelectedFixture {
//    NSString* statementText = @"assert something with no such selector";
//    id mockTestSuite = [OCMockObject mockForProtocol:@protocol(IATestSuite)];
//    IATest* stubTest = [[IATest alloc] initWithName:@"Stub test" testSuite:mockTestSuite];
//    stubTest.currentFixture = nil; // Test on default fixture...
//    int suiteLineNo = 11;
//    IAThenStatement* statement = [[IAThenStatement alloc] initWithStatementText:statementText test:stubTest suiteLineNo:suiteLineNo]; 
//    
//    
//    [statement run];     
//    IAAsyncAssertTrue([stubTest wasRun], 1);
//    
//    
//    STAssertEquals(statement.selectorToCallOnTestFixture, (SEL)0x0, @"");
////    STAssertEqualObjects(NSStringFromSelector(statement.selectorToCallOnTestFixture), @"assertSomethingWithNoSuchSelector", @"");
////    STAssertTrue(statement.selectorToCallOnTestFixture == @selector(assertSomethingWithNoSuchSelector), @"");
//    STAssertEqualObjects(NSStringFromClass([statement.fixture class]), NSStringFromClass([SampleDefaultAppFixture class]), @"");
//    STAssertFalse([stubTest.testResult isSuccess], @"");    
//    NSString* failureMessage = [stubTest.testResult getFailureMessageOfFailedStatement];
//    NSString* expectedFailureMessage = @"SampleDefaultAppFixture has no method matching [assert something with no such selector]: at line 11";
//    STAssertEqualObjects(failureMessage, expectedFailureMessage, @"");
//    [statement release];
//}
//
@end
