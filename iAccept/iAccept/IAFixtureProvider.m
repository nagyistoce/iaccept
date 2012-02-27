//
//  Created by Pascal Roy on 11-12-23.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import "IAFixtureProvider.h"
#import "IAFixtureClassFinder.h"
#import "IABaseFixture.h"

static IAFixtureProvider* fixtureProvider;

@implementation IAFixtureProvider

@synthesize defaultAppFixture;
@synthesize fixtures;

-(id) init {
    self = [super init];
    if (self) {
        fixtures = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) dealloc {
    [fixtures release];
    [defaultAppFixture release];
    [super dealloc];
}

+(void) reset {
    if (fixtureProvider != nil) {
        [fixtureProvider release];
    }
    fixtureProvider = nil;
}

-(void) loadDefaultAppFixture {
    Class defaultAppFixtureClass = [IAFixtureClassFinder findTheDefaultAppFixtureClass];
    IABaseFixture* theDefaultAppFixture = [[defaultAppFixtureClass alloc] init];
    self.defaultAppFixture = theDefaultAppFixture;
    [theDefaultAppFixture release];
}


-(void) loadFixtures {
    NSArray* fixtureClasses = [IAFixtureClassFinder findFixtureClasses];
    
    for (Class fixtureClass in fixtureClasses) {
        IABaseFixture* fixture = [[fixtureClass alloc] init];
        [fixtures addObject:fixture];
        [fixture release];
    }
}


+(IAFixtureProvider*) sharedInstance {
    if (fixtureProvider == nil) {
        fixtureProvider = [[IAFixtureProvider alloc] init];
        [fixtureProvider loadFixtures];
        [fixtureProvider loadDefaultAppFixture];
    }
    return fixtureProvider;
}

-(int) countFixtures {
    return [fixtures count];
}

-(IABaseFixture*) getDefaultAppFixture {
    return defaultAppFixture;
}


-(IABaseFixture*) getFixtureNamed : (NSString*)aFixtureClassName {
    for (int fixtureIndex = 0; fixtureIndex < [fixtures count]; fixtureIndex++) {
        IABaseFixture* fixture = [fixtures objectAtIndex:fixtureIndex];
        NSString *className = NSStringFromClass([fixture class]); 
        if ([className isEqualToString:aFixtureClassName]) {
            return fixture;
        }        
    }
    return nil;

}


@end
