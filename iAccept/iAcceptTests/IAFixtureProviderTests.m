//
//  Created by Pascal Roy on 11-12-23.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import "IAFixtureProviderTests.h"
#import "IAFixtureProvider.h"
#import "IAFixtureClassFinder.h"

@implementation IAFixtureProviderTests

-(void) tearDown {
    [IAFixtureProvider reset];
}

-(void) testSharedInstance {
    IAFixtureProvider* fixtureProvider1 = [IAFixtureProvider sharedInstance];
    IAFixtureProvider* fixtureProvider2 = [IAFixtureProvider sharedInstance];

    
    STAssertTrue(fixtureProvider2 == fixtureProvider1, @"");
}

-(void) testSharedInstance_availableFixturesAreLoadedWhenFirstInitialized {
    IAFixtureProvider* fixtureProvider = [IAFixtureProvider sharedInstance];
    

    STAssertEquals([fixtureProvider countFixtures], 2, @"");
    STAssertNotNil([fixtureProvider getFixtureNamed : @"SampleScreenFixture"], @"");
    STAssertNotNil([fixtureProvider getFixtureNamed : @"SampleDefaultAppFixture"], @"");
}

@end
