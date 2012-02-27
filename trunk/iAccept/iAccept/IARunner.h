//
//  Created by Pascal Roy on 11-11-11.
//  Copyright 2011 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IATestSuiteObserver.h>
@protocol IATestSuite;
@class IATestSuiteResult;
@class IATest;
@protocol IARunnerObserver;

@interface IARunner : NSObject<IATestSuiteObserver>  {
@private
    NSMutableArray* testSuiteClassesToRun;
    id<IATestSuite> currentlyRunningTestSuite;
}

@property (nonatomic, retain) NSMutableArray* testSuites;
@property (nonatomic, getter=isDone) BOOL done;
@property (nonatomic, retain) NSMutableArray* observers;

-(id) initWithSingleTestSuiteClassToRun : (Class) aTestSuiteClassToRun;
-(void) runAfterDelay : (int) delayInSeconds;

-(int) countTestSuiteClassesToRun;
-(id<IATestSuite>) getCurrentlyRunningTestSuite;

-(void) addObserver : (id<IARunnerObserver>)anObserver;

-(int) countTestSuites;
-(int) countAllTests;
-(int) countAllSuccessfulTests;
-(int) countAllFailedTests;
-(int) countAllStatements;

@end
