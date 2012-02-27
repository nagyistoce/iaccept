//
//  Created by Pascal Roy on 11-12-13.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import "IAAssertTests.h"
#import "IAAssert.h"

@implementation IAAssertTests

- (void)testAssertFail_throwsException
{
    NSString* errorMessage = @"Error message";
    @try {
        IAAssertFail(errorMessage);
        STFail(@"Should have thrown exception");
    }
    @catch (NSException *exception) {
        STAssertEqualObjects(exception.name, @"IAException", @"");
        STAssertEqualObjects(exception.reason, errorMessage, @"");
    }
}

- (void)testAssertTrue_doesNothingIfTrue
{
    NSString* errorMessage = @"Error message";
    @try {
        IAAssertTrue(TRUE, errorMessage);
    }
    @catch (NSException *exception) {
        STFail(@"Should not have thrown exception");
    }
}

- (void)testAssertTrue_throwsExceptionIfFalse
{
    NSString* errorMessage = @"Error message";
    @try {
        IAAssertTrue(FALSE, errorMessage);
        STFail(@"Should have thrown exception");
    }
    @catch (NSException *exception) {
        STAssertEqualObjects(exception.name, @"IAException", @"");
        STAssertEqualObjects(exception.reason, errorMessage, @"");
    }
}

- (void)testAssertFalse_doesNothingIfFalse
{
    NSString* errorMessage = @"Error message";
    @try {
        IAAssertFalse(FALSE, errorMessage);
    }
    @catch (NSException *exception) {
        STFail(@"Should not have thrown exception");
    }
}

- (void)testAssertFalse_throwsExceptionIfTrue
{
    NSString* errorMessage = @"Error message";
    @try {
        IAAssertFalse(TRUE, errorMessage);
        STFail(@"Should have thrown exception");
    }
    @catch (NSException *exception) {
        STAssertEqualObjects(exception.name, @"IAException", @"");
        STAssertEqualObjects(exception.reason, errorMessage, @"");
    }
}

@end
