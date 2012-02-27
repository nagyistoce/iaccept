//
//  Created by Pascal Roy on 11-11-08.
//  Copyright 2011 Elapse Technologies. All rights reserved.
//

#import "IATestResult.h"
#import "IAStatementResult.h"
#import "IAConfig.h"
#import "IALogger.h"
#import "IATest.h"
#import "IATestSuite.h"
#import "IAStatement.h"

@interface IATestResult() {
}

@property(nonatomic) NSTimeInterval begin;
@property(nonatomic) NSTimeInterval end;

@end

@implementation IATestResult

NSString * const IATEST_RESULT_FAILURE_MESSAGE_TEST_NOT_RUN = @"Test was not run";

@synthesize test;
@synthesize statementResults;
@synthesize begin;
@synthesize end;

- (id) initWithTest : (IATest*) aTest
{
    self = [super init];
    if (self) {
        [self setTest : aTest];
        statementResults = [[NSMutableArray alloc]init];
    }
    
    return self;
}

-(void) dealloc {
    [test release];
    [statementResults release];
    [super dealloc];
}

-(BOOL) isSuccess {
    if (![test wasRun]) { 
        return NO;
    }
    for (IAStatementResult* statementResult in statementResults) {
        if ([statementResult isFailure]) {
            return NO;
        }
    }
    return YES;
}
-(BOOL) isFailure {
    return !([self isSuccess]);
}

-(NSString*) getFailureMessageOfFailedStatement {
    if (![test wasRun]) { 
        return IATEST_RESULT_FAILURE_MESSAGE_TEST_NOT_RUN;
    }
    for (IAStatementResult* statementResult in statementResults) {
        if ([statementResult isFailure]) {
            return statementResult.failureMessage;
        }
    }
    return @"";
}

-(int) getSuiteLineNumberOfFirstFailedStatement {
    for (IAStatementResult* statementResult in statementResults) {
        if ([statementResult isFailure]) {
            return statementResult.statement.suiteLineNo;
        }
    }
    return -1;
}

-(int) getIndexOfFailedStatement {
    int statementIndex = 1;
    for (IAStatementResult* statementResult in statementResults) {
        if ([statementResult isFailure]) {
            return statementIndex;
        }
        statementIndex ++;
    }
    return -1;
}

-(void) addStatementResult : (IAStatementResult*) aStatementResult {
    [statementResults addObject: aStatementResult];
}

-(int) countStatementResults {
    return [statementResults count];
}

-(IAStatementResult*) getStatementResult : (id<IAStatement>)aStatement {
    for (IAStatementResult* statementResult in statementResults) {
        if (statementResult.statement == aStatement) {
            return statementResult;
        }
    }
    return nil;
}

-(void)startChrono {
    begin = [[NSDate date] timeIntervalSinceReferenceDate];
}

-(void)stopChorno {
    end = [[NSDate date] timeIntervalSinceReferenceDate];
}

-(NSTimeInterval)time {
    NSTimeInterval time = end - begin;
    return time;
}

-(void) log {
    if ([self isFailure]) {
        [[IAConfig sharedInstance].logger log : [NSString stringWithFormat: @"TEST_FAILED [test=%@, errorMessage=%@, time=%fsec]", 
                                                     test.name, 
                                                     [self getFailureMessageOfFailedStatement],
                                                     [self time]]];        
    }
    else {
        [[IAConfig sharedInstance].logger log : [NSString stringWithFormat: @"TEST_PASSED [test=%@, statements=%d, time=%fsec]", 
                                                 test.name, 
                                                 [statementResults count] ,
                                                 [self time]]];
    }
}
@end
