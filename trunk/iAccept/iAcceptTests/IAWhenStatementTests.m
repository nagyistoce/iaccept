//
//  Created by Pascal Roy on 11-12-29.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "IAWhenStatementTests.h"
#import "IATest.h"
#import "IAWhenStatement.h"
#import "IAStatementResult.h"
#import "IATestSuite.h"
#import "IATestResult.h"
#import "SampleScreenFixture.h"
#import "SampleDefaultAppFixture.h"
#import "IABaseStatementTests.h"

@implementation IAWhenStatementTests


-(void) testInit {
    NSString* statementText = @"Some statement text";
    id mockTest = [OCMockObject mockForClass:[IATest class]];
    int suiteLineNo = 11;
    
    
    IAWhenStatement* statement = [[IAWhenStatement alloc] initWithStatementText:statementText test:mockTest suiteLineNo:suiteLineNo];
    
    
    STAssertEqualObjects(statement.statementText, statementText, @"");
    STAssertEquals(statement.parentTest, mockTest, @"");
    STAssertEquals(statement.suiteLineNo, suiteLineNo, @"");
    STAssertEquals(statement.selectorToCallOnTestFixture, (SEL)0x0, @"");
    STAssertNil(statement.fixture, @"");
    [statement release];
}

-(void) testDescription {
    NSString* statementText = @"Some statement text";
    id mockTest = [OCMockObject mockForClass:[IATest class]];
    int suiteLineNo = 11;
    
    
    IAWhenStatement* statement = [[IAWhenStatement alloc] initWithStatementText:statementText test:mockTest suiteLineNo:suiteLineNo];
    
    
    STAssertEqualObjects([statement description], @"IAWhenStatement : Some statement text", @"");
    [statement release];
}

-(void) testRun_Success_UseLastFixtureSetInTheCurrentTestContext_WhenNoFixtureSpecifiedInTheStatementText {
    NSString* statementText = @"I do something";
    id mockTestSuite = [OCMockObject mockForProtocol:@protocol(IATestSuite)];
    IABaseFixture* stubFixture = [[SampleScreenFixture alloc] init];
    IATest* test = [[IATest alloc] initWithName:@"Stub test" testSuite:mockTestSuite];
    IATest* stubTest = [self stubTestThatWasRun : test withCurrentFixture : stubFixture];
    int suiteLineNo = 11;
    IAWhenStatement* statement = [[IAWhenStatement alloc] initWithStatementText:statementText test:stubTest suiteLineNo:suiteLineNo];
    
    
    [statement run];     
    
    
    STAssertEqualObjects(NSStringFromSelector(statement.selectorToCallOnTestFixture), @"iDoSomething", @"");
    STAssertEqualObjects(NSStringFromClass([statement.fixture class]), NSStringFromClass([SampleScreenFixture class]), @"");
    STAssertTrue([stubTest.testResult isSuccess], @"");    
    [statement release];
}

-(void) testRun_Sucess_UseDefaultAppFixtureIfNoFixtureWasSetPreviously_WhenNoFixtureSpecifiedInTheStatementText {
    NSString* statementText = @"I do something";    
    id mockTestSuite = [OCMockObject mockForProtocol:@protocol(IATestSuite)];
    IATest* test = [[IATest alloc] initWithName:@"Stub test" testSuite:mockTestSuite];
    IATest* stubTest = [self stubTestThatWasRun : test withCurrentFixture : nil];
    int suiteLineNo = 11;
    IAWhenStatement* statement = [[IAWhenStatement alloc] initWithStatementText:statementText test:stubTest suiteLineNo:suiteLineNo];
    
    
    [statement run];     

    
    STAssertTrue(statement.selectorToCallOnTestFixture == @selector(iDoSomething), @"");
    STAssertEqualObjects(NSStringFromClass([statement.fixture class]), NSStringFromClass([SampleDefaultAppFixture class]), @"");
    STAssertTrue([stubTest.testResult isSuccess], @"");    
    [statement release];
}

-(void) testRun_Sucess_UseSpecifiedFixture {
    NSString* statementText = @"I do something on sample screen";    
    id mockTestSuite = [OCMockObject mockForProtocol:@protocol(IATestSuite)];
    IATest* test = [[IATest alloc] initWithName:@"Stub test" testSuite:mockTestSuite];
    IATest* stubTest = [self stubTestThatWasRun : test withCurrentFixture : nil];
    int suiteLineNo = 11;
    IAWhenStatement* statement = [[IAWhenStatement alloc] initWithStatementText:statementText test:stubTest suiteLineNo:suiteLineNo];
    
    
    [statement run];     
    
    
    STAssertTrue(statement.selectorToCallOnTestFixture == @selector(iDoSomething), @"");
    STAssertEqualObjects(NSStringFromClass([statement.fixture class]), NSStringFromClass([SampleScreenFixture class]), @"");
    STAssertTrue([stubTest.testResult isSuccess], @"");    
    [statement release];
}

