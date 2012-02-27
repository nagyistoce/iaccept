//
//  Created by Pascal Roy on 12-01-27.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "IABaseStatement.h"
#import "IABaseStatementTests.h"
#import "IATest.h"
#import "IAFixture.h"
#import "IABaseFixture.h"

@implementation IABaseStatementTests


-(IATest*)stubTestThatWasRun : (IATest*)aTest withCurrentFixture:(id<IAFixture>) aFixture {
    id stubTest = [OCMockObject partialMockForObject:aTest];
    BOOL wasRun = YES;
    [[[stubTest stub] andReturnValue:OCMOCK_VALUE(wasRun)] wasRun];
    ((IATest*)stubTest).currentFixture = aFixture;
    return (IATest*)stubTest;    
}

@end
