//
//  Created by Pascal Roy on 11-12-09.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IABaseScenarioSuite.h"

@interface SampleTestSuiteWithTwoTests : IABaseScenarioSuite {
    
}

@property (nonatomic) int beforeTestCount;
@property (nonatomic) int beforeSuiteCount;
@property (nonatomic) int afterTestCount;
@property (nonatomic) int afterSuiteCount;
@property (nonatomic, retain) NSMutableArray* calledSuiteMethods;

@end
