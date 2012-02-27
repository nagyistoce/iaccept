//
//  Created by Pascal Roy on 11-12-14.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import "IADefaultRunnerExitHandler.h"
#import "IARunner.h"
#import "IAException.h"

@implementation IADefaultRunnerExitHandler

-(void) runnerDone : (IARunner*) aRunner {
        exit(0);
}

@end
