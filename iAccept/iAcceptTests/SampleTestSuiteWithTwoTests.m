//
//  Created by Pascal Roy on 11-12-09.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import "SampleTestSuiteWithTwoTests.h"
#import "IATest.h"

@implementation SampleTestSuiteWithTwoTests
@synthesize beforeTestCount;
@synthesize beforeSuiteCount;
@synthesize afterTestCount;
@synthesize afterSuiteCount;
@synthesize calledSuiteMethods;


-(id) init {
    self = [super init];
    if (self) {
        calledSuiteMethods = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) dealloc {
    [calledSuiteMethods release];
    [super dealloc];
}

-(void) beforeSuite {
    beforeSuiteCount++;
    [calledSuiteMethods addObject : IA_BEFORE_SUITE_METHOD_NAME];
}

-(void) beforeTest {
    NSLog(@"SampleTestSuiteWithTwoTests beforeTest");
    beforeTestCount++;
    [calledSuiteMethods addObject : IA_BEFORE_TEST_METHOD_NAME];
}

-(void) afterTest {
    NSLog(@"SampleTestSuiteWithTwoTests afterTest");
    afterTestCount++;
    [calledSuiteMethods addObject : IA_AFTER_TEST_METHOD_NAME];
}

-(void) afterSuite {
    afterSuiteCount++;
    [calledSuiteMethods addObject : IA_AFTER_SUITE_METHOD_NAME];
}

-(void) scenarioOne {
}

-(void) scenarioTwo {
}



@end
