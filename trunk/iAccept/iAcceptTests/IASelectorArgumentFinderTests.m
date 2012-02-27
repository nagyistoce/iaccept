//
//  Created by Pascal Roy on 12-02-03.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IASelectorArgumentFinderTests.h"
#import "IASelectorArgumentFinder.h"

@implementation IASelectorArgumentFinderTests

- (void)testInit
{
    IASelectorArgumentFinder* finder = [[IASelectorArgumentFinder alloc] init];
        

    [finder release];
}

-(void)test_GivenAStatementWithTheMethodTokenTextAtTheStart_WhenIFindEndingCharIndexOfToken_ThenIFindTheEndingCharIndexOfTheLastWordOfTheToken {
    NSString* text = @"page title is page1";
    IASelectorArgumentFinder* finder = [[IASelectorArgumentFinder alloc] init];
    

    NSUInteger endingCharIndex = [finder findEndingCharIndexOfToken: @"pageTitleIs" inString: text];
    
    
    STAssertEquals(endingCharIndex, (NSUInteger)12, @"");
    [finder release];
}

-(void)test_GivenAStatementWithTwoArguments_WhenIFindEndingCharIndexOfTheSecondArgumentToken_ThenIFindTheEndingCharIndexOfTheLastWordOfTheToken {
    NSString* text = @"i enter text text1 and touch button button1";
    IASelectorArgumentFinder* finder = [[IASelectorArgumentFinder alloc] init];
    
    
    NSUInteger endingCharIndex = [finder findEndingCharIndexOfToken: @"andTouchButton" inString: text];
    
    
    STAssertEquals(endingCharIndex, (NSUInteger)34, @"");
    [finder release];
}

- (void)test_GivenAStatementWithLastWordOfTextThatHasAPartialMatchInTheText_WhenIFindTheEndCharIndex_ItDoesNotMatchThePartialWordInCredit
{
    NSString* text = @"the credit card number text field background red";
    IASelectorArgumentFinder* finder = [[IASelectorArgumentFinder alloc] init];
    
    
    NSUInteger endingCharIndex =  [finder findEndingCharIndexOfToken: @"theCreditCardNumberTextFieldBackgroundRed" inString: text];
    
    
    STAssertEquals(endingCharIndex, (NSUInteger)47, @"");
    [finder release];
}

-(void)test_GivenAStatementWithTheMethodTokenTextAtTheStartt_WhenIFindStartingCharIndexOfToken_ThenIFindTheEndingCharIndexOfTheFirstWordOfTheToken {
    NSString* text = @"page title is page1";
    IASelectorArgumentFinder* finder = [[IASelectorArgumentFinder alloc] init];
    
 
    NSUInteger  startingCharIndex = [finder findStartingCharIndexOfToken : @"pageTitleIs" inString: text];
    

    STAssertEquals(startingCharIndex, (NSUInteger)0, @"");
    [finder release];
}

-(void)test_GivenStatementWhereTheFirstWordOfTheTokenAppearsTwice_WhenIFindStartingCharIndexOfToken_ThenIFindTheOneThatIsPartOfTheToken {
    NSString* text = @"page page title is page1";
    IASelectorArgumentFinder* finder = [[IASelectorArgumentFinder alloc] init];
    
    
    NSUInteger  startingCharIndex = [finder findStartingCharIndexOfToken : @"pageTitleIs" inString: text];
    
    
    STAssertEquals(startingCharIndex, (NSUInteger)5, @"");
    [finder release];
}

-(void)test_GivenAStatementWithTwoArguments_WhenIFindStartingCharIndexOfTokenOfTheSecondMethodToken_ThenIFindTheStartingCharIndexOfThatSpecificToken {
    NSString* text = @"i enter text text1 and touch button button1";
    IASelectorArgumentFinder* finder = [[IASelectorArgumentFinder alloc] init];
    
    
    NSUInteger  startingCharIndex = [finder findStartingCharIndexOfToken : @"andTouchButton" inString: text];
    
    
    STAssertEquals(startingCharIndex, (NSUInteger)19, @"");
    [finder release];
}

