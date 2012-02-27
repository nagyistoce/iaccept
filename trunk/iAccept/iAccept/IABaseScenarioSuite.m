//
//  Created by Pascal Roy on 11-11-08.
//  Copyright 2011 Elapse Technologies. All rights reserved.
//

#import "IABaseScenarioSuite.h"
#import "IARunner.h"
#import "IAIsEqualTo.h"
#import "IATestResult.h"
#import "IAStatementResult.h"
#import "IAConfig.h"
#import "IAExecuteStatement.h"
#import "IAExecuteAndWaitStatement.h"
#import "IAWaitStatement.h"
#import "IATest.h"
#import "IATestSuiteResult.h"
#import "IATestSuiteObserver.h"

NSString * const IA_TEST_PREFIX = @"scenario";
NSString * const IA_BEFORE_SUITE_METHOD_NAME = @"beforeSuite";
NSString * const IA_AFTER_SUITE_METHOD_NAME = @"afterSuite";

@implementation IABaseScenarioSuite

@synthesize tests;
@synthesize testsToRun;
@synthesize observers;
@synthesize currentlyRunningTest;
@synthesize testSuiteResult;

-(void) addNewTestToArray : (NSMutableArray*) anArray forTestNamed : (NSString*) aTestName {
    IATest* test = [[IATest alloc] initWithName : aTestName testSuite:self]; 
    [anArray addObject:test];
    [test release];
} 

-(NSArray*) discoverTestMethods {
    NSMutableArray *tempTests = [NSMutableArray array];
	unsigned int methodCount;
    Class aTestSuiteClass = [self class];
	Method *methods = class_copyMethodList(aTestSuiteClass, &methodCount);
    
	for (size_t i = 0; i < methodCount; ++i) {
		Method method = methods[i];
		SEL selector = method_getName(method);        
        NSString *selectorName = NSStringFromSelector(selector);
        
        if ([selectorName hasPrefix:IA_TEST_PREFIX]) {
            [self addNewTestToArray:tempTests forTestNamed:selectorName];
        }

	}
    return tempTests;
}

-(int) countTests {
    return [tests count];
}


-(id) init {
    self = [super init]; 
    if (self) {
        wasRun = NO;
        [self setTests : [self discoverTestMethods]];        
        [self setTestsToRun : [NSMutableArray arrayWithArray:tests]];
        observers = [[NSMutableArray alloc] init];
        testSuiteResult = [[IATestSuiteResult alloc] initWithTestSuite : self];
    }
    return self;
}

-(void) addObserver : (id<IATestSuiteObserver>) anObserver {
    [observers addObject:anObserver];
}

-(void) dealloc {
    [tests release];
    [testsToRun release];
    [observers release];
    [testSuiteResult release];
    [super dealloc];
}

-(void) beforeSuite {
}

-(void) beforeTest {
}

-(void) afterTest {
}

-(void) afterSuite {
}

-(id) isEqualTo : (NSObject*)aTargetObject {
    return [[[IAIsEqualTo alloc] initWithObject:aTargetObject] autorelease];
}

-(id) isEqualTo : (NSObject*)aTargetObject message: (NSString*) aMessage {
    return [[[IAIsEqualTo alloc] initWithObject:aTargetObject errorMessage:aMessage] autorelease];
}

-(NSString*) getName {
    return NSStringFromClass([self class]);
}

-(NSArray*) getTests {
    return tests;
}

-(void) selectTestToRun : (NSString*) aTestName {
    currentlyRunningTest = [self getTestNamed : aTestName];
}

-(void) callAfterTestMethod {
    SEL afterTestSelector = NSSelectorFromString(IA_AFTER_TEST_METHOD_NAME);
    [self performSelector:afterTestSelector];    
}

-(void) testDone : (IATest*) aTest {
    [self callAfterTestMethod];
    [aTest.testResult log];
    [self performSelector : @selector(runNextTest)];
}


-(IATest*) getTestNamed : (NSString*) aTestName {
    for (IATest* test in tests) {
        if ([test.name isEqualToString:aTestName]) {
            return test;
        }
    }
    return nil;
}

-(BOOL) containsTestNamed : (NSString*) aTestName {
    for (IATest* test in tests) {
        if ([test.name isEqualToString:aTestName]) {
            return YES;
        }
    }
    return NO;
}

-(void) callAfterSuiteMethod {
    SEL beforeSuiteSelector = NSSelectorFromString(IA_AFTER_SUITE_METHOD_NAME);
    [self performSelector:beforeSuiteSelector];
}

-(void) notifyObserversSuiteIsDoneRunning {
    for (id<IATestSuiteObserver> observer in observers) {
        [observer testSuiteDone : self];
    }
}

-(BOOL) thereAreTestsLeftToRun {
    return [testsToRun count] > 0;
}

-(void) callBeforeTestMethod {
    SEL beforeTestSelector = NSSelectorFromString(IA_BEFORE_TEST_METHOD_NAME);
    [self performSelector:beforeTestSelector];
}

-(void) runNextTest {
    if ( [self thereAreTestsLeftToRun] ) {
        currentlyRunningTest = [testsToRun objectAtIndex:0];
        [self callBeforeTestMethod];
        [currentlyRunningTest addObserver:self];
        [currentlyRunningTest run];
        [testsToRun removeObjectAtIndex:0];
    }        
    else {
        [self callAfterSuiteMethod];
        wasRun = YES;
        [self notifyObserversSuiteIsDoneRunning];
    }
    
}

-(void) callBeforeSuiteMethod {
    SEL beforeSuiteSelector = NSSelectorFromString(IA_BEFORE_SUITE_METHOD_NAME);
    [self performSelector:beforeSuiteSelector];
}

-(BOOL) wasRun {
    return wasRun;
}

- (void) runTests {
    [self callBeforeSuiteMethod];
    [self performSelector:@selector(runNextTest)];
}

-(IATestResult*) getTestResultForTestNamed : (NSString*) aTestName {
    IATest* test = [self getTestNamed:aTestName];
    if (test) {
        return test.testResult;
    }
    else {
        return nil;
    }
}


@end
