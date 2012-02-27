//
//  Created by Pascal Roy on 12-01-14.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IASelectorTests.h"
#import "IASelector.h"
#import "IASelectorReturnValue.h"
#import "IASelectorVoidReturnValue.h"
#import "IASelectorObjectReturnValue.h"
#import "IASelectorDataTypeReturnValue.h"

@implementation IASelectorTests

@synthesize aTestMethodWithNoArgsWasRun;
@synthesize aTestMethodWithOneArgWasRun;
@synthesize aTestMethodWithTwoArgsWasRun;
@synthesize argOne;
@synthesize argTwo;

-(void) dealloc {
    [argOne release];
    [argTwo release];
    [super dealloc];
}

-(void) aTestMethodWithNoArgs {
    aTestMethodWithNoArgsWasRun = YES;
}

-(void) aTestMethodWithOneArg : (NSString*) theArgOne {
    aTestMethodWithOneArgWasRun = YES;
    self.argOne = theArgOne;
}

-(void) aTestMethodWithTwoArgs : (NSString*) theArgOne andSecondArg : (NSString*) theArgTwo {
    aTestMethodWithTwoArgsWasRun = YES;
    self.argOne = theArgOne;
    self.argTwo = theArgTwo;
}

-(void) aTestMethodReturningVoid {
}

-(BOOL) aTestMethodReturningABoolDataType {
    return YES;
}

-(NSUInteger) aTestMethodReturningAnIntegerDataType {
    return (NSUInteger)12;
}

-(NSObject*) aTestMethodReturningAnNSObject {
    return @"Hi";
}


-(void) testInit {    
    SEL selector = @selector(aTestMethodWithNoArgs);
    NSArray* argumentsAsStrings = [NSArray arrayWithObjects:nil];
    
    
    IASelector* iaSelector = [[IASelector alloc] initWithSelector:selector argumentsAsStrings: argumentsAsStrings];
    

    STAssertEquals(iaSelector.selector, selector, @"");
    STAssertEquals(iaSelector.argumentsAsStrings, argumentsAsStrings, @"");
    [argumentsAsStrings release];
    [iaSelector release];
}

-(void) testPerformMethodWithNoArgs {
    SEL selector = @selector(aTestMethodWithNoArgs);
    NSArray* argumentsAsStrings = [NSArray arrayWithObjects:nil];
    IASelector* iaSelector = [[IASelector alloc] initWithSelector:selector argumentsAsStrings: argumentsAsStrings];
    STAssertFalse(aTestMethodWithNoArgsWasRun, @"");

    
    [iaSelector performOnFixture:self];
    
    
    STAssertTrue(aTestMethodWithNoArgsWasRun, @"");
    [argumentsAsStrings release];
    [iaSelector release];
}

-(void) testPerformMethodWithOneArg {
    SEL selector = @selector(aTestMethodWithOneArg:);
    NSString* arg1 = @"Arg1";
    NSArray* argumentsAsStrings = [NSArray arrayWithObjects:arg1, nil];
    IASelector* iaSelector = [[IASelector alloc] initWithSelector:selector argumentsAsStrings: argumentsAsStrings];
    STAssertFalse(aTestMethodWithOneArgWasRun, @"");
    
    
    [iaSelector performOnFixture:self];
    
    
    STAssertTrue(aTestMethodWithOneArgWasRun, @"");
    STAssertEqualObjects(argOne, arg1, @""); 
    [argumentsAsStrings release];
    [iaSelector release];
}

-(void) testPerformMethodWithTwoArgs {
    SEL selector = @selector(aTestMethodWithTwoArgs:andSecondArg:);
    NSString* arg1 = @"Arg1";
    NSString* arg2 = @"Arg2";
    NSArray* argumentsAsStrings = [NSArray arrayWithObjects:arg1, arg2, nil];
    IASelector* iaSelector = [[IASelector alloc] initWithSelector:selector argumentsAsStrings: argumentsAsStrings];
    STAssertFalse(aTestMethodWithTwoArgsWasRun, @"");
    
    
    [iaSelector performOnFixture:self];
    
    
    STAssertTrue(aTestMethodWithTwoArgsWasRun, @"");
    STAssertEqualObjects(argOne, arg1, @""); 
    STAssertEqualObjects(argTwo, arg2, @""); 
    [argumentsAsStrings release];
    [iaSelector release];
}

-(void) testPerformReturnsVoid {
    SEL selector = @selector(aTestMethodReturningVoid);
    NSArray* argumentsAsStrings = [NSArray arrayWithObjects:nil];
    IASelector* iaSelector = [[IASelector alloc] initWithSelector:selector argumentsAsStrings: argumentsAsStrings];

    
    id<IASelectorReturnValue> returnValue = [iaSelector performOnFixture:self];
    
    
    STAssertTrue([returnValue isKindOfClass: [IASelectorVoidReturnValue class]], @"");
    [argumentsAsStrings release];
    [iaSelector release];
}

-(void) testPerformReturnsAnNSObject {
    SEL selector = @selector(aTestMethodReturningAnNSObject);
    NSArray* argumentsAsStrings = [NSArray arrayWithObjects:nil];
    IASelector* iaSelector = [[IASelector alloc] initWithSelector:selector argumentsAsStrings: argumentsAsStrings];
    
    
    id<IASelectorReturnValue> returnValue = [iaSelector performOnFixture:self];
    
    
    STAssertTrue([returnValue isKindOfClass: [IASelectorObjectReturnValue class]], @"");
    STAssertEqualObjects(((IASelectorObjectReturnValue*)returnValue).value, @"Hi", @"");
    [argumentsAsStrings release];
    [iaSelector release];
}

-(void) testMethodReturningABoolDataType {
    SEL selector = @selector(aTestMethodReturningABoolDataType);
    NSArray* argumentsAsStrings = [NSArray arrayWithObjects:nil];
    IASelector* iaSelector = [[IASelector alloc] initWithSelector:selector argumentsAsStrings: argumentsAsStrings];
    
    
    id<IASelectorReturnValue> returnValue = [iaSelector performOnFixture:self];
    
    
    STAssertTrue([returnValue isKindOfClass: [IASelectorDataTypeReturnValue class]], @"");
    IASelectorObjectReturnValue* selectorReturnValue = (IASelectorObjectReturnValue*)returnValue;
    BOOL* dataTypeReturnValue = (BOOL*)selectorReturnValue.value;
    BOOL boolReturnValue = *dataTypeReturnValue;
    STAssertTrue(boolReturnValue, @"");
    [argumentsAsStrings release];
    [iaSelector release];
}

-(void) testMethodReturningAnIntegerDataType {
    SEL selector = @selector(aTestMethodReturningAnIntegerDataType);
    NSArray* argumentsAsStrings = [NSArray arrayWithObjects:nil];
    IASelector* iaSelector = [[IASelector alloc] initWithSelector:selector argumentsAsStrings: argumentsAsStrings];
    
    
    id<IASelectorReturnValue> returnValue = [iaSelector performOnFixture:self];
    
    
    STAssertTrue([returnValue isKindOfClass: [IASelectorDataTypeReturnValue class]], @"");
    IASelectorObjectReturnValue* selectorReturnValue = (IASelectorObjectReturnValue*)returnValue;
    NSUInteger* dataTypeReturnValue = (NSUInteger*)selectorReturnValue.value;
    NSUInteger intReturnValue = *dataTypeReturnValue;
    STAssertEquals(intReturnValue, (NSUInteger)12, @"");
    [argumentsAsStrings release];
    [iaSelector release];
}

@end
