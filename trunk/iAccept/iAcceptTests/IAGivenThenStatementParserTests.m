//
//  Created by Pascal Roy on 12-01-24.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAGivenThenStatementParserTests.h"
#import "IAGivenThenStatementParser.h"
#import "IAParsedStatement.h"

@implementation IAGivenThenStatementParserTests

-(void) testInit {
    NSString* textToParse = @"sample screen";
    
    
    IAGivenThenStatementParser* parser = [[IAGivenThenStatementParser alloc] initWithText : textToParse];
    
    
    STAssertEqualObjects(parser.textToParse, textToParse, @""); 
    [parser release];
}


-(void) testDescription {
    NSString* textToParse = @"sample screen";
    IAGivenThenStatementParser* parser = [[IAGivenThenStatementParser alloc] initWithText : textToParse];
    
    
    STAssertEqualObjects(parser.description, @"IAGivenThenStatementParser[textToParse=sample screen]", @"");
    [parser release];
}

-(void) testParse_prefixedFixtureClassNameIfPresent {
    NSString* textToParse = @"sample screen";
    IAGivenThenStatementParser* parser = [[IAGivenThenStatementParser alloc] initWithText : textToParse];
    
    
    IAParsedStatement* parsedStatement = [parser parse];
    
    
    STAssertEqualObjects(parsedStatement.fixtureClassName, @"SampleScreenFixture", @"");
    STAssertEqualObjects(parsedStatement.fixtureParsedText, @"sample screen", @"");
    STAssertEqualObjects(parsedStatement.fixtureSourceText, @"sample screen", @"");
    STAssertEquals(parser.fixtureParsedTextStartWordIndex, (NSInteger)0, @"");
    STAssertEquals(parser.fixtureSourceTextStartWordIndex, (NSInteger)0, @"");
    STAssertEquals(parser.fixtureSourceTextEndWordIndex, (NSInteger)1, @"");
    [parser release];
}

-(void) testParse_prefixedFixtureClassName_TheTokenRemoved {
    NSString* textToParse = @"the sample screen";
    IAGivenThenStatementParser* parser = [[IAGivenThenStatementParser alloc] initWithText : textToParse];
    
    
    IAParsedStatement* parsedStatement = [parser parse];
    
    
    STAssertEqualObjects(parsedStatement.fixtureClassName, @"SampleScreenFixture", @"");
    STAssertEqualObjects(parsedStatement.fixtureParsedText, @"sample screen", @"");
    STAssertEqualObjects(parsedStatement.fixtureSourceText, @"the sample screen", @"");
    STAssertEquals(parser.fixtureSourceTextStartWordIndex, (NSInteger)0, @"");
    STAssertEquals(parser.fixtureParsedTextStartWordIndex, (NSInteger)1, @"");
    STAssertEquals(parser.fixtureSourceTextEndWordIndex, (NSInteger)2, @"");
    [parser release];
}

-(void) testParse_selectorOnly {
    NSString* textToParse = @"take some action";
    IAGivenThenStatementParser* parser = [[IAGivenThenStatementParser alloc] initWithText : textToParse];
    
    
    IAParsedStatement* parsedStatement = [parser parse];
    
    
    STAssertNil(parsedStatement.fixtureClassName, @"");
    STAssertNil(parsedStatement.fixtureSourceText, @"");
    STAssertNil(parsedStatement.fixtureParsedText, @"");
    STAssertEquals(parser.fixtureSourceTextStartWordIndex, (NSInteger)-1, @"");
    STAssertEquals(parser.fixtureParsedTextStartWordIndex, (NSInteger)-1, @"");
    STAssertEquals(parser.fixtureSourceTextEndWordIndex, (NSInteger)-1, @"");

    STAssertEqualObjects(parsedStatement.selectorName, @"takeSomeAction", @"");
    STAssertEqualObjects(parsedStatement.selectorSourceText, @"take some action", @"");
    STAssertEquals(parser.selectorSourceTextStartWordIndex, (NSInteger)0, @"");
    STAssertEquals(parser.selectorSourceTextEndWordIndex, (NSInteger)2, @"");    
    [parser release];
}

-(void) testParse_fixtureAndSelector {
    NSString* textToParse = @"sample screen page title is hello world";
    IAGivenThenStatementParser* parser = [[IAGivenThenStatementParser alloc] initWithText : textToParse];
    
    
    IAParsedStatement* parsedStatement = [parser parse];

    
    STAssertEqualObjects(parsedStatement.fixtureClassName, @"SampleScreenFixture", @"");
    STAssertEqualObjects(parsedStatement.fixtureParsedText, @"sample screen", @"");
    STAssertEqualObjects(parsedStatement.fixtureSourceText, @"sample screen", @"");
    STAssertEquals(parser.fixtureSourceTextStartWordIndex, (NSInteger)0, @"");
    STAssertEquals(parser.fixtureParsedTextStartWordIndex, (NSInteger)0, @"");
    STAssertEquals(parser.fixtureSourceTextEndWordIndex, (NSInteger)1, @"");
    
    STAssertEqualObjects(parsedStatement.selectorName, @"pageTitleIsHelloWorld", @"");
    STAssertEqualObjects(parsedStatement.selectorSourceText, @"page title is hello world", @"");
    STAssertEquals(parser.selectorSourceTextStartWordIndex, (NSInteger)2, @"");
    STAssertEquals(parser.selectorSourceTextEndWordIndex, (NSInteger)6, @"");    
    [parser release];
}

-(void) testGiventSelectorWithANonCharacterWord_WhenIParse_TheParserDoesNotChokeOnIt {
    NSString* textToParse = @"sample screen page title is hello : world";
    IAGivenThenStatementParser* parser = [[IAGivenThenStatementParser alloc] initWithText : textToParse];
    
    
    IAParsedStatement* parsedStatement = [parser parse];
    
    
    STAssertEqualObjects(parsedStatement.fixtureClassName, @"SampleScreenFixture", @"");
    STAssertEqualObjects(parsedStatement.fixtureParsedText, @"sample screen", @"");
    STAssertEqualObjects(parsedStatement.fixtureSourceText, @"sample screen", @"");
    STAssertEquals(parser.fixtureSourceTextStartWordIndex, (NSInteger)0, @"");
    STAssertEquals(parser.fixtureParsedTextStartWordIndex, (NSInteger)0, @"");
    STAssertEquals(parser.fixtureSourceTextEndWordIndex, (NSInteger)1, @"");
    
    STAssertEqualObjects(parsedStatement.selectorSourceText, @"page title is hello : world", @"");
    STAssertEquals(parser.selectorSourceTextStartWordIndex, (NSInteger)2, @"");
    STAssertEquals(parser.selectorSourceTextEndWordIndex, (NSInteger)7, @"");    
    [parser release];
}

@end
