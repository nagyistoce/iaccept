//
//  Created by Pascal Roy on 11-12-25.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IABaseBDDStatement.h>
@class IABaseFixture;

@interface IAThenStatement : IABaseBDDStatement

@property (nonatomic, retain) NSDate* startTime;
@property (nonatomic) double timeOutInSeconds;

- (id)initWithStatementText : (NSString*)theStatementText test : (IATest*) aTest suiteLineNo : (int)theSuiteLineNo; 
- (id)initWithStatementText : (NSString*)theStatementText test : (IATest*) aTest suiteLineNo : (int)theSuiteLineNo timeoutInSeconds: (double) aTimeoutInSeconds;

@end
