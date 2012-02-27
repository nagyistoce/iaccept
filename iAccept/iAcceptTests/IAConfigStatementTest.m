//
//  IAConfigStatementTest.m
//  iAccept
//
//  Created by Nicolas Desjardins on 12-02-27.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "IAConfigStatementTest.h"
#import "IAConfigStatement.h"
#import "IAFixtureProvider.h"
#import "IATest.h"
#import "IAConfig.h"

@implementation IAConfigStatementTest

-(void) tearDown {
    [IAFixtureProvider reset];
    
    [[IAConfig sharedInstance] setDelayBetweenTestStatementsInSeconds:0.01]; 
}

-(void) testInit {
    id mockTest = [OCMockObject mockForClass:[IATest class]];
    int suiteLineNo = 11;
    NSString* statementText = @"delayBetweenTestStatementsInSeconds:0.4";
    
    IAConfigStatement* statement = [[IAConfigStatement alloc] initWithStatementText:statementText test:mockTest suiteLineNo:suiteLineNo]; 
    
    STAssertEquals(statement.statementText, statementText, @"");
    STAssertEquals(statement.parentTest, mockTest, @"");
    STAssertEquals(statement.suiteLineNo, suiteLineNo, @"");
    [statement release];
}

-(void) testDescription {
    NSString* statementText = @"delayBetweenTestStatementsInSeconds:0.4";
    id mockTest = [OCMockObject mockForClass:[IATest class]];
    int suiteLineNo = 11;
    IAConfigStatement* statement = [[IAConfigStatement alloc] initWithStatementText:statementText test:mockTest suiteLineNo:suiteLineNo]; 
    
    
    STAssertEqualObjects([statement description], @"IAConfigStatement : delayBetweenTestStatementsInSeconds:0.4", @"");
    [statement release];
}

-(void) testConfigTheStatementConfig {
    NSString* statementText = @"delayBetweenTestStatementsInSeconds:0.4";
    id mockTestSuite = [OCMockObject mockForProtocol:@protocol(IATestSuite)];
    IATest* test = [[IATest alloc] initWithName:@"Stub test" testSuite:mockTestSuite];
    IATest* stubTest = [self stubTestThatWasRun : test withCurrentFixture : nil];
    
    int suiteLineNo = 11;
    IAConfigStatement* statement = [[IAConfigStatement alloc] initWithStatementText:statementText test:stubTest suiteLineNo:suiteLineNo]; 
    
    STAssertEquals([[IAConfig sharedInstance] delayBetweenTestStatementsInSeconds], 0.01, @"");
    
    [statement run];     
    
    STAssertEquals([[IAConfig sharedInstance] delayBetweenTestStatementsInSeconds], 0.4, @"");
    [statement release];
}

@end
