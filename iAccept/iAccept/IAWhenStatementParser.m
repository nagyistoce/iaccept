//
//  Created by Pascal Roy on 12-01-06.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAWhenStatementParser.h"
#import "IASelectorTextParser.h"
#import "IAParsedStatement.h"

NSString* const WHEN_FIXTURE_SEPARATOR_TOKEN_REGEX_MATCH = @" [oO][nN] ";
NSString* const WHEN_FIXTURE_POSTFIX = @"Fixture";

@implementation IAWhenStatementParser

@dynamic textToParse;

-(id) initWithText : (NSString*) aTextToParse {
    self = [super initWithText:aTextToParse];
    if (self) {
    }
    return self;
}

-(void) dealloc {
    [super dealloc];
}

-(NSString*) cleanUpUnwantedStartingTokens : (NSString*) textWithTokensToRemove {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[Tt][Hh][Ee] " options:0 error:NULL];
    return [regex stringByReplacingMatchesInString:textWithTokensToRemove options:0 range:NSMakeRange(0,[textWithTokensToRemove length]) withTemplate:@""]; 
}

-(NSString*) convertFixtureTextToFixtureClassName : (NSString*) fixtureText {
    if (fixtureText == nil) {
        return nil;
    }
    NSString* capitalizedText = [fixtureText capitalizedString];
    
    NSMutableCharacterSet *separators = [NSMutableCharacterSet whitespaceCharacterSet];
    NSArray *capitalizedWords = [capitalizedText componentsSeparatedByCharactersInSet:separators];
    
    NSMutableString* aFixtureClassName = [[NSMutableString alloc] init];
    
    for (int wordIndex = 0; wordIndex < [capitalizedWords count]; wordIndex++) {
        [aFixtureClassName appendString:[capitalizedWords objectAtIndex : wordIndex]];
    }
    
    [aFixtureClassName appendString:WHEN_FIXTURE_POSTFIX];
    return [aFixtureClassName autorelease];
}

-(void) parseFixtureText : (IAParsedStatement*) parsedStatement {
    NSError *error;
    NSRegularExpression* fixtureSeparatorPattern = [[NSRegularExpression alloc] initWithPattern:WHEN_FIXTURE_SEPARATOR_TOKEN_REGEX_MATCH options:0 error:&error];
    NSTextCheckingResult* result = [fixtureSeparatorPattern firstMatchInString:self.textToParse options:0 range:NSMakeRange(0, [self.textToParse length])];
    [fixtureSeparatorPattern release];
    if (result == nil) {
        return;
    }
    
    NSUInteger characterIndexOfFixtureSeparatorToken = result.range.location;
    NSUInteger characterIndexOfFixtureText = characterIndexOfFixtureSeparatorToken + result.range.length;
    
    parsedStatement.fixtureSourceText = [self.textToParse substringFromIndex : characterIndexOfFixtureText];
    parsedStatement.fixtureParsedText = [self cleanUpUnwantedStartingTokens : parsedStatement.fixtureSourceText];
    parsedStatement.fixtureClassName = [self convertFixtureTextToFixtureClassName:parsedStatement.fixtureParsedText];
}

-(void) parseSelectorText : (IAParsedStatement*) parsedStatement {
    NSError *error;
    NSRegularExpression* fixtureSeparatorPattern = [[NSRegularExpression alloc] initWithPattern:WHEN_FIXTURE_SEPARATOR_TOKEN_REGEX_MATCH options:0 error:&error];
    NSTextCheckingResult* result = [fixtureSeparatorPattern firstMatchInString:self.textToParse options:0 range:NSMakeRange(0, [self.textToParse length])];
    [fixtureSeparatorPattern release];
    if (result == nil) {
        parsedStatement.selectorSourceText = parsedStatement.textToParse;
    }
    else {
        NSUInteger characterIndexOfFixtureSeparatorToken = result.range.location;
        parsedStatement.selectorSourceText = [self.textToParse substringToIndex : characterIndexOfFixtureSeparatorToken];    
    }    
    parsedStatement.selectorParsedText = [self cleanUpUnwantedStartingTokens:parsedStatement.selectorSourceText];
    
    IASelectorTextParser* selectorTextParser = [[IASelectorTextParser alloc] initWithTextToParse:parsedStatement.selectorParsedText];
    [selectorTextParser parse];
    parsedStatement.selectorName = [selectorTextParser parsedText];
    [selectorTextParser release];
}


-(NSString*) convertSelectorTextToSelectorName : (NSString*) selectorText {
    NSString* capitalizedText = [selectorText capitalizedString];
    NSString* lowerCasedText = [selectorText lowercaseString];
    
    NSMutableCharacterSet *separators = [NSMutableCharacterSet whitespaceCharacterSet];
    NSArray *lowerCasedWords = [lowerCasedText componentsSeparatedByCharactersInSet:separators];
    NSArray *capitalizedWords = [capitalizedText componentsSeparatedByCharactersInSet:separators];
    
    NSMutableString* aSelectorName = [[NSMutableString alloc] init];
    [aSelectorName appendString:[lowerCasedWords objectAtIndex : 0]];
    
    for (int wordIndex = 1; wordIndex < [capitalizedWords count]; wordIndex++) {
        [aSelectorName appendString:[capitalizedWords objectAtIndex : wordIndex]];
    }
    return [aSelectorName autorelease];
}

-(IAParsedStatement*) parse {
    IAParsedStatement* parsedStatement = [[[IAParsedStatement alloc] init] autorelease];
    [parsedStatement setTextToParse:self.textToParse];

    [self parseFixtureText : parsedStatement];
    [self parseSelectorText : parsedStatement];
    return parsedStatement;
}


@end
