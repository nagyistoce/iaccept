//
//  Created by Pascal Roy on 12-01-24.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAGivenThenStatementParser.h"

#import "IAWhenStatement.h"
#import "IASelectorTextParser.h"
#import "IAWhenStatementParser.h"
#import "IAFixtureProvider.h"
#import "IAParsedStatement.h"
#import "IAStatementParserUtils.h"

@implementation IAGivenThenStatementParser 

@synthesize fixtureParsedTextStartWordIndex;
@synthesize fixtureSourceTextStartWordIndex;
@synthesize fixtureSourceTextEndWordIndex;
@synthesize selectorSourceTextStartWordIndex;
@synthesize selectorSourceTextEndWordIndex;


-(id) initWithText : (NSString*) aTextToParse {
    self = [super initWithText:aTextToParse];
    if (self) {
        fixtureSourceTextStartWordIndex = -1;
        fixtureParsedTextStartWordIndex = -1;
        fixtureSourceTextEndWordIndex = -1;
        selectorSourceTextStartWordIndex = -1;
        selectorSourceTextEndWordIndex = -1;
    }
    return self;
}

-(void) dealloc {
    [super dealloc];
}

-(BOOL) wordMatchesTokenThe : (NSString*)word {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[Tt][Hh][Ee]" options:0 error:NULL];    
    NSTextCheckingResult* result = [regex firstMatchInString:self.textToParse options:0 range:NSMakeRange(0, [self.textToParse length])];
    if (result==nil || result.range.location == NSNotFound) {
        return NO;
    }
    else { 
        return YES;
    }
}

-(NSString*) fixtureNameFromWords : (NSArray*)words wordCount : (int)wordCount {
    if ([words count] < 1) {
        return nil;
    }
    NSString* firstWordInTextToParse = [words objectAtIndex:0];
    NSMutableString* aFixtureName = [[NSMutableString alloc] init];
    
    if ([self wordMatchesTokenThe:firstWordInTextToParse]) {
        if ([words count] < 2) {
            [aFixtureName release];
            return nil;
        }      
        fixtureParsedTextStartWordIndex = 1;
    } 
    else {
        fixtureParsedTextStartWordIndex = 0;
    }
    fixtureSourceTextStartWordIndex = 0;

    
    for (int wordIndex = fixtureParsedTextStartWordIndex; wordIndex < wordCount; wordIndex++) {
        NSString* word = [words objectAtIndex:wordIndex];
        NSString* capitalizedWord = [word capitalizedString];
        [aFixtureName appendString:capitalizedWord];
    }
    
    [aFixtureName appendString:@"Fixture"];
    return [aFixtureName autorelease];
}

-(NSString*) textFromWords : (NSArray*) words startWordIndex : (NSInteger)aStartWordIndex endWordIndex : (NSInteger)anEndWordIndex {
    NSString* text = nil;
    if (aStartWordIndex!=-1 && anEndWordIndex!=-1 && anEndWordIndex > aStartWordIndex) {
        NSMutableString* matchingWordsPattern = [[[NSMutableString alloc] init] autorelease];
        for (NSInteger wordIndex = aStartWordIndex; wordIndex <= anEndWordIndex; wordIndex++) {
            if ([IAStatementParserUtils stringContainsAtLeastOneCharacter : [words objectAtIndex: wordIndex]]) {
                [matchingWordsPattern appendString:@"\\b"];
            }
            [matchingWordsPattern appendString:[words objectAtIndex: wordIndex]];
            if(wordIndex != anEndWordIndex) {
                [matchingWordsPattern appendString:@" *"];       
            }
        }
        
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:matchingWordsPattern options:0 error:NULL];    
        NSTextCheckingResult* result = [regex firstMatchInString:self.textToParse options:0 range: NSMakeRange(0, [self.textToParse length])];
        if (result != nil && result.range.location != NSNotFound) {
            text = [self.textToParse substringWithRange : result.range];
        }        
        
    }
    return text;
}

-(void) parsePrefixedClassNameFixtureIfPresent : (IAParsedStatement*) parsedStatement {
    NSArray *textToParseWords = [self textToParseWords];
    
    for (int fixtureWordIndex = [textToParseWords count]; fixtureWordIndex > 0; fixtureWordIndex--) {
        NSString* aPossibleFixtureClassName = [self fixtureNameFromWords:textToParseWords wordCount:fixtureWordIndex];
        
        IABaseFixture* fixture = [[IAFixtureProvider sharedInstance] getFixtureNamed:aPossibleFixtureClassName];
        if (fixture != nil) { 
            int wordIndexOfLastWord = fixtureWordIndex - 1;
            fixtureSourceTextEndWordIndex = wordIndexOfLastWord;
            parsedStatement.fixtureClassName = aPossibleFixtureClassName;
            parsedStatement.fixtureSourceText = [self textFromWords: textToParseWords startWordIndex:fixtureSourceTextStartWordIndex endWordIndex:fixtureSourceTextEndWordIndex];
            parsedStatement.fixtureParsedText = [self textFromWords: textToParseWords startWordIndex:fixtureParsedTextStartWordIndex endWordIndex:fixtureSourceTextEndWordIndex];
            return;
        } 
        else {
            parsedStatement.fixtureSourceText = nil;
            parsedStatement.fixtureParsedText = nil;
            fixtureSourceTextStartWordIndex = -1;
            fixtureSourceTextEndWordIndex = -1;            
            fixtureParsedTextStartWordIndex = -1;            
        }   
        
    }
}


// NOTE: FROM IAWHENSTATEMENT PARSER
-(NSString*) cleanUpUnwantedStartingTokens : (NSString*) textWithTokensToRemove {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[Tt][Hh][Ee] " options:0 error:NULL];
    return [regex stringByReplacingMatchesInString:textWithTokensToRemove options:0 range:NSMakeRange(0,[textWithTokensToRemove length]) withTemplate:@""]; 
}

-(void) parseSelectorText : (IAParsedStatement*) parsedStatement {
    self.selectorSourceTextStartWordIndex = (fixtureSourceTextEndWordIndex == -1) ? 0 : fixtureSourceTextEndWordIndex + 1;
    self.selectorSourceTextEndWordIndex = [self countTextToParseWords]-1;
    
    NSLog(@"parseSelectorText: selectorSourceTextStartWordIndex =%d, selectorSourceTextEndWordIndex=%d", self.selectorSourceTextStartWordIndex, self.selectorSourceTextEndWordIndex);
    
    parsedStatement.selectorSourceText = [self textFromWords:[self textToParseWords] startWordIndex:selectorSourceTextStartWordIndex endWordIndex:selectorSourceTextEndWordIndex];
    parsedStatement.selectorParsedText = [[parsedStatement.selectorSourceText copy] autorelease];

    NSLog(@"parseSelectorText: selectorSourceText =%@, selectorParsedText=%@", parsedStatement.selectorSourceText, parsedStatement.selectorParsedText);
    
    IASelectorTextParser* selectorTextParser = [[IASelectorTextParser alloc] initWithTextToParse: parsedStatement.selectorSourceText];
    [selectorTextParser parse];
    parsedStatement.selectorName = selectorTextParser.parsedText;
    [selectorTextParser release];
}


-(IAParsedStatement*) parse {
    IAParsedStatement* parsedStatement = [[[IAParsedStatement alloc] init] autorelease];
    [parsedStatement setTextToParse:self.textToParse];
    
    [self parsePrefixedClassNameFixtureIfPresent : parsedStatement];
    [self parseSelectorText : parsedStatement];
    return parsedStatement;
}

@end
