//
//  Created by Pascal Roy on 11-11-09.
//  Copyright 2011 Elapse Technologies. All rights reserved.
//

#import "IATestSuiteResult.h"
#import "IATestResult.h"
#import "IATestSuite.h"
#import "IATest.h"


@implementation IATestSuiteResult

@synthesize testSuite;

- (id)initWithTestSuite : (id<IATestSuite>) aTestSuite
{
    self = [super init];
    if (self) {
        [self setTestSuite : aTestSuite];
    }
    
    return self;
}

-(NSString*) getTestSuiteName {
    return [testSuite getName];
}

-(BOOL) isSuccess {
    return [self countFailedTests] == 0;
}

-(BOOL) isFailure {
    return ![self isSuccess];
}

-(int) countTests {
    int testCount = 0;
    for (IATest* test in testSuite.tests) {
        if (test.testResult!=nil)
            testCount ++; 
    }
    return testCount;
}

-(int) countFailedTests {
    int failures = 0;
    for (IATest* test in testSuite.tests) {
        if ([test.testResult isFailure])
            failures ++; 
    }
    return failures;
}

-(int) countSuccessfulTests {
    int successes = 0;
    for (IATest* test in testSuite.tests) {
        if ([test.testResult isSuccess])
            successes ++; 
    }
    return successes;
}

-(int) countStatementResults {
    int statementCount = 0;
    for (IATest* test in testSuite.tests) {
        statementCount += [test.testResult countStatementResults];
    }
    return statementCount;
}

-(double) time {
    double totalTime = 0;
    for (IATest* test in testSuite.tests) {
        totalTime += [test.testResult time];
    }
    return totalTime;
}

@end
