//
//  Created by Pascal Roy on 11-12-13.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import "IAIsEqualToTests.h"
#import "IAIsEqualTo.h"

@implementation IAIsEqualToTests

-(void) testInitWitObject {
    NSObject* someObject = @"Some object";
    IAIsEqualTo* operator = [[IAIsEqualTo alloc] initWithObject:someObject];
    
    STAssertEqualObjects(operator.targetObject, someObject, @"");
    STAssertNil(operator.errorMessage, @"", @"");    
    [operator release];
}

-(void) testInitWitObjectAndMessage {
    NSObject* someObject = @"Some object";
    NSString* someMessage = @"Some message";
    IAIsEqualTo* operator = [[IAIsEqualTo alloc] initWithObject:someObject errorMessage:someMessage];
    
    STAssertEqualObjects(operator.targetObject, someObject, @"");
    STAssertEqualObjects(operator.errorMessage, someMessage, @"");    
    [operator release];
}

-(void) testValidateObjectsAreEqual_ifTrueDoesNothing {
    NSObject* someObject1 = @"Some object";
    NSObject* someObject2 = @"Some object";
    IAIsEqualTo* operator = [[IAIsEqualTo alloc] initWithObject:someObject2];
    
    
    @try {
        [operator operateOn: someObject1];
    }
    @catch (NSException *exception) {
        STFail(@"Should not have thrown exception");
    }    
    
    
    [operator release];
}

-(void) testOperateOnObjects_doesNothingIfObjectsAreEqual {
    NSObject* someObject1 = @"Some object";
    NSObject* someObject2 = @"Some object";
    IAIsEqualTo* operator = [[IAIsEqualTo alloc] initWithObject:someObject2];
    
    
    @try {
        [operator operateOn: someObject1];
    }
    @catch (NSException *exception) {
        STFail(@"Should not have thrown exception");
    }    
    
    
    [operator release];
}

-(void) testOperateOnObjects_throwsExceptionIfObjectsAreNotEqual {
    NSObject* someObject1 = @"Some object1";
    NSObject* someObject2 = @"Some object2";
    IAIsEqualTo* operator = [[IAIsEqualTo alloc] initWithObject:someObject2];
    
    
    @try {
        [operator operateOn: someObject1];
        STFail(@"Should have thrown exception");
    }
    @catch (NSException *exception) {
        STAssertEqualObjects(exception.reason, @"Expected Some object2, was Some object1", @"");
    }    
    
    
    [operator release];
}

-(void) testOperateOnObjects_throwsExceptionIfObjectsAreNotEqual_withMessage {
    NSObject* someObject1 = @"Some object1";
    NSObject* someObject2 = @"Some object2";
    NSString* errorMessage = @"Error message";
    IAIsEqualTo* operator = [[IAIsEqualTo alloc] initWithObject:someObject2 errorMessage:errorMessage];
    
    
    @try {
        [operator operateOn: someObject1];
        STFail(@"Should have thrown exception");
    }
    @catch (NSException *exception) {
        STAssertEqualObjects(exception.reason, @"Expected Some object2, was Some object1 : Error message", @"");
    }   
    
    
    [operator release];
}



@end
