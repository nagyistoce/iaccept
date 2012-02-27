//
//  Created by Pascal Roy on 11-12-09.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import "SampleScenarioSuiteTwoScenariosWithStatements.h"
#import "IAException.h"

@implementation SampleScenarioSuiteTwoScenariosWithStatements

-(void) executeScenarioOneCodeBlock1 {
}

-(BOOL) waitScenarioOneCodeBlock1 {
    return YES;
}

-(void) executeScenarioOneCodeBlock2 {
}

-(BOOL) waitScenarioOneCodeBlock2 {
    return YES;
}

-(void) executeScenarioTwoCodeBlock {
    [IAException raise:@"Exception description"]; 
}

-(void) scenarioOne {
    IARecordExecute([self executeScenarioOneCodeBlock1];);
    IARecordWait([self waitScenarioOneCodeBlock1];);
    IARecordExecuteAndWait([self executeScenarioOneCodeBlock2], [self waitScenarioOneCodeBlock2]);
}

-(void) scenarioTwo {
    IARecordExecute([self executeScenarioTwoCodeBlock];);
}


@end
