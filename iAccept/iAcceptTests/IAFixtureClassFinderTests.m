//
//  Created by Pascal Roy on 11-12-23.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//
#import "objc/runtime.h"
#import "IAFixtureClassFinderTests.h"
#import "IAFixtureClassFinder.h"
#import "SampleDefaultAppFixture.h"
#import "SampleScreenFixture.h"

@implementation IAFixtureClassFinderTests


-(BOOL)classArrayContainsFixtureClass : (NSArray*)aClassArray classToFind : (Class) aClassToFind {
    for (Class aClass in aClassArray) {
        if (aClass == aClassToFind) {
            return YES;
        }
    }
    return NO;
}

- (void)testFindTheDefaultAppFixture
{
    Class defaultAppFixtureClass = [IAFixtureClassFinder findTheDefaultAppFixtureClass];
    
    
    STAssertEquals(defaultAppFixtureClass, [SampleDefaultAppFixture class], @"");
}

- (void)testFindFixtures
{
    NSArray* fixtures = [IAFixtureClassFinder findFixtureClasses];
    

    STAssertEquals([fixtures count], (NSUInteger)2, @"");
    STAssertTrue([self classArrayContainsFixtureClass : fixtures classToFind : [SampleScreenFixture class]], @"");
    STAssertTrue([self classArrayContainsFixtureClass : fixtures classToFind : [SampleDefaultAppFixture class]], @"");
}


@end
