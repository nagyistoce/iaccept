//
//  Created by Pascal Roy on 12-01-27.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "OCMock/OCMock.h"
#import "IAStatementResultTests.h"
#import "IAStatementResult.h"
#import "IAStatement.h"
#import "IAGivenStatement.h"
#import "IATest.h"

NSString * const failedMessage = @"The test failed for some reason";

@implementation IAStatementResultTests

-(id) init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void) dealloc {
    [mockStatementDescription release];
    [super dealloc];
}

-(IAStatementResult*) newSuccessfulStatementResult  {
    id mockTest = [OCMockObject mockForClass:[IATest class]]; 
    id<IAStatement> stubStatement = [[IAGivenStatement alloc] initWithStatementText:@"" test:mockTest suiteLineNo:10];
    mockStatementDescription = [stubStatement description];
    STAssertEqualObjects([stubStatement description],mockStatementDescription, @"");
    return [IAStatementResult newSuccess:stubStatement];
}

-(IAStatementResult*) newFailedStatementResult  {
    id mockTest = [OCMockObject mockForClass:[IATest class]]; 
    id<IAStatement> stubStatement = [[IAGivenStatement alloc] initWithStatementText:@"" test:mockTest suiteLineNo:10];
    mockStatementDescription = [stubStatement description];
    return [[IAStatementResult alloc] initWithStatement:stubStatement failureMessage:failedMessage];
}

-(void) testInitWithStatement {
    id mockStatement = [OCMockObject mockForProtocol:@protocol(IAStatement)];
    

    IAStatementResult* result = [[IAStatementResult alloc] initWithStatement:mockStatement];
    

    STAssertEquals(result.statement, mockStatement, @"");
    [result release];
}

-(void) testInitWithStatementAndErrorMessage {
    id mockStatement = [OCMockObject mockForProtocol:@protocol(IAStatement)];
    NSString* aFailureMessage = @"The test failed for some reason";

    
    IAStatementResult* result = [[IAStatementResult alloc] initWithStatement:mockStatement failureMessage:aFailureMessage];
    
    
    STAssertEquals(result.statement, mockStatement, @"");
    STAssertEqualObjects(result.failureMessage, aFailureMessage, @"");
    [result release];
}

-(void) testDescriptionSuccessfulResult {
    IAStatementResult* result = [self newSuccessfulStatementResult];

    
    NSString* expectedDescription = [NSString stringWithFormat:IASTATEMENTRESULT_DESCRIPTION_TEMPLATE_PASSED, mockStatementDescription];
    STAssertEqualObjects([result description],expectedDescription, @"");
    [result release];
}

-(void) testDescriptionFailedResult {
    IAStatementResult* result = [self newFailedStatementResult];
    
    
    NSString* expectedDescription = [NSString stringWithFormat:IASTATEMENTRESULT_DESCRIPTION_TEMPLATE_FAILED, mockStatementDescription, failedMessage];
    STAssertEqualObjects([result description],expectedDescription, @"");
    [result release];
}


-(void) testIsSuccessReturnsYesIfNoFailureMessageWasSet {
    IAStatementResult* result = [self newSuccessfulStatementResult];
    
    
    STAssertTrue([result isSuccess], @"");
    [result release];
}

-(void) testIsSuccessReturnsNoIfailureMessageWasSet {
    IAStatementResult* result = [self newFailedStatementResult];
    
    
    STAssertFalse([result isSuccess], @"");
    [result release];
}

-(void) testIsFailureReturnsNoIfNoFailureMessageWasSet {
    IAStatementResult* result = [self newSuccessfulStatementResult];
    
    
    STAssertFalse([result isFailure], @"");
    [result release];
}

-(void) testIsFailureReturnsYesIfFailureMessageWasSet {
    IAStatementResult* result = [self newFailedStatementResult];
    
    
    STAssertTrue([result isFailure], @"");
    [result release];
}


@end
