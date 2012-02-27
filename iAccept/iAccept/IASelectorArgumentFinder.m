#import "IASelectorArgumentFinder.h"
#import "IAStatementParserUtils.h"
#import "IASelectorMethodWordSplitter.h"

@implementation IASelectorArgumentFinder

-(NSUInteger) countMethodTokens : (NSString*)aMethodName {
    NSMutableCharacterSet *separators = [NSMutableCharacterSet characterSetWithCharactersInString:@":"];
    NSArray *words = [aMethodName componentsSeparatedByCharactersInSet:separators];
    return [words count];
}

-(NSString*) methodToken : (NSUInteger)tokenIndex inMethodName :(NSString*)aMethodName {
    if (tokenIndex >= [self countMethodTokens : aMethodName])
        return nil;
    
    NSMutableCharacterSet *separators = [NSMutableCharacterSet characterSetWithCharactersInString:@":"];
    NSArray *words = [aMethodName componentsSeparatedByCharactersInSet:separators];
    return [words objectAtIndex:tokenIndex];
}

-(NSString*)caseInsensitiveMethodNamePattern : (NSString*) methodName {
    NSMutableString* caseInsensitiveMethodNamePattern = [[NSMutableString alloc] init];
    NSUInteger methodLength = [methodName length];
    
    for (int charIndex = 0 ; charIndex < methodLength; charIndex++) {
        unichar c = [methodName characterAtIndex:charIndex];
        NSString* charAsString = [methodName substringWithRange:NSMakeRange(charIndex, 1)];
        NSCharacterSet *numericSet = [NSCharacterSet letterCharacterSet];
        if ([numericSet characterIsMember:c]) {
            NSString* lowercaseCharAsString = [charAsString lowercaseString];
            NSString* uppercaseCharAsString = [charAsString uppercaseString];
            
            [caseInsensitiveMethodNamePattern appendFormat:@"[%@%@]",lowercaseCharAsString, uppercaseCharAsString];
        }
        else {
            [caseInsensitiveMethodNamePattern appendFormat:@"%@",charAsString];        
        }
        
    }
    return [caseInsensitiveMethodNamePattern autorelease];
}

-(NSUInteger) findStartingCharIndexOfToken : (NSString*)token inString : (NSString*)aString {
    IASelectorMethodWordSplitter* splitter = [[IASelectorMethodWordSplitter alloc] init];
    NSArray* tokenWords = [splitter splitMethodNameIntoWords:token];
    [splitter release];
    
    NSMutableString* searchPattern = [[[NSMutableString alloc] init] autorelease];
    
    for (int tokenWordIndex = 0; tokenWordIndex < [tokenWords count]; tokenWordIndex++) {
        NSString* tokenWord = [tokenWords objectAtIndex:tokenWordIndex];
        NSString* caseInsensitiveTokenPattern = [self caseInsensitiveMethodNamePattern:tokenWord];
        
        [searchPattern appendString:@"\\b"];
        [searchPattern appendString: caseInsensitiveTokenPattern];
        [searchPattern appendString:@"\\b"];
        if (tokenWordIndex != [tokenWords count]-1) {
            [searchPattern appendString:@" *"];            
        }
    }
    
    NSRegularExpression *regEx = [NSRegularExpression regularExpressionWithPattern:searchPattern options:0 error:NULL];
    NSTextCheckingResult* result = [regEx firstMatchInString:aString options:0 range:NSMakeRange(0, [aString length])];
    if (result != nil && result.range.location != NSNotFound) {
        return result.range.location;
    }
    return -1;
}

