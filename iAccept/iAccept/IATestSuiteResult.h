//
//  Created by Pascal Roy on 11-11-09.
//  Copyright 2011 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IATestResult;
@protocol IATestSuite;

@interface IATestSuiteResult : NSObject {
}

@property (nonatomic, retain) id<IATestSuite> testSuite;

- (id)initWithTestSuite : (id<IATestSuite>) aTestSuite;
-(NSString*) getTestSuiteName;

-(int) countTests;
-(int) countFailedTests;
-(int) countSuccessfulTests;
-(int) countStatementResults;
-(double) time;

-(BOOL) isSuccess;
-(BOOL) isFailure;

@end
