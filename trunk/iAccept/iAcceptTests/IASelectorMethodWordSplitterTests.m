//
//  Created by Pascal Roy on 12-02-03.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IASelectorMethodWordSplitterTests.h"
#import "IASelectorMethodWordSplitter.h"

@implementation IASelectorMethodWordSplitterTests

- (void)testInit
{
    IASelectorMethodWordSplitter* splitter = [[IASelectorMethodWordSplitter alloc] init];
    
    
    [splitter release];
}

-(void)test_GivenPreviousCharacterIsALowerCasedCharacterAndTheCurrentCharacterIsAnUpperCase_ThenWeAreOnAWordBoundary {
    IASelectorMethodWordSplitter* splitter = [[IASelectorMethodWordSplitter alloc] init];

    
    STAssertTrue([splitter isEndOfWordCharacter:'C' previousCharacter:'a'], @"");
    [splitter release];
}

-(void)test_GivenPreviousCharacterIsAnUpperCasedCharacterAndTheCurrentCharacterIsAnUpperCase_ThenWeAreOnAWordBoundary {
    IASelectorMethodWordSplitter* splitter = [[IASelectorMethodWordSplitter alloc] init];
    
    
    STAssertTrue([splitter isEndOfWordCharacter:'A' previousCharacter:'C'], @"");
}

-(void)test_GivenPreviousCharacterIsALowerCasedCharacterAndTheCurrentCharacterIsANumber_ThenWeAreOnAWordBoundary {
    IASelectorMethodWordSplitter* splitter = [[IASelectorMethodWordSplitter alloc] init];
    
    STAssertTrue([splitter isEndOfWordCharacter:'2' previousCharacter:'a'], @"");
    [splitter release];
}

-(void)test_GivenPreviousCharacterIsANumberAndTheCurrentCharacterIsANumber_ThenWeAreNotOnAWordBoundary {
    IASelectorMethodWordSplitter* splitter = [[IASelectorMethodWordSplitter alloc] init];
    
    STAssertFalse([splitter isEndOfWordCharacter:'3' previousCharacter:'2'], @"");
    [splitter release];
}

-(void)test_GivenPreviousCharacterIsANumberAndTheCurrentCharacterIsAnUpperCaseCharacter_ThenWeAreOnAWordBoundary {
    IASelectorMethodWordSplitter* splitter = [[IASelectorMethodWordSplitter alloc] init];
    
    STAssertTrue([splitter isEndOfWordCharacter:'A' previousCharacter:'2'], @"");
    [splitter release];
}


- (void)testSplitIntoWords
{
    NSString* methodName = @"pageTitleIs";
    IASelectorMethodWordSplitter* splitter = [[IASelectorMethodWordSplitter alloc] init];
    
    
    NSArray* words = [splitter splitMethodNameIntoWords : methodName]; 
    STAssertEqualObjects([words objectAtIndex:0], @"page", @"");
    STAssertEqualObjects([words objectAtIndex:1], @"Title", @"");
    STAssertEqualObjects([words objectAtIndex:2], @"Is", @"");
    
    [splitter release];
}

- (void)testSplitIntoWordsWithSingleDigitNumber
{
    NSString* methodName = @"aTableWith4Values";
    IASelectorMethodWordSplitter* splitter = [[IASelectorMethodWordSplitter alloc] init];
    
    
    NSArray* words = [splitter splitMethodNameIntoWords : methodName];
    
    STAssertEqualObjects([words objectAtIndex:0], @"a", @"");
    STAssertEqualObjects([words objectAtIndex:1], @"Table", @"");
    STAssertEqualObjects([words objectAtIndex:2], @"With", @"");
    STAssertEqualObjects([words objectAtIndex:3], @"4", @"");
    STAssertEqualObjects([words objectAtIndex:4], @"Values", @"");
    
    [splitter release];
}


- (void)testSplitIntoWordsWithMultipleDigitNumbers
{
    NSString* methodName = @"aTableWith40Values";
    IASelectorMethodWordSplitter* splitter = [[IASelectorMethodWordSplitter alloc] init];
    
    
    NSArray* words = [splitter splitMethodNameIntoWords : methodName];
    
    STAssertEqualObjects([words objectAtIndex:0], @"a", @"");
    STAssertEqualObjects([words objectAtIndex:1], @"Table", @"");
    STAssertEqualObjects([words objectAtIndex:2], @"With", @"");
    STAssertEqualObjects([words objectAtIndex:3], @"40", @"");
    STAssertEqualObjects([words objectAtIndex:4], @"Values", @"");
    
    [splitter release];
}

- (void)testSplitIntoWordsWithADigitAtTheEnd
{
    NSString* methodName = @"aNumberWithAValueOf4";
    IASelectorMethodWordSplitter* splitter = [[IASelectorMethodWordSplitter alloc] init];
    
    
    NSArray* words = [splitter splitMethodNameIntoWords : methodName];
    
    STAssertEqualObjects([words objectAtIndex:0], @"a", @"");
    STAssertEqualObjects([words objectAtIndex:1], @"Number", @"");
    STAssertEqualObjects([words objectAtIndex:2], @"With", @"");
    STAssertEqualObjects([words objectAtIndex:3], @"A", @"");
    STAssertEqualObjects([words objectAtIndex:4], @"Value", @"");
    STAssertEqualObjects([words objectAtIndex:5], @"Of", @"");
    STAssertEqualObjects([words objectAtIndex:6], @"4", @"");
    
    [splitter release];
}

- (void)testSplitIntoWordsWithAMultiDigitNumberAtTheEnd
{
    NSString* methodName = @"aNumberWithAValueOf405";
    IASelectorMethodWordSplitter* splitter = [[IASelectorMethodWordSplitter alloc] init];
    
    
    NSArray* words = [splitter splitMethodNameIntoWords : methodName];
    
    STAssertEqualObjects([words objectAtIndex:0], @"a", @"");
    STAssertEqualObjects([words objectAtIndex:1], @"Number", @"");
    STAssertEqualObjects([words objectAtIndex:2], @"With", @"");
    STAssertEqualObjects([words objectAtIndex:3], @"A", @"");
    STAssertEqualObjects([words objectAtIndex:4], @"Value", @"");
    STAssertEqualObjects([words objectAtIndex:5], @"Of", @"");
    STAssertEqualObjects([words objectAtIndex:6], @"405", @"");
    
    [splitter release];
}




@end