- (void)test_GivenAStatementWithOneOneWordArgument_WhenIFindArguments_ThenItFindsTheRightOne
{
    NSString* text = @"page title is page1";
    IASelectorArgumentFinder* finder = [[IASelectorArgumentFinder alloc] init];

    
    NSArray* arguments = [finder findArgumentsForSelector : @"pageTitleIs:" inText: text];


    STAssertEquals([arguments count], (NSUInteger)1, @"");
    STAssertEqualObjects([arguments objectAtIndex:0], @"page1", @"");    
    [finder release];
}


- (void)test_GivenAStatementWithOneTwoWordArgument_WhenIFindArguments_ThenItFindsItAsOneArgument
{
    NSString* text = @"page title is Hello world";
    IASelectorArgumentFinder* finder = [[IASelectorArgumentFinder alloc] init];
    
    
    NSArray* arguments = [finder findArgumentsForSelector : @"pageTitleIs:" inText: text];
    
    
    STAssertEquals([arguments count], (NSUInteger)1, @"");
    STAssertEqualObjects([arguments objectAtIndex:0], @"Hello world", @"");    
    [finder release];
}

- (void)test_GivenAStatementWithAnArgumentWithAColor_WhenIFindArguments_ThenTheColorIsNotInterpreted
{
    NSString* text = @"page title is Hello : world";
    IASelectorArgumentFinder* finder = [[IASelectorArgumentFinder alloc] init];
    
    
    NSArray* arguments = [finder findArgumentsForSelector : @"pageTitleIs:" inText: text];
    
    
    STAssertEquals([arguments count], (NSUInteger)1, @"");
    STAssertEqualObjects([arguments objectAtIndex:0], @"Hello : world", @"");    
    [finder release];
}

- (void)test_GivenAStatementWithMultipleTwoWordArguments_WhenIFindArguments_ThenItFindsThemAll
{
    NSString* text = @"i enter text Some text and touch button Some button";
    IASelectorArgumentFinder* finder = [[IASelectorArgumentFinder alloc] init];
    
    
    NSArray* arguments = [finder findArgumentsForSelector : @"iEnterText:andTouchButton:" inText: text];
    
    
    STAssertEquals([arguments count], (NSUInteger)2, @"");
    STAssertEqualObjects([arguments objectAtIndex:0], @"Some text", @"");    
    STAssertEqualObjects([arguments objectAtIndex:1], @"Some button", @"");    
    [finder release];
}

- (void)test_GivenAStatementWithExtraSpaces_WhenIFindArguments_ThenItIsNotAffectedByThem
{
    NSString* text = @"i  enter  text  Some text  and  touch  button  Some button";
    IASelectorArgumentFinder* finder = [[IASelectorArgumentFinder alloc] init];
    
    
    NSArray* arguments = [finder findArgumentsForSelector : @"iEnterText:andTouchButton:" inText: text];
    
    
    STAssertEquals([arguments count], (NSUInteger)2, @"");
    STAssertEqualObjects([arguments objectAtIndex:0], @"Some text", @"");    
    STAssertEqualObjects([arguments objectAtIndex:1], @"Some button", @"");    
    [finder release];
}

- (void)test_GivenAStatementWithANumberIntoTheSentence
{
    NSString* text = @"the main view displays page 2 of disclaimer";
    IASelectorArgumentFinder* finder = [[IASelectorArgumentFinder alloc] init];
    
    
    NSUInteger endingCharIndex =  [finder findEndingCharIndexOfToken: @"displaysPage2OfDisclaimer" inString: text];
    
    
    STAssertEquals(endingCharIndex, (NSUInteger)42, @"");
    [finder release];
}

- (void)test_GivenAStatementWithANumberAtTheEndTheSentence
{
    NSString* text = @"the card number text field contains 4";
    IASelectorArgumentFinder* finder = [[IASelectorArgumentFinder alloc] init];
    
    
    NSUInteger endingCharIndex =  [finder findEndingCharIndexOfToken: @"theCardNumberTextFieldContains4" inString: text];
    
    
    STAssertEquals(endingCharIndex, (NSUInteger)36, @"");
    [finder release];
}


@end
