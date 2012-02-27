//
//  Created by Pascal Roy on 12-01-14.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IASelectorTextParserTests.h"
#import "IASelectorTextParser.h"
#import "IASelector.h"
#import "SampleScreenFixture.h"

@implementation IASelectorTextParserTests

-(void) testInit {
    NSString* textToParse = @"";
    IASelectorTextParser* parser = [[IASelectorTextParser alloc] initWithTextToParse: textToParse];
    
    STAssertEqualObjects(parser.textToParse, textToParse, @"");
    [parser release];
}

-(void) testInit_ParsedTextIsNotSetUntilParseIsCalled {
    NSString* textToParse = @"";
    IASelectorTextParser* parser = [[IASelectorTextParser alloc] initWithTextToParse: textToParse];

    
    STAssertNil(parser.parsedText, @"");
    [parser release];
}

-(void) testCountWords {
    NSString* textToParse = @"i take some action";
    IASelectorTextParser* parser = [[IASelectorTextParser alloc] initWithTextToParse: textToParse];
    
    
    STAssertEquals([parser wordCount], (NSUInteger)4, @"");
    [parser release];
}

-(void) testParse_NilStringReturnsNil {
    IASelectorTextParser* parser = [[IASelectorTextParser alloc] initWithTextToParse: nil];
    
    
    [parser parse];
    

    STAssertNil(parser.parsedText, @"");
    [parser release];
}

-(void) testParse_EmptyStringReturnsEmptyString {
    NSString* textToParse = @"";
    IASelectorTextParser* parser = [[IASelectorTextParser alloc] initWithTextToParse: textToParse];
    
    
    [parser parse];
    
    
    STAssertEqualObjects(parser.parsedText, @"", @"");
    [parser release];
}

-(void) testParse_FirstWordIsSmallCapped {
    NSString* textToParse = @"SOME";
    IASelectorTextParser* parser = [[IASelectorTextParser alloc] initWithTextToParse: textToParse];
    
    
    [parser parse];
    

    STAssertEqualObjects(parser.parsedText, @"some", @"");
    [parser release];
}

-(void) testParse_AllOtherWordsAfterFirstAreCapitalized {
    NSString* textToParse = @"SOME ACTION IS TAKEN";
    IASelectorTextParser* parser = [[IASelectorTextParser alloc] initWithTextToParse: textToParse];
    

    [parser parse];

    
    STAssertEqualObjects(parser.parsedText, @"someActionIsTaken", @"");
    [parser release];
}

-(void) testParse_DontModifyDoubleQuotedText {
    NSString* textToParse = @"I touch button named \"Take card\"";
    IASelectorTextParser* parser = [[IASelectorTextParser alloc] initWithTextToParse: textToParse];
    
    
    [parser parse];
    
    
    STAssertEqualObjects(parser.parsedText, @"iTouchButtonNamed\"Take card\"", @"");
    [parser release];
}


@end
