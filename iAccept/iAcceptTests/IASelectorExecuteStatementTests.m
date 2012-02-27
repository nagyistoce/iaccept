//
//  Created by Pascal Roy on 11-12-21.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "IASelectorExecuteStatement.h"
#import "IASelectorExecuteStatementTests.h"
#import "IAStatementResult.h"
#import "IATest.h"

@implementation IASelectorExecuteStatementTests
@synthesize someSelectorMethodWasCalled;


-(void) setUp {
    someSelectorMethodWasCalled = NO;
}

-(void) someSelectorMethod {
    someSelectorMethodWasCalled = YES;
}

-(void) testInit {    
    NSObject* targetOfSelector = self;
    SEL selector = @selector(someSelectorMethod);
    id mockTest = [OCMockObject mockForClass:[IATest class]];
    int suiteLineNo = 11;
    
    
    IASelectorExecuteStatement* statement =  [[IASelectorExecuteStatement alloc] initWithSelector : selector onTargetOfSelector : targetOfSelector test : mockTest suiteLineNo : suiteLineNo];

    
    STAssertEquals([statement getTargetOfSelector], targetOfSelector, @"");
    STAssertEquals([statement getSelector], selector, @"");
    STAssertEquals(statement.parentTest, mockTest, @"");
    STAssertEquals(statement.suiteLineNo, suiteLineNo, @"");
    [statement release];
}

-(void) testRun {  
    NSObject* targetOfSelector = self;
    SEL selector = @selector(someSelectorMethod:);
    id mockTest = [OCMockObject mockForClass:[IATest class]];
    int suiteLineNo = 11;
    IASelectorExecuteStatement* statement =  [[IASelectorExecuteStatement alloc] initWithSelector : selector onTargetOfSelector : targetOfSelector test : mockTest suiteLineNo : suiteLineNo];
    [[mockTest expect] statementDoneRunning : [OCMArg checkWithBlock:^(id value) { return [value isKindOfClass:[IAStatementResult class]]; }]];
    

    [statement run];
    

    [statement release];
}

@end
