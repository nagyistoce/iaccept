//
//  IAConfigStatement.h
//  iAccept
//
//  Created by Nicolas Desjardins on 12-02-27.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IABaseBDDStatement.h>
@class IATest;
@class IABaseFixture;

@interface IAConfigStatement : IABaseBDDStatement

- (id)initWithStatementText : (NSString*)theStatementText test : (IATest*) aTest suiteLineNo : (int)theSuiteLineNo; 

@end
