//
//  Created by Pascal Roy on 11-12-12.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import "IARunnerTests.h"
#import "IARunner.h"
#import "SampleEmptyTestSuite.h"
#import "IAAsyncMacros.h"
#import "SampleTestSuiteWithOnePassingTest.h"
#import "SampleTestSuiteWithOneFailingTest.h"
#import "IAInMemoryLogger.h"
#import "IALogger.h"
#import "IAConfig.h"
#import "IALogger.h"

@implementation IARunnerTests

-(void) setUp {
    runnerDone = NO;
}

-(void) tearDown {
    [IAConfig reset];
}

-(void) runnerDone : (IARunner*) aRunner {
    runnerDone = YES;
}


-(void) testInitWithSingleTestSuiteClassToRun  {
    IARunner* runner = [[IARunner alloc]initWithSingleTestSuiteClassToRun:[SampleEmptyTestSuite class]];
                        
    STAssertEquals([runner countTestSuiteClassesToRun], 1, @"");
    STAssertNil([runner getCurrentlyRunningTestSuite], @"");
    [runner release];
}

- (void)testInit_discoversAllTestSuiteClasses {
    IARunner* runner = [[IARunner alloc]init];
    
    STAssertEquals([runner countTestSuiteClassesToRun], 6, @"");
    STAssertNil([runner getCurrentlyRunningTestSuite], @"");
    [runner release];
}

- (void)testRunAllTestsNotifiesObserverWhenDone {
    IARunner* runner = [[IARunner alloc]initWithSingleTestSuiteClassToRun:[SampleTestSuiteWithOnePassingTest class]];
    [runner addObserver : self];
    
    [runner runAfterDelay: 1.0];
    STAssertFalse([runner isDone], @"");

    IAAsyncAssertTrue(runnerDone, 10.0);

    [runner release];
}

- (void)testRunAllTests_LogsTestResultsForPassingTests  {    
    IARunner* runner = [[IARunner alloc]initWithSingleTestSuiteClassToRun:[SampleTestSuiteWithOnePassingTest class]];
    IAInMemoryLogger* inMemoryLogger = [[IAInMemoryLogger alloc] init];
    [[IAConfig sharedInstance] setLogger : inMemoryLogger];    
    [runner addObserver : self];
    
    [runner runAfterDelay: 1.0];
    IAAsyncAssertTrue(runnerDone, 10.0);
    
    STAssertEqualObjects([inMemoryLogger getLogEntry : 0], IA_LOGGER_TESTS_STARTED, @"");
    STAssertEqualObjects([inMemoryLogger getLogEntry : 1], IA_LOGGER_EMPTY_LINE_SEPARATOR_TEXT, @"");
    STAssertEqualObjects([inMemoryLogger getLogEntry : 2], @"TEST_SUITE_STARTED [suite=SampleTestSuiteWithOnePassingTest]", @"");

    STAssertTrue([[inMemoryLogger getLogEntry : 3] hasPrefix:@"TEST_PASSED [test=scenarioOne, statements=0, time="],@"");
    STAssertTrue([[inMemoryLogger getLogEntry : 3] hasSuffix:@"sec]"],@"");
    
    STAssertTrue([[inMemoryLogger getLogEntry : 4] hasPrefix:@"TEST_SUITE_PASSED [suite=SampleTestSuiteWithOnePassingTest, tests=1, passed=1, failed=0 time="],@"");
    STAssertTrue([[inMemoryLogger getLogEntry : 4] hasSuffix:@"sec]"],@"");
    
    STAssertEqualObjects([inMemoryLogger getLogEntry : 5], IA_LOGGER_EMPTY_LINE_SEPARATOR_TEXT, @"");

    STAssertTrue([[inMemoryLogger getLogEntry : 6] hasPrefix:@"TESTS_PASSED [suites=1, tests=1, tests passed=1, tests failed=0, statements=0, time="],@"");
    STAssertTrue([[inMemoryLogger getLogEntry : 6] hasSuffix:@"sec]"],@"");
    
    STAssertEqualObjects([inMemoryLogger getLogEntry : 7], IA_LOGGER_EMPTY_LINE_SEPARATOR_TEXT, @"");

    [runner release];
}

- (void)testRunAllTests_LogsTestResultsForFailingTests  {    
    IARunner* runner = [[IARunner alloc]initWithSingleTestSuiteClassToRun:[SampleTestSuiteWithOneFailingTest class]];
    IAInMemoryLogger* inMemoryLogger = [[IAInMemoryLogger alloc] init];
    [[IAConfig sharedInstance] setLogger : inMemoryLogger];    
    [runner addObserver : self];
    
    [runner runAfterDelay: 1.0];
    IAAsyncAssertTrue(runnerDone, 10.0);
    
    STAssertEqualObjects([inMemoryLogger getLogEntry : 0], IA_LOGGER_TESTS_STARTED, @"");
    STAssertEqualObjects([inMemoryLogger getLogEntry : 1], IA_LOGGER_EMPTY_LINE_SEPARATOR_TEXT, @"");
    STAssertEqualObjects([inMemoryLogger getLogEntry : 2], @"TEST_SUITE_STARTED [suite=SampleTestSuiteWithOneFailingTest]", @"");
    
    NSLog(@"logEntry3 =%@", [inMemoryLogger getLogEntry:3]); 

    STAssertTrue([[inMemoryLogger getLogEntry : 3] hasPrefix:@"TEST_FAILED [test=scenarioOne, errorMessage=IAException:Test failed at line 12, time="],@"");
    STAssertTrue([[inMemoryLogger getLogEntry : 3] hasSuffix:@"sec]"],@"");
    
    STAssertTrue([[inMemoryLogger getLogEntry : 4] hasPrefix:@"TEST_SUITE_FAILED [suite=SampleTestSuiteWithOneFailingTest, tests=1, passed=0, failed=1 time="],@"");
    STAssertTrue([[inMemoryLogger getLogEntry : 4] hasSuffix:@"sec]"],@"");
    
    STAssertEqualObjects([inMemoryLogger getLogEntry : 5], IA_LOGGER_EMPTY_LINE_SEPARATOR_TEXT, @"");

    STAssertTrue([[inMemoryLogger getLogEntry : 6] hasPrefix:@"TESTS_FAILED [suites=1, tests=1, tests passed=0, tests failed=1, statements=1, time="],@"");
    STAssertTrue([[inMemoryLogger getLogEntry : 6] hasSuffix:@"sec]"],@"");
    
    STAssertEqualObjects([inMemoryLogger getLogEntry : 7], IA_LOGGER_EMPTY_LINE_SEPARATOR_TEXT, @"");
    
    [runner release];
}


@end
