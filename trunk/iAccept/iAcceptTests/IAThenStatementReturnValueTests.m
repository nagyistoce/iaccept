//
//  Created by Pascal Roy on 12-01-18.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAThenStatementReturnValueTests.h"
#import "IAThenResult.h"

@implementation IAThenStatementReturnValueTests

-(void)testMakeThenConditionMetValue {
    IAThenResult* value = [IAThenResult makeThenStatementConditionMetReturnValue];
    
    
    STAssertTrue([value thenStatementConditionMet], @"");
}

-(void)testMakeTheConditionNotMetValue {
    NSString* aConditionNotMetErrorMessage = @"An error message";
    IAThenResult* value = [IAThenResult makeThenStatementConditionNotMetValue:aConditionNotMetErrorMessage];
    
    
    STAssertFalse([value thenStatementConditionMet], @"");
    STAssertEqualObjects(value.thenConditionNotMetMessage, aConditionNotMetErrorMessage, @"");
}


@end
