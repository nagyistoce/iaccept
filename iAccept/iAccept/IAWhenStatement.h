//
//  Created by Pascal Roy on 11-12-29.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IABaseBDDStatement.h>
@class IATest;
@class IABaseFixture;

@interface IAWhenStatement : IABaseBDDStatement

- (id)initWithStatementText : (NSString*)theStatementText test : (IATest*) aTest suiteLineNo : (int)theSuiteLineNo; 

@end
