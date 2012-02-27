//
//  Created by Pascal Roy on 12-01-14.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IASelectorTextParser.h"


@implementation IASelectorTextParser

@synthesize textToParse;
@synthesize parsedText;
@synthesize capitalizedTextToParse;
@synthesize lowerCasedTextToParse;
@synthesize capitalizedWords;
@synthesize lowercasedWords;
@synthesize originalWords;

-(id) initWithTextToParse:(NSString *)aTextToParse {
    self = [super init];
    if (self) {
        self.textToParse = aTextToParse;
        self.parsedText = nil;
        self.lowerCasedTextToParse = [aTextToParse lowercaseString];
        self.capitalizedTextToParse = [lowerCasedTextToParse capitalizedString];
        self.lowerCasedTextToParse = [aTextToParse lowercaseString];
        self.originalWords =  [textToParse componentsSeparatedByCharactersInSet:[NSMutableCharacterSet whitespaceCharacterSet]];
        self.lowercasedWords =  [lowerCasedTextToParse componentsSeparatedByCharactersInSet:[NSMutableCharacterSet whitespaceCharacterSet]];
        self.capitalizedWords =  [capitalizedTextToParse componentsSeparatedByCharactersInSet:[NSMutableCharacterSet whitespaceCharacterSet]];
    }
    return self;
}

-(NSUInteger) findStartingCharIndexOfWordInOrginalString : (NSString*)aWord {
    NSError *error;
    NSRegularExpression* regEx = [[NSRegularExpression alloc] initWithPattern:aWord options:0 error:&error];
    NSTextCheckingResult* result = [regEx firstMatchInString:textToParse options:0 range:NSMakeRange(0, [textToParse length])];
    [regEx release];
    if (result == nil || result.range.location == NSNotFound ) {
        return NSNotFound;
    }
    return result.range.location;    
}

-(NSUInteger) findEndingCharIndexOfWordInOrginalString : (NSString*)aWord {
    NSError *error;
    NSRegularExpression* regEx = [[NSRegularExpression alloc] initWithPattern:aWord options:0 error:&error];
    NSTextCheckingResult* result = [regEx firstMatchInString:textToParse options:0 range:NSMakeRange(0, [textToParse length])];
    [regEx release];
    if (result == nil || result.range.location == NSNotFound ) {
        return NSNotFound;
    }
    return result.range.location + result.range.length;    
}


-(void) dealloc {
    [parsedText release];
    [textToParse release];
    [super dealloc];
}

-(NSUInteger) wordCount {
    return [originalWords count];
}

-(NSString*) lowercaseFirstWord {
    return [lowercasedWords objectAtIndex:0];
}

-(NSString*) capitalizedWord : (NSUInteger)wordIndex {
    return [capitalizedWords objectAtIndex:wordIndex];
}

-(void) parse {
    if (textToParse == nil)
        return;
    if ([textToParse isEqualToString:@""]) {
        self.parsedText = @"";
        return;
    }
    
    NSMutableString* methodName = [[NSMutableString alloc]init];        
    [methodName appendString:[self lowercaseFirstWord]];

    NSUInteger wordCount = [self wordCount];
    if (wordCount > 1) {
//        BOOL parsingADoubleQuotedString = NO;
        NSUInteger doubleQuoteStargingCharIndex = NSNotFound;
        NSUInteger doubleQuoteEndingCharIndex = NSNotFound;
        
        for (NSUInteger wordIndex = 1; wordIndex < wordCount; wordIndex++) {
            NSString* originalWord = [originalWords objectAtIndex:wordIndex];
            unichar firstCharInWord = [originalWord characterAtIndex:0];
            unichar lastCharInWord = [originalWord characterAtIndex:[originalWord length]-1];
            if (firstCharInWord == '\"') {
//                parsingADoubleQuotedString = YES;
                doubleQuoteStargingCharIndex = [self findStartingCharIndexOfWordInOrginalString : originalWord];
                continue;
            }
            if (lastCharInWord == '\"') {
                doubleQuoteEndingCharIndex = [self findEndingCharIndexOfWordInOrginalString : originalWord];
//                parsingADoubleQuotedString = NO;

                NSRange range = NSMakeRange(doubleQuoteStargingCharIndex, doubleQuoteEndingCharIndex - doubleQuoteStargingCharIndex);                
                NSString* doubleQuotedString = [textToParse substringWithRange:range];
                
                [methodName appendFormat:doubleQuotedString];
                continue;
            }
            
            [methodName appendString: [self capitalizedWord:wordIndex]];
        }    
    }
    self.parsedText = methodName;
    [methodName release];
}

@end