-(void) testRun_testFailsBecauseTestFixtureHasNoSelectorMatchingTheStatementText {
    NSString* statementText = @"I touch another button on sample screen";    
    id mockTestSuite = [OCMockObject mockForProtocol:@protocol(IATestSuite)];
    IATest* test = [[IATest alloc] initWithName:@"Stub test" testSuite:mockTestSuite];
    IATest* stubTest = [self stubTestThatWasRun : test withCurrentFixture : nil];
    int suiteLineNo = 11;
    IAWhenStatement* statement = [[IAWhenStatement alloc] initWithStatementText:statementText test:stubTest suiteLineNo:suiteLineNo];
    
    
    [statement run];     
    
    
    NSString* expectedResult = @"SampleScreenFixture has no method matching [I touch another button]: at line 11";
    NSString* actualResult = [stubTest.testResult getFailureMessageOfFailedStatement];
    STAssertFalse([stubTest.testResult isSuccess], @"");    
    STAssertEqualObjects(actualResult, expectedResult , @"");
}

-(void) testRun_Sucess_StatementWithOneArgument {
    NSString* statementText = @"I touch a button named Next on the sample screen";    
    id mockTestSuite = [OCMockObject mockForProtocol:@protocol(IATestSuite)];
    IATest* test = [[IATest alloc] initWithName:@"Stub test" testSuite:mockTestSuite];
    IATest* stubTest = [self stubTestThatWasRun : test withCurrentFixture : nil];
    int suiteLineNo = 11;
    IAWhenStatement* statement = [[IAWhenStatement alloc] initWithStatementText:statementText test:stubTest suiteLineNo:suiteLineNo];
    
    
    [statement run];     
    
    
    STAssertTrue(statement.selectorToCallOnTestFixture == @selector(iTouchAButtonNamed:), @"");
    STAssertEqualObjects(NSStringFromClass([statement.fixture class]), NSStringFromClass([SampleScreenFixture class]), @"");
    STAssertTrue([stubTest.testResult isSuccess], @"");    
    STAssertEqualObjects(((SampleScreenFixture*)statement.fixture).iTouchButtonName, @"Next", @"");
    [statement release];
}

-(void) testRun_Sucess_StatementWithTwoArguments {
    NSString* statementText = @"I enter text Text1 and touch button Enter on the sample screen";    
    id mockTestSuite = [OCMockObject mockForProtocol:@protocol(IATestSuite)];
    IATest* test = [[IATest alloc] initWithName:@"Stub test" testSuite:mockTestSuite];
    IATest* stubTest = [self stubTestThatWasRun : test withCurrentFixture : nil];
    int suiteLineNo = 11;
    IAWhenStatement* statement = [[IAWhenStatement alloc] initWithStatementText:statementText test:stubTest suiteLineNo:suiteLineNo];
    
    
    [statement run];     
    
    
    STAssertTrue(statement.selectorToCallOnTestFixture == @selector(iEnterText:andTouchButton:), @"");
    STAssertEqualObjects(NSStringFromClass([statement.fixture class]), NSStringFromClass([SampleScreenFixture class]), @"");
    STAssertTrue([stubTest.testResult isSuccess], @"");    
    STAssertEqualObjects(((SampleScreenFixture*)statement.fixture).iEnterTextText, @"Text1", @"");
    STAssertEqualObjects(((SampleScreenFixture*)statement.fixture).andTouchButtonName, @"Enter", @"");
    [statement release];
}

-(void) testRun_Sucess_StatementWithOneArgumentInDoubleQuotes {
    NSString* statementText = @"I touch a button named hi there on the sample screen";    
    id mockTestSuite = [OCMockObject mockForProtocol:@protocol(IATestSuite)];
    IATest* test = [[IATest alloc] initWithName:@"Stub test" testSuite:mockTestSuite];
    IATest* stubTest = [self stubTestThatWasRun : test withCurrentFixture : nil];
    int suiteLineNo = 11;
    IAWhenStatement* statement = [[IAWhenStatement alloc] initWithStatementText:statementText test:stubTest suiteLineNo:suiteLineNo];
    
    
    [statement run];     
    
    
    STAssertTrue(statement.selectorToCallOnTestFixture == @selector(iTouchAButtonNamed:), @"");
    STAssertEqualObjects(NSStringFromClass([statement.fixture class]), NSStringFromClass([SampleScreenFixture class]), @"");
    STAssertTrue([stubTest.testResult isSuccess], @"");    
    STAssertEqualObjects(((SampleScreenFixture*)statement.fixture).iTouchButtonName, @"hi there", @"");
    [statement release];
}


@end
