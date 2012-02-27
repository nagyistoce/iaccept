//
//  Created by Pascal Roy on 11-11-20.
//  Copyright 2011 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol IAStatement;
@class IATestResult;
@protocol IATestSuite;
@class IARunner;
@protocol IATestObserver;
@class IAStatementResult;
@class IABaseFixture;

extern NSString* const IA_BEFORE_TEST_METHOD_NAME;
extern NSString* const IA_AFTER_TEST_METHOD_NAME;
extern NSString* const IA_STATEMENT_DONE_RUNNING_CALLBACK_SELECTOR_NAME;

@interface IATest : NSObject {
    @private
    BOOL wasRun;
}

@property (nonatomic,retain) NSString* name;
@property (nonatomic,retain,readonly) NSMutableArray* statementsToRunQueue;
@property (nonatomic,retain) id<IATestSuite> testSuite;
@property (nonatomic,retain) IATestResult* testResult;
@property (nonatomic,retain) NSMutableArray* observers;
@property (nonatomic, retain) IABaseFixture* currentFixture;

- (id)initWithName : (NSString*) aName testSuite : (id<IATestSuite>) aTestSuite;

-(BOOL) hasMoreStatementsToRun;
-(int) countStatementsToRun;
-(id<IAStatement>) peekStatementToRunAtIndex : (int) anIndex;
-(void) enqueueStatementToRun : (id<IAStatement>) aStatement;


-(void) recordExecuteStatement:(void (^)())aValidateBlock statementText : (NSString*) theStatementText suiteLineNo : (int)theSuiteLineNo;
-(void) recordWaitStatement : (BOOL (^)())aWaitConditionBlock suiteLineNo : (int)theSuiteLineNo;
-(void) recordExecuteAndWaitStatement :(void (^)())aValidateBlock waitConditionBlock:(BOOL (^)())aWaitConditionBlock suiteLineNo : (int)theSuiteLineNo;

-(id<IAStatement>) recordGivenStatement : (NSString*) theStatementText suiteLineNo : (int)theSuiteLineNo;
-(id<IAStatement>) recordThenStatement : (NSString*) theStatementText suiteLineNo : (int)theSuiteLineNo;
-(id<IAStatement>) recordWhenStatement : (NSString*) theStatementText suiteLineNo : (int)theSuiteLineNo;
-(id<IAStatement>) recordConfigStatement : (NSString*) theStatementText suiteLineNo : (int)theSuiteLineNo;

-(BOOL) wasRun;
-(void) run;
-(void) addObserver : (id<IATestObserver>) anObserver;

-(void) statementDoneRunning : (IAStatementResult*) aStatementResult;
-(BOOL) wasStatementRun : (id<IAStatement>) aStatement;

@end
