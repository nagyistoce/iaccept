//
//  Created by Pascal Roy on 11-12-23.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IABaseFixture;

@interface IAFixtureProvider : NSObject

@property (nonatomic, retain) IABaseFixture* defaultAppFixture;
@property (nonatomic, retain) NSMutableArray* fixtures;

+(IAFixtureProvider*) sharedInstance;
+(void) reset;

-(int) countFixtures;

-(IABaseFixture*) getDefaultAppFixture;
-(IABaseFixture*) getFixtureNamed : (NSString*)aFixtureClassName;
@end