-(NSUInteger) findEndingCharIndexOfToken : (NSString*)token inString : (NSString*)aString {
    IASelectorMethodWordSplitter* splitter = [[IASelectorMethodWordSplitter alloc] init];
    NSArray* tokenWords = [splitter splitMethodNameIntoWords:token];
    [splitter release];
    
    NSMutableString* searchPattern = [[[NSMutableString alloc] init] autorelease];
    
    for (int tokenWordIndex = 0; tokenWordIndex < [tokenWords count]; tokenWordIndex++) {
        NSString* tokenWord = [tokenWords objectAtIndex:tokenWordIndex];
        NSString* caseInsensitiveTokenPattern = [self caseInsensitiveMethodNamePattern:tokenWord];
        
        [searchPattern appendString:@"\\b"];
        [searchPattern appendString: caseInsensitiveTokenPattern];
        [searchPattern appendString:@"\\b"];
        if (tokenWordIndex != [tokenWords count]-1) {
            [searchPattern appendString:@" *"];            
        }
    }
 
    NSRegularExpression *regEx = [NSRegularExpression regularExpressionWithPattern:searchPattern options:0 error:NULL];
    NSTextCheckingResult* result = [regEx firstMatchInString:aString options:0 range:NSMakeRange(0, [aString length])];
    if (result != nil && result.range.location != NSNotFound) {
        return result.range.location + result.range.length - 1;
    }
    return -1;
}


-(NSArray*) argumentsAsStrings : (NSString*) selectorText methodName : (NSString*) aMethodName {
    NSMutableArray* argumentsAsStrings = [[NSMutableArray alloc] init];
    
    for (NSUInteger tokenIndex = 0; tokenIndex < [self countMethodTokens:aMethodName]; tokenIndex++) {
        NSString* methodToken = [self methodToken: tokenIndex inMethodName :aMethodName];
        if (methodToken == nil || [methodToken isEqualToString:@""]) {
            return [argumentsAsStrings autorelease];
        }
        
        NSString* nextMethodToken = [self methodToken:tokenIndex+1 inMethodName:aMethodName];
        if (nextMethodToken == nil || [nextMethodToken isEqualToString:@""]) {
            NSUInteger endingCharIndexOfTokenInSelectorText = [self findEndingCharIndexOfToken:methodToken inString:selectorText];
            NSUInteger endingCharIndexOfSelectorText = [selectorText length] - 1;
            
            if (endingCharIndexOfTokenInSelectorText != endingCharIndexOfSelectorText) {
                NSUInteger locationOfArgument = endingCharIndexOfTokenInSelectorText+1;
                NSUInteger lengthOfArgument = endingCharIndexOfSelectorText - endingCharIndexOfTokenInSelectorText;
                NSRange rangeOfArgument = NSMakeRange(locationOfArgument, lengthOfArgument);
                NSString* rawArgumentText = [selectorText substringWithRange:rangeOfArgument];
                NSString* argumentText = [IAStatementParserUtils removeBoundingDoubleQuotes:rawArgumentText];
                NSString *trimmedArgumentText = [argumentText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                [argumentsAsStrings addObject:trimmedArgumentText];
            }
        }
        else {
            NSUInteger endingCharIndexOfTokenInSelectorText = [self findEndingCharIndexOfToken:methodToken inString:selectorText];
            NSUInteger startingCharIndexOfNextMethodToken = [self findStartingCharIndexOfToken:nextMethodToken inString:selectorText];
            NSUInteger lengthOfArgument = startingCharIndexOfNextMethodToken - endingCharIndexOfTokenInSelectorText-1;
            
            NSUInteger locationOfArgument = endingCharIndexOfTokenInSelectorText+1;
            NSRange rangeOfArgument = NSMakeRange(locationOfArgument, lengthOfArgument);
            NSString* rawArgumentText = [selectorText substringWithRange:rangeOfArgument];
            NSString* argumentText = [IAStatementParserUtils removeBoundingDoubleQuotes:rawArgumentText];
            NSString *trimmedArgumentText = [argumentText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            [argumentsAsStrings addObject:trimmedArgumentText];
        }
    }   
    return [argumentsAsStrings autorelease];
}

-(NSArray*)findArgumentsForSelector: (NSString*)aMethodName inText: (NSString*)aText {
   return [self argumentsAsStrings : aText methodName : aMethodName];
}

@end
