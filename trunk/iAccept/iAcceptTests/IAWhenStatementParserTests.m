//
//  Created by Pascal Roy on 12-01-06.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAWhenStatementParserTests.h"
#import "IAWhenStatementParser.h"
#import "SampleScreenFixture.h"
#import "IAParsedStatement.h"

@implementation IAWhenStatementParserTests

-(void) testInit {
    NSString* textToParse = @"Some text to parse";
    
    
    IAWhenStatementParser* parser = [[IAWhenStatementParser alloc] initWithText : textToParse];
    
    
    STAssertEqualObjects(parser.textToParse, textToParse, @"");    
    [parser release];
}

-(void) testParse_SelectorOnly {
    NSString* textToParse = @"i take some action";
    IAWhenStatementParser* parser = [[IAWhenStatementParser alloc] initWithText : textToParse];
    
    
    IAParsedStatement* parsedStatement = [parser parse];
    
    
    STAssertNil(parsedStatement.fixtureClassName, @""); 
    STAssertNil(parsedStatement.fixtureSourceText, @"");
    STAssertEqualObjects(parsedStatement.selectorSourceText, @"i take some action", @"");    
    STAssertEqualObjects(parsedStatement.selectorName, @"iTakeSomeAction", @"");
    [parser release];
}


-(void) testParse_SelectorOnGivenFixture {
    NSString* textToParse = @"i take some action on sample screen";
    IAWhenStatementParser* parser = [[IAWhenStatementParser alloc] initWithText : textToParse];
    
    
    IAParsedStatement* parsedStatement = [parser parse];
    
    
    STAssertEqualObjects(parsedStatement.fixtureSourceText, @"sample screen", @"");
    STAssertEqualObjects(parsedStatement.fixtureParsedText, @"sample screen", @"");
    STAssertEqualObjects(parsedStatement.fixtureClassName, @"SampleScreenFixture", @""); 
    STAssertEqualObjects(parsedStatement.selectorSourceText, @"i take some action", @"");    
    STAssertEqualObjects(parsedStatement.selectorName, @"iTakeSomeAction", @"");
    [parser release];
}

-(void) testParseFixture_RemoveExtraLowercaseTHEToken {
    NSString* textToParse = @"i take some action on the sample screen";
    IAWhenStatementParser* parser = [[IAWhenStatementParser alloc] initWithText : textToParse];
    
    
    IAParsedStatement* parsedStatement = [parser parse];
    
    
    STAssertEqualObjects(parsedStatement.fixtureSourceText, @"the sample screen", @"");
    STAssertEqualObjects(parsedStatement.fixtureParsedText, @"sample screen", @"");
    STAssertEqualObjects(parsedStatement.fixtureClassName, @"SampleScreenFixture", @""); 
    STAssertEqualObjects(parsedStatement.selectorSourceText, @"i take some action", @"");    
    STAssertEqualObjects(parsedStatement.selectorName, @"iTakeSomeAction", @"");

    [parser release];
}

-(void) testParseFixtureRemoveExtraLowercaseTHEToken {
    NSString* textToParse = @"i take some action on THE sample screen";
    IAWhenStatementParser* parser = [[IAWhenStatementParser alloc] initWithText : textToParse];
    
    
    IAParsedStatement* parsedStatement = [parser parse];
    
    
    STAssertEqualObjects(parsedStatement.fixtureSourceText, @"THE sample screen", @"");
    STAssertEqualObjects(parsedStatement.fixtureParsedText, @"sample screen", @"");
    STAssertEqualObjects(parsedStatement.fixtureClassName, @"SampleScreenFixture", @""); 
    STAssertEqualObjects(parsedStatement.selectorSourceText, @"i take some action", @"");    
    STAssertEqualObjects(parsedStatement.selectorName, @"iTakeSomeAction", @"");
    [parser release];
}

-(void) testParseSelector_RemoveExtraTokenIfAtTheStartOfTheSelector {
    NSString* textToParse = @"the customer requests cash";
    IAWhenStatementParser* parser = [[IAWhenStatementParser alloc] initWithText : textToParse];
    
    
    IAParsedStatement* parsedStatement = [parser parse];
    
    STAssertEqualObjects(parsedStatement.selectorSourceText, @"the customer requests cash", @"");    
    STAssertEqualObjects(parsedStatement.selectorParsedText, @"customer requests cash", @"");    
    STAssertEqualObjects(parsedStatement.selectorName, @"customerRequestsCash", @"");

    [parser release];
}

-(void) testParseSelector_DoesNotRemoveExtraTokenIfNotAtTheStartOfTheStatement {
    NSString* textToParse = @"i push the next button";
    IAWhenStatementParser* parser = [[IAWhenStatementParser alloc] initWithText : textToParse];
    
    
    IAParsedStatement* parsedStatement = [parser parse];
    
    
    STAssertEqualObjects(parsedStatement.selectorName, @"iPushTheNextButton", @"");
    [parser release];
}

@end
