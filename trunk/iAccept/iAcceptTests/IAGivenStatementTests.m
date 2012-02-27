//
//  Created by Pascal Roy on 11-12-21.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "IAGivenStatementTests.h"
#import "IAGivenStatement.h"
#import "IATest.h"
#import "SampleDefaultAppFixture.h"
#import "IAStatementResult.h"
#import "IATestResult.h"
#import "SampleScreenFixture.h"
#import "IAFixtureProvider.h"

@implementation IAGivenStatementTests

-(void) tearDown {
    [IAFixtureProvider reset];
}

-(void) testInit {
    id mockTest = [OCMockObject mockForClass:[IATest class]];
    int suiteLineNo = 11;
    NSString* statementText = @"i started the application";
    

    IAGivenStatement* statement = [[IAGivenStatement alloc] initWithStatementText:statementText test:mockTest suiteLineNo:suiteLineNo]; 
    
 
    STAssertEquals(statement.statementText, statementText, @"");
    STAssertEquals(statement.parentTest, mockTest, @"");
    STAssertEquals(statement.suiteLineNo, suiteLineNo, @"");
    [statement release];
}

-(void) testDescription {
    NSString* statementText = @"Some statement text";
    id mockTest = [OCMockObject mockForClass:[IATest class]];
    int suiteLineNo = 11;
    IAGivenStatement* statement = [[IAGivenStatement alloc] initWithStatementText:statementText test:mockTest suiteLineNo:suiteLineNo]; 
    
    
    STAssertEqualObjects([statement description], @"IAGivenStatement : Some statement text", @"");
    [statement release];
}

-(void) testGivenTheStatementSpecifiesOnlyTheFixture_WhenIRunTheStatement_ThenIsSimplySetsFTheixtureAsTheCurrentTestContextFixture {
    NSString* statementText = @"sample screen";
    id mockTestSuite = [OCMockObject mockForProtocol:@protocol(IATestSuite)];
    IATest* test = [[IATest alloc] initWithName:@"Stub test" testSuite:mockTestSuite];
    IATest* stubTest = [self stubTestThatWasRun : test withCurrentFixture : nil];
    
    int suiteLineNo = 11;
    IAGivenStatement* statement = [[IAGivenStatement alloc] initWithStatementText:statementText test:stubTest suiteLineNo:suiteLineNo]; 
    
    
    [statement run];     
    
    
    STAssertEquals(statement.selectorToCallOnTestFixture, (SEL)0x0, @"");
    STAssertEqualObjects(NSStringFromClass([statement.fixture class]), NSStringFromClass([SampleScreenFixture class]), @"");    
    STAssertEquals([stubTest currentFixture], statement.fixture, @"");
    STAssertTrue([stubTest.testResult isSuccess], @"");    
    [statement release];
}


-(void) testGivenNoFixtureSpecifiedInTheStatementAndNoPreviousTextContexteFixtureWasSet_WhenIRunTheGivenStatement_ThenItPerformTheSelectorOnTheDefaultAppFixture {
    NSString* statementText = @"I started the application";
    id mockTestSuite = [OCMockObject mockForProtocol:@protocol(IATestSuite)];
    IATest* test = [[IATest alloc] initWithName:@"Stub test" testSuite:mockTestSuite];
    IATest* stubTest = [self stubTestThatWasRun : test withCurrentFixture : nil];
    int suiteLineNo = 11;
    IAGivenStatement* statement = [[IAGivenStatement alloc] initWithStatementText:statementText test:stubTest suiteLineNo:suiteLineNo]; 
    
    
    [statement run];   
    
    
    STAssertEqualObjects(NSStringFromSelector(statement.selectorToCallOnTestFixture), @"iStartedTheApplication", @"");
    STAssertTrue(statement.selectorToCallOnTestFixture == @selector(iStartedTheApplication), @"");
    STAssertEqualObjects(NSStringFromClass([statement.fixture class]), NSStringFromClass([SampleDefaultAppFixture class]), @"");    
    STAssertTrue([stubTest.testResult isSuccess], @"");    
    [statement release];
}

-(void) testGivenNoFixtureIsSpecifiedInTheStatement_WhenIRunTheGivenStatement_ItUsesTheCurrentTestContextFixtureIfItIsSet {
    NSString* statementText = @"I did something";
    id mockTestSuite = [OCMockObject mockForProtocol:@protocol(IATestSuite)];
    IABaseFixture* stubFixture = [[SampleScreenFixture alloc] init];
    IATest* test = [[IATest alloc] initWithName:@"Stub test" testSuite:mockTestSuite];
    IATest* stubTest = [self stubTestThatWasRun : test withCurrentFixture : stubFixture];
    int suiteLineNo = 11;
    IAGivenStatement* statement = [[IAGivenStatement alloc] initWithStatementText:statementText test:stubTest suiteLineNo:suiteLineNo]; 
    
    
    [statement run];     
    
    
    STAssertEqualObjects(NSStringFromSelector(statement.selectorToCallOnTestFixture), @"iDidSomething", @"");
    STAssertEqualObjects(NSStringFromClass([statement.fixture class]), NSStringFromClass([SampleScreenFixture class]), @"");
    STAssertTrue([((IATest*)stubTest).testResult isSuccess], @"");    
    [statement release];
}



