//
//  Created by Pascal Roy on 12-01-28.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAStatement.h>
@class IATest;
@class IABaseFixture;

extern NSString* const IASTATEMENT_NO_MATCHING_SELECTOR_TEMPLATE;
extern NSString* const IASTATEMENT_SELECTOR_THROWS_EXCEPTION_TEMPLATE;

@interface IABaseStatement : NSObject<IAStatement>

- (id)initWithStatementText : (NSString*)theStatementText test : (IATest*) aTest suiteLineNo : (int)theSuiteLineNo;
-(IABaseFixture*) newFixture : (NSString*)fixtureClassName;

@end
