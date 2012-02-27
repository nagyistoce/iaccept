//
//  Created by Pascal Roy on 11-11-08.
//  Copyright 2011 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IAStatementResult;
@class IATest;
@protocol IAStatement;

extern NSString * const IATEST_RESULT_FAILURE_MESSAGE_TEST_NOT_RUN;

@interface IATestResult : NSObject

@property (nonatomic, retain) IATest* test;
@property (nonatomic, retain) NSMutableArray* statementResults;

- (id) initWithTest : (IATest*) aTest;

-(BOOL) isSuccess;
-(BOOL) isFailure;

-(void) addStatementResult : (IAStatementResult*) aStatementResult;
-(IAStatementResult*) getStatementResult : (id<IAStatement>)aStatement;
-(int) countStatementResults;
-(void) log;

-(void)startChrono;
-(void)stopChorno;

-(NSTimeInterval)time;

-(NSString*) getFailureMessageOfFailedStatement;

@end
