//
//  Created by Pascal Roy on 11-11-11.
//  Copyright 2011 Elapse Technologies. All rights reserved.
//

#import "objc/runtime.h"

#import "IARunner.h"
#import "IATestSuite.h"
#import "IATestResult.h"
#import "IATestSuiteResult.h"
#import "IATestSuite.h"
#import "IAConfig.h"
#import "IALogger.h"
#import "IATest.h"
#import "IARunnerObserver.h"

NSString* const IA_LOGGER_TESTS_STARTED = @"TESTS_STARTED";

@implementation IARunner

@synthesize testSuites;
@synthesize observers;
@synthesize done;

-(BOOL)isATestSuite:(Class)aClass {
	while (aClass) {
        if (class_conformsToProtocol(aClass, @protocol(IATestSuite) )) {
			return YES;
		}
		aClass = class_getSuperclass(aClass);
	}
	return NO;
}

-(BOOL)isNotBaseSuite:(Class)aClass {
    NSString *searchString = @"Base";
    NSString *className = NSStringFromClass([aClass class]); 
    NSRange range = [className rangeOfString:searchString
                                     options:(NSCaseInsensitiveSearch)];
    
    if (range.location == NSNotFound) {
        return YES;
	}
	return NO;
}

-(NSMutableArray*) discoverAllTestSuiteClasses{
	NSMutableArray *array = [NSMutableArray array];
    int numClasses = objc_getClassList(NULL, 0);
    if (numClasses > 0) {
        Class *classes = malloc(sizeof(Class) * numClasses);
        (void) objc_getClassList (classes, numClasses);
        int i;
        for (i = 0; i < numClasses; i++) {
            Class c = classes[i];
			if ([self isATestSuite:c ] && [self isNotBaseSuite:c]) {
				[array addObject:c];
			}
        }
        free(classes);
    }
	return array;
}


- (id)init
{
    self = [super init];
    if (self) {
        testSuiteClassesToRun = [self discoverAllTestSuiteClasses];
        testSuites = [[NSMutableArray alloc] init];
        observers = [[NSMutableArray alloc]init];
        done = NO;
    }
    
    return self;
}

- (id)initWithSingleTestSuiteClassToRun : (Class) aTestSuiteClassToRun
{
    self = [super init];
    if (self) {
        testSuiteClassesToRun = [[NSMutableArray alloc] init];
        [testSuiteClassesToRun addObject:aTestSuiteClassToRun];
        testSuites = [[NSMutableArray alloc] init];
        observers = [[NSMutableArray alloc]init];
        done = NO;
    }
    
    return self;
}

-(void) dealloc {
    [observers release];
    [testSuites release];
    [super dealloc];
}

-(void) addObserver : (id<IARunnerObserver>)anObserver {
    [observers addObject:anObserver];
}

-(int) countTestSuiteClassesToRun {
    return [testSuiteClassesToRun count];
}

-(id<IATestSuite>) getCurrentlyRunningTestSuite {
    return currentlyRunningTestSuite;
}

-(id<IATestSuite>) newTestSuiteFromTestSuiteClass : (Class) aClass  {
    return [aClass new];
}

-(void) testSuiteDone :  (id<IATestSuite>) aTestSuite {
    NSString* testsResultTitle = [aTestSuite.testSuiteResult isSuccess] ?  @"TEST_SUITE_PASSED" : @"TEST_SUITE_FAILED";
    
    [[IAConfig sharedInstance].logger log : [NSString stringWithFormat : @"%@ [suite=%@, tests=%d, passed=%d, failed=%d time=%fsec]",
          testsResultTitle,                              
          [aTestSuite.testSuiteResult getTestSuiteName], 
          [aTestSuite.testSuiteResult countTests] ,
          [aTestSuite.testSuiteResult countSuccessfulTests] ,
          [aTestSuite.testSuiteResult countFailedTests] , 
          [aTestSuite.testSuiteResult time]]];
    [[IAConfig sharedInstance].logger logEmptyLineSeparator];
    [self performSelector:@selector(runNextTestSuite)];
}

-(int) countTestSuites {
    return [testSuites count];
}

-(int) countAllTests {
    int testCount = 0;
    for (id<IATestSuite> testSuite in testSuites) {
        testCount += [testSuite.testSuiteResult countTests];
    }
    return testCount;
}

-(int) countAllSuccessfulTests {
    int successCount = 0;
    for (id<IATestSuite> testSuite in testSuites) {
        successCount += [testSuite.testSuiteResult countSuccessfulTests];
    }
    return successCount;
}

-(int) countAllFailedTests {
    int failureCount = 0;
    for (id<IATestSuite> testSuite in testSuites) {
        failureCount += [testSuite.testSuiteResult countFailedTests];
    }
    return failureCount;
}

-(int) countAllStatements {
    int statementCount = 0;
    for (id<IATestSuite> testSuite in testSuites) {
        statementCount += [testSuite.testSuiteResult countStatementResults];
    }
    return statementCount;
}

-(double)totalTime {
    double totalTime = 0;
    for (id<IATestSuite> testSuite in testSuites) {
        totalTime += [testSuite.testSuiteResult time];
    }
    return totalTime;
}

-(void) notifyObserversRunnerIsDone {
    for (id<IARunnerObserver> observer in observers) {
        [observer runnerDone : self];
    }
}


-(void) doneRunningAllTestSuites {
    NSString* testsDescription = [self countAllFailedTests] > 0 ? @"TESTS_FAILED" : @"TESTS_PASSED"; 
    [[IAConfig sharedInstance].logger log : [NSString stringWithFormat : @"%@ [suites=%d, tests=%d, tests passed=%d, tests failed=%d, statements=%d, time=%fsec]",
                                                 testsDescription,                                       
                                                 [self countTestSuites],
                                                 [self countAllTests], 
                                                 [self countAllSuccessfulTests] ,
                                                 [self countAllFailedTests],
                                                 [self countAllStatements],
                                                 [self totalTime]] ];    
    [[IAConfig sharedInstance].logger logEmptyLineSeparator];

    done = YES;
    [self notifyObserversRunnerIsDone];
}

-(void) runNextTestSuite {
    if ([testSuiteClassesToRun count] > 0 ) {
        Class runningTestSuiteClass = [testSuiteClassesToRun objectAtIndex:0];
        [testSuiteClassesToRun removeObject:runningTestSuiteClass];
        currentlyRunningTestSuite = [runningTestSuiteClass new];
        [testSuites addObject:currentlyRunningTestSuite];
        [[IAConfig sharedInstance].logger log : [NSString stringWithFormat : @"TEST_SUITE_STARTED [suite=%@]", [currentlyRunningTestSuite getName]]];
        [currentlyRunningTestSuite addObserver:self];
        [currentlyRunningTestSuite runTests];
    }
    else {
        [self doneRunningAllTestSuites];
    }    
}

-(void) runAfterDelay : (int) delayInSeconds {
    if ([testSuiteClassesToRun count] == 0) {
        testSuiteClassesToRun = [self discoverAllTestSuiteClasses];
    }
    [[IAConfig sharedInstance].logger log : IA_LOGGER_TESTS_STARTED];
    [[IAConfig sharedInstance].logger logEmptyLineSeparator];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runNextTestSuite) userInfo:nil repeats:NO];
}

@end
