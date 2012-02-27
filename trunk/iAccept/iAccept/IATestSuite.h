//
//  Created by Pascal Roy on 11-11-08.
//  Copyright 2011 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IATest.h>
@class ATTestSuite;
@class IARunner;
@class IATestSuiteResult;
@class IATestResult;
@protocol IATestSuiteObserver;

extern NSString * const IA_TEST_PREFIX;
extern NSString * const IA_BEFORE_SUITE_METHOD_NAME;
extern NSString * const IA_AFTER_SUITE_METHOD_NAME;

@protocol IATestSuite <NSObject>

@property (nonatomic, retain) IATestSuiteResult* testSuiteResult;
@property (nonatomic, retain) NSArray* tests;

-(void) beforeTest;
-(void) afterTest;
-(void) beforeSuite;
-(void) afterSuite;

-(void) runTests;

-(int) countTests;
-(BOOL) containsTestNamed : (NSString*) aTestName;
-(IATest*) getTestNamed : (NSString*) aTestName;

-(id) isEqualTo : (NSObject*)anObject; 
-(NSString*) getName;
-(NSArray*) getTests;

-(BOOL) wasRun;
-(IATestResult*) getTestResultForTestNamed : (NSString*) aTestName;

-(void) addObserver : (id<IATestSuiteObserver>) anObserver;

@end
