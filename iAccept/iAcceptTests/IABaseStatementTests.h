//
//  Created by Pascal Roy on 12-01-27.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
@protocol IAFixture;
@class IATest;

@interface IABaseStatementTests : SenTestCase

-(IATest*)stubTestThatWasRun : (IATest*)aTest withCurrentFixture:(id<IAFixture>) aFixture;

@end
