//
//  Created by Pascal Roy on 12-01-21.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IASelectorMatcherTests.h"
#import "IASelectorMatcher.h"
#import "SampleScreenFixture.h"
#import "IASelector.h"

@implementation IASelectorMatcherTests

-(void) testMatchSelectorWithoutArgument {
    NSString* noArgumentSelectorText = @"I Do Something";
    Class aFixtureClass = [SampleScreenFixture class];
    IASelectorMatcher* matcher = [[IASelectorMatcher alloc] init];
    
    
    IASelector* iaSelector = [matcher match : noArgumentSelectorText onFixtureClass: aFixtureClass];
    
    
    STAssertEqualObjects(NSStringFromSelector(iaSelector.selector), @"iDoSomething", @"");
    STAssertEquals([iaSelector.argumentsAsStrings count], (NSUInteger)0, @"");    
    [matcher release];
}

-(void) testMatchSelectorWithOneArgument {
    NSString* selectorText = @"page title is page1";
    Class aFixtureClass = [SampleScreenFixture class];
    IASelectorMatcher* matcher = [[IASelectorMatcher alloc] init];
    
    
    IASelector* iaSelector = [matcher match : selectorText onFixtureClass: aFixtureClass];
    
    
    STAssertEqualObjects(NSStringFromSelector(iaSelector.selector), @"pageTitleIs:", @"");
    STAssertEquals([iaSelector.argumentsAsStrings count], (NSUInteger)1, @"");
    STAssertEqualObjects([iaSelector.argumentsAsStrings objectAtIndex:0], @"page1", @"");    
    [matcher release];
}

-(void) testMatchSelectorWithOneTwoWordArgument {
    NSString* selectorText = @"page title is Hello World";
    Class aFixtureClass = [SampleScreenFixture class];
    IASelectorMatcher* matcher = [[IASelectorMatcher alloc] init];
    
    
    IASelector* iaSelector = [matcher match : selectorText onFixtureClass: aFixtureClass];
    
    
    STAssertEqualObjects(NSStringFromSelector(iaSelector.selector), @"pageTitleIs:", @"");
    STAssertEquals([iaSelector.argumentsAsStrings count], (NSUInteger)1, @"");
    STAssertEqualObjects([iaSelector.argumentsAsStrings objectAtIndex:0], @"Hello World", @"");    
    [matcher release];
}

-(void) testMatchSelectorWithTwoTwoWordArguments {
    NSString* selectorText = @"I enter text Hello World and touch button enter text";
    Class aFixtureClass = [SampleScreenFixture class];
    IASelectorMatcher* matcher = [[IASelectorMatcher alloc] init];
    
    
    IASelector* iaSelector = [matcher match : selectorText onFixtureClass: aFixtureClass];
    
    
    STAssertEqualObjects(NSStringFromSelector(iaSelector.selector), @"iEnterText:andTouchButton:", @"");
    STAssertEquals([iaSelector.argumentsAsStrings count], (NSUInteger)2, @"");
    STAssertEqualObjects([iaSelector.argumentsAsStrings objectAtIndex:0], @"Hello World", @"");    
    STAssertEqualObjects([iaSelector.argumentsAsStrings objectAtIndex:1], @"enter text", @"");    
    [matcher release];
}




@end
