//
//  Created by Pascal Roy on 12-01-14.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "IAFixture.h"

@interface IASelectorTests : SenTestCase<IAFixture>

@property (nonatomic) BOOL aTestMethodWithNoArgsWasRun;
@property (nonatomic) BOOL aTestMethodWithOneArgWasRun;
@property (nonatomic) BOOL aTestMethodWithTwoArgsWasRun;
@property (nonatomic, copy) NSString* argOne;
@property (nonatomic, copy) NSString* argTwo;

@end
