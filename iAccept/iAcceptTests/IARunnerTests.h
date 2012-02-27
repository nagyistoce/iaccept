//
//  Created by Pascal Roy on 11-12-12.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "IARunnerObserver.h"

@interface IARunnerTests : SenTestCase<IARunnerObserver> {
@private
    BOOL runnerDone;
}

@end
