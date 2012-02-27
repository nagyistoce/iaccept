//
//  Created by Pascal Roy on 11-11-08.
//  Copyright 2011 Elapse Technologies. All rights reserved.
//

#import "objc/runtime.h"
#import <Foundation/Foundation.h>
#import <Framework-iAccept/IATestSuite.h>
#import <Framework-iAccept/IATestObserver.h>
@class IATestResult;
@class IATest;
@class IARunner;
@class IATestSuiteResult;


#define IARecordExecute( executeCodeBlock )   ({ \
NSString* theStatementText = @"#executeCodeBlock"; \
[self.currentlyRunningTest recordExecuteStatement : ^{ executeCodeBlock; } statementText : theStatementText suiteLineNo : __LINE__]; \
}) \

#define IARecordWait( waitCodeBlock )   ({ \
[self.currentlyRunningTest recordWaitStatement : (BOOL (^)()) ^{ waitCodeBlock; } suiteLineNo : __LINE__]; \
}) \

#define IARecordExecuteAndWait( executeCodeBlock, waitCodeBlock )   ({ \
[self.currentlyRunningTest recordExecuteAndWaitStatement : ^{ executeCodeBlock; } waitConditionBlock : (BOOL (^)()) ^{ waitCodeBlock; } suiteLineNo : __LINE__]; \
}) \

#define IAGiven( givenStatement )   ({ \
long lengthOfGivenStatementText = sizeof(#givenStatement)-1; \
NSString* givenStatementText = [[NSString alloc] initWithBytes:#givenStatement length:lengthOfGivenStatementText encoding:NSASCIIStringEncoding]; \
[self.currentlyRunningTest recordGivenStatement : givenStatementText suiteLineNo : __LINE__]; \
}) \

#define IAThen( thenStatement )    ({ \
long lengthOfThenStatementText = sizeof(#thenStatement)-1; \
NSString* thenStatementText = [[NSString alloc] initWithBytes:#thenStatement length:lengthOfThenStatementText encoding:NSASCIIStringEncoding]; \
[self.currentlyRunningTest recordThenStatement : thenStatementText suiteLineNo : __LINE__]; \
}) \

#define IAThenText ( thenStatementAsText )    ({ \
NSString* thenStatementText = thenStatementAsText; \
[self.currentlyRunningTest recordThenStatement : thenStatementText suiteLineNo : __LINE__]; \
}) \

#define IAWhen( whenStatement )    ({ \
long lengthOfWhenStatementText = sizeof(#whenStatement)-1; \
NSString* whenStatementText = [[NSString alloc] initWithBytes:#whenStatement length:lengthOfWhenStatementText encoding:NSASCIIStringEncoding]; \
[self.currentlyRunningTest recordWhenStatement : whenStatementText suiteLineNo : __LINE__]; \
}) \

#define IASetConfig( configStatement )    ({ \
long lengthOfConfigStatementText = sizeof(#configStatement)-1; \
NSString* configStatementText = [[NSString alloc] initWithBytes:#configStatement length:lengthOfConfigStatementText encoding:NSASCIIStringEncoding]; \
[self.currentlyRunningTest recordConfigStatement : configStatementText suiteLineNo : __LINE__]; \
}) \

@interface IABaseScenarioSuite : NSObject<IATestSuite, IATestObserver> {
@private
    BOOL wasRun;
}

@property (nonatomic, retain) NSMutableArray* testsToRun;
@property (nonatomic, retain) IATest* currentlyRunningTest;
@property (nonatomic, retain) NSMutableArray* observers;

-(void) selectTestToRun : (NSString*) aTestName;

@end