-(void) testGivenMIssingSelectormMentod_WhenIRunTheGivenStatement_ItFailsLettingMeKnowThereIsNoSuchSelector {
    NSString* statementText = @"I did something";
    id mockTestSuite = [OCMockObject mockForProtocol:@protocol(IATestSuite)];
    IATest* test = [[IATest alloc] initWithName:@"Stub test" testSuite:mockTestSuite];
    IATest* stubTest = [self stubTestThatWasRun : test withCurrentFixture : nil];
    int suiteLineNo = 11;
    IAGivenStatement* statement = [[IAGivenStatement alloc] initWithStatementText:statementText test:stubTest suiteLineNo:suiteLineNo]; 
    
    
    [statement run];     
    
    
    STAssertEquals(statement.selectorToCallOnTestFixture, (SEL)0x0, @"");
    STAssertEqualObjects(NSStringFromClass([statement.fixture class]), NSStringFromClass([SampleDefaultAppFixture class]), @"");
    STAssertFalse([stubTest.testResult isSuccess], @"");    
    NSString* failureMessage = [stubTest.testResult getFailureMessageOfFailedStatement];
    STAssertEqualObjects(failureMessage, @"SampleDefaultAppFixture has no method matching [I did something]: at line 11", @"");
    [statement release];
}

-(void) testGivenAStatementSelectorThatThrowsAnException_WhenIRunTheStatement_ThenItFailsTellingMeAboutTheException {
    NSString* statementText = @"I did something that throws an exception";
    id mockTestSuite = [OCMockObject mockForProtocol:@protocol(IATestSuite)];
    IABaseFixture* stubFixture = [[SampleScreenFixture alloc] init];
    IATest* test = [[IATest alloc] initWithName:@"Stub test" testSuite:mockTestSuite];
    IATest* stubTest = [self stubTestThatWasRun : test withCurrentFixture : stubFixture];

    int suiteLineNo = 11;
    IAGivenStatement* statement = [[IAGivenStatement alloc] initWithStatementText:statementText test:stubTest suiteLineNo:suiteLineNo]; 
    
    
    [statement run];     
    

    STAssertEqualObjects(NSStringFromSelector(statement.selectorToCallOnTestFixture), @"iDidSomethingThatThrowsAnException", @"");
    STAssertEqualObjects(NSStringFromClass([statement.fixture class]), NSStringFromClass([SampleScreenFixture class]), @"");
    STAssertFalse([stubTest.testResult isSuccess], @"");    
    NSString* failureMessage = [stubTest.testResult getFailureMessageOfFailedStatement];
    STAssertEqualObjects(failureMessage, @"[SampleScreenFixture iDidSomethingThatThrowsAnException] threw a IAException [Something was wrong on action]: at line 11", @"");
    [statement release];
}

-(void) testGivenFixtureIsDefine_WhenIRunTheGivenStatement_ThenItFailsLettingMeKnowINeedToDefineAnIDefaultAppFixture {
    [[IAFixtureProvider sharedInstance] setDefaultAppFixture:nil];     // Override the default app fixture for the test    
    NSString* statementText = @"I did something";
    id mockTestSuite = [OCMockObject mockForProtocol:@protocol(IATestSuite)];
    IATest* test = [[IATest alloc] initWithName:@"Stub test" testSuite:mockTestSuite];
    IATest* stubTest = [self stubTestThatWasRun : test withCurrentFixture : nil];
    int suiteLineNo = 11;
    IAGivenStatement* statement = [[IAGivenStatement alloc] initWithStatementText:statementText test:stubTest suiteLineNo:suiteLineNo]; 
    
    
    [statement run];     
    
    
    STAssertEquals(statement.selectorToCallOnTestFixture, (SEL)0x0, @"");
    STAssertNil(NSStringFromClass([statement.fixture class]), @"");
    STAssertFalse([stubTest.testResult isSuccess], @"");    
    NSString* failureMessage = [stubTest.testResult getFailureMessageOfFailedStatement];
    STAssertEqualObjects(failureMessage, @"Your test application must define an IADefaultAppFixture: at line 11", @"");
    [statement release];
}



@end
