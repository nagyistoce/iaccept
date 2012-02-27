//
//  Created by Pascal Roy on 11-12-21.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import "SampleTestSuiteTestingGivenWhenThen.h"
#import "IABaseScenarioSuite.h"

@implementation SampleTestSuiteTestingGivenWhenThen

-(void) scenarioWithGivenStatement {
    IAGiven(Some thing I did that worked);
}

-(void) scenarioWithWhenStatement {
    IAWhen(I do whatever);
}

-(void) scenarioWithThenStatement {
    IAThen(Sample window is visible);
}

@end
