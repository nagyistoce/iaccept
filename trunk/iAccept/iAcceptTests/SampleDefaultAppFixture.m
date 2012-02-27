//
//  Created by Pascal Roy on 12-01-01.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "SampleDefaultAppFixture.h"
#import "IAThenResult.h"

@implementation SampleDefaultAppFixture

-(void) iStartedTheApplication { 
}

-(void) iDoSomething {
}

-(IAThenResult*) assertSomething {
    return [IAThenResult makeThenStatementConditionMetReturnValue];
}

-(void) someSettingIs : (NSString*) aString {
}

@end
