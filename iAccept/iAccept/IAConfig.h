//
//  Created by Pascal Roy on 11-11-12.
//  Copyright 2011 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol IALogger;

@interface IAConfig : NSObject

@property (nonatomic, retain) id<IALogger> logger;

@property (nonatomic) double delayBetweenTestsInSeconds;
@property (nonatomic) double delayBetweenTestStatementsInSeconds;
@property (nonatomic) double delayBetweenThenStatementConditionCheckslInSeconds;
@property (nonatomic) double timeoutToMeetThenStatementCondition;
@property (nonatomic) double timeoutToMeetWaitStatementCondition;

+(IAConfig*) sharedInstance;
+(void) reset;

@end
