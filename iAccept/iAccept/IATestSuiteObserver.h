//
//  Created by Pascal Roy on 11-12-11.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol IATestSuite;

@protocol IATestSuiteObserver <NSObject>

-(void) testSuiteDone : (id<IATestSuite>) aTestSuite;

@end
