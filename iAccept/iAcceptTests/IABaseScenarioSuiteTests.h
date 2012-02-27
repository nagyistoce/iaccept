//
//  Created by Pascal Roy on 11-12-09.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "IATestSuiteObserver.h"

@interface IABaseScenarioSuiteTests : SenTestCase <IATestSuiteObserver> {
    @private
    BOOL testSuiteRun;
}

@end
