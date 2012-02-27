//
//  Created by Pascal Roy on 11-12-29.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import "IAWhenStatement.h"
#import "IATest.h"
#import "IAStatementResult.h"
#import "IAFixtureProvider.h"
#import "IAWhenStatementParser.h"
#import "IABaseFixture.h"
#import "IASelectorMatcher.h"
#import "IASelector.h"
#import "IAParsedStatement.h"

@implementation IAWhenStatement

- (id)initWithStatementText : (NSString*)theStatementText test : (IATest*) aTest suiteLineNo : (int)theSuiteLineNo {
    self = [super initWithStatementText : theStatementText test:aTest suiteLineNo:theSuiteLineNo];
    if (self) {
    }
    return self;    
}

-(void) dealloc {
    [super dealloc];
}

-(void) run {
    IAWhenStatementParser* statementParser = [[IAWhenStatementParser alloc] initWithText:self.statementText];
    IAParsedStatement* parsedStatement = [statementParser parse];
    [self setFixtureFromParsedStatement : parsedStatement];
    [self performStatementSelector : parsedStatement];
    [statementParser release];
}

@end
