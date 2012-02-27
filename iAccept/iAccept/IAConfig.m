//
//  Created by Pascal Roy on 11-11-12.
//  Copyright 2011 Elapse Technologies. All rights reserved.
//

#import "IAConfig.h"
#import "IAConsoleLogger.h"

@implementation IAConfig

@synthesize delayBetweenTestsInSeconds;
@synthesize logger;
@synthesize timeoutToMeetWaitStatementCondition;
@synthesize delayBetweenThenStatementConditionCheckslInSeconds;
@synthesize delayBetweenTestStatementsInSeconds;
@synthesize timeoutToMeetThenStatementCondition;

-(id) init {
    self = [super init];
    if (self) {
        logger = [[IAConsoleLogger alloc]init];
        delayBetweenTestsInSeconds = 0.01;
        delayBetweenTestStatementsInSeconds = 0.01;
        delayBetweenThenStatementConditionCheckslInSeconds = 0.1;
     
        timeoutToMeetThenStatementCondition = 30.0;        
        timeoutToMeetWaitStatementCondition = 10.0;
    }
    return self;
}

static IAConfig* testConfig;

+(IAConfig*) sharedInstance {
    if (testConfig == nil) {
        testConfig = [[IAConfig alloc] init];
    }
    return testConfig;    
}

-(void) dealloc {
    [logger release];
    [super dealloc];
}

+(void) reset {
    [testConfig release];
    testConfig = nil;
}

@end
