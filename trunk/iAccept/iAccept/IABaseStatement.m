//
//  Created by Pascal Roy on 12-01-28.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IABaseStatement.h"
#import "IAException.h"

NSString* const IASTATEMENT_NO_MATCHING_SELECTOR_TEMPLATE = @"%@ has no method matching [%@]: at line %d";
NSString* const IASTATEMENT_SELECTOR_THROWS_EXCEPTION_TEMPLATE =@"[%@ %@] threw a %@ [%@]: at line %d";

@implementation IABaseStatement

@synthesize suiteLineNo;
@synthesize parentTest;
@synthesize statementText;

- (id)initWithStatementText : (NSString*)theStatementText test : (IATest*) aTest suiteLineNo : (int)theSuiteLineNo {
    self = [super init];
    if (self) {
        self.parentTest = aTest;
        self.suiteLineNo = theSuiteLineNo;
        self.statementText = theStatementText;
    }
    return self;
}

-(void) dealloc {
    [parentTest release];
    [statementText release];
    [super dealloc];
}

-(NSString*) description {
    return [NSString stringWithFormat:@"%@ : %@", NSStringFromClass([self class]), self.statementText]; 
}


-(IABaseFixture*) newFixture : (NSString*)fixtureClassName {
    return [NSClassFromString(fixtureClassName) new];
}

-(void) run {
    [IAException raise:@"IABaseSatement subclasses must implement run"];
}

@end
