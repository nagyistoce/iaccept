//
//  Created by Pascal Roy on 11-12-09.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "IATestObserver.h"
@class IATest;

@interface IATestTests : SenTestCase<IATestObserver>

@property (nonatomic, retain) IATest* lastTestRun;

@end
