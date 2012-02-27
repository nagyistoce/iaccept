//
//  Created by Pascal Roy on 11-12-12.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import "SampleTestSuiteWithOneFailingTest.h"
#import "IAAssert.h"

@implementation SampleTestSuiteWithOneFailingTest

-(void) scenarioOne {
    IARecordExecute(IAAssertFail(@"Test failed"));
}

@end
