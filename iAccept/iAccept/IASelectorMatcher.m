//
//  Created by Pascal Roy on 12-01-21.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "objc/runtime.h"
#import "IASelectorMatcher.h"
#import "IAStatementParserUtils.h"
#import "IASelector.h"
#import "IASelectorTextParser.h"
#import "IASelectorArgumentFinder.h"

@implementation IASelectorMatcher

-(NSArray*) classMethods : (Class) aClass {
    NSUInteger count;
    Method* methods = class_copyMethodList(aClass, &count);
    NSMutableArray* methodArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++)
    {
        SEL selector = method_getName(methods[i]);
        const char* methodName = sel_getName(selector);
        [methodArray addObject:[NSString  stringWithCString:methodName encoding:NSUTF8StringEncoding]];
    }
    free(methods);
    return methodArray;
}

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

-(NSUInteger) startingCharIndexOfToken : (NSString*)token inString : (NSString*)aString {
    NSString* caseInsensitiveTokenPattern = [self caseInsensitiveMethodNamePattern:token];
    NSRegularExpression *regEx = [NSRegularExpression regularExpressionWithPattern:caseInsensitiveTokenPattern options:0 error:NULL];
    NSTextCheckingResult* result = [regEx firstMatchInString:aString options:0 range:NSMakeRange(0, [aString length])];
    if (result == nil || result.range.location == NSNotFound) 
        return NSNotFound;
    else {
        return result.range.location;
    }
}

-(NSUInteger) endingCharIndexOfToken : (NSString*)token inString : (NSString*)aString {
    NSString* caseInsensitiveTokenPattern = [self caseInsensitiveMethodNamePattern:token];
    NSRegularExpression *regEx = [NSRegularExpression regularExpressionWithPattern:caseInsensitiveTokenPattern options:0 error:NULL];
    NSTextCheckingResult* result = [regEx firstMatchInString:aString options:0 range:NSMakeRange(0, [aString length])];
    if (result == nil || result.range.location == NSNotFound) 
        return NSNotFound;
    else {
        return result.range.location + result.range.length - 1;
    }
}

-(NSRange) rangeOfMethodToken : (NSString*)methodToken inString : (NSString*)aString {
    NSUInteger startingCharIndex = [self startingCharIndexOfToken:methodToken inString:aString];
    NSUInteger endingCharIndex = [self endingCharIndexOfToken:methodToken inString:aString];
    NSRange range = NSMakeRange(startingCharIndex, endingCharIndex - startingCharIndex + 1);
    return range;
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
            NSUInteger endingCharIndexOfTokenInSelectorText = [self endingCharIndexOfToken:methodToken inString:selectorText];
            NSUInteger endingCharIndexOfSelectorText = [selectorText length] - 1;
            
            if (endingCharIndexOfTokenInSelectorText != endingCharIndexOfSelectorText) {
                NSUInteger locationOfArgument = endingCharIndexOfTokenInSelectorText+1;
                NSUInteger lengthOfArgument = endingCharIndexOfSelectorText - endingCharIndexOfTokenInSelectorText;
                NSRange rangeOfArgument = NSMakeRange(locationOfArgument, lengthOfArgument);
                NSString* rawArgumentText = [selectorText substringWithRange:rangeOfArgument];
                NSString* argumentText = [IAStatementParserUtils removeBoundingDoubleQuotes:rawArgumentText];
                [argumentsAsStrings addObject:argumentText];
            }
        }
        else {
            NSUInteger endingCharIndexOfTokenInSelectorText = [self endingCharIndexOfToken:methodToken inString:selectorText];
            NSUInteger startingCharIndexOfNextMethodToken = [self startingCharIndexOfToken:nextMethodToken inString:selectorText];
            NSUInteger lengthOfArgument = startingCharIndexOfNextMethodToken - endingCharIndexOfTokenInSelectorText - 1;
            
            NSUInteger locationOfArgument = endingCharIndexOfTokenInSelectorText+1;
            NSRange rangeOfArgument = NSMakeRange(locationOfArgument, lengthOfArgument);
            NSString* rawArgumentText = [selectorText substringWithRange:rangeOfArgument];
            NSString* argumentText = [IAStatementParserUtils removeBoundingDoubleQuotes:rawArgumentText];
            [argumentsAsStrings addObject:argumentText];
        }
    }   
    return [argumentsAsStrings autorelease];
}

-(NSString*) methodNameMatchingPatternForMethodName : (NSString*) methodName {
    NSMutableString* methodNameMatchingPattern = [[NSMutableString alloc] init];
    [methodNameMatchingPattern appendString:@"^"];
    [methodNameMatchingPattern appendString:[self caseInsensitiveMethodNamePattern: methodName]];
    [methodNameMatchingPattern appendString:@"$"];
    
    NSRegularExpression *lastColonExpression = [NSRegularExpression regularExpressionWithPattern:@":\\$" options:0 error:NULL];
    NSString* methodNameMatchingPatternWithoutLastColon = [lastColonExpression stringByReplacingMatchesInString:methodNameMatchingPattern options:0 range:NSMakeRange(0,[methodNameMatchingPattern length]) withTemplate:@".*"]; 
    
    NSRegularExpression *anyColonExpression = [NSRegularExpression regularExpressionWithPattern:@":" options:0 error:NULL];
    NSString* methodNameMatchingPatternWithoutColons = [anyColonExpression stringByReplacingMatchesInString:methodNameMatchingPatternWithoutLastColon options:0 range:NSMakeRange(0,[methodNameMatchingPatternWithoutLastColon length]) withTemplate:@".*"]; 
    [methodNameMatchingPattern release];
    
    return methodNameMatchingPatternWithoutColons;
}

-(IASelector*) match : (NSString*)selectorText onFixtureClass: (Class) aFixtureClass {
    IASelectorTextParser* selectorTextParser = [[IASelectorTextParser alloc] initWithTextToParse:selectorText];
    [selectorTextParser parse];
    NSString* selectorName = selectorTextParser.parsedText;
    
    @try {
        NSArray* methodNamesOnClass = [self classMethods:aFixtureClass];
        for (NSString* methodName in methodNamesOnClass) {
            NSString* regExMatchingPattern = [self methodNameMatchingPatternForMethodName:methodName];
            
            NSRegularExpression *regEx = [NSRegularExpression regularExpressionWithPattern:regExMatchingPattern options:0 error:NULL];
            NSTextCheckingResult* result = [regEx firstMatchInString:selectorName options:0 range:NSMakeRange(0, [selectorName length])];
            if (result != nil && result.range.location != NSNotFound) {        
                SEL selector = NSSelectorFromString(methodName);
                
                IASelectorArgumentFinder* argumentTextFinder = [[IASelectorArgumentFinder alloc] init];
                NSLog(@"IASelectorMatcher selectorText = %@, methodName=%@", selectorText, methodName);
            
                NSArray* argumentsAsStrings = [argumentTextFinder findArgumentsForSelector:methodName inText:selectorText];
                for (int argumentCount= 0; argumentCount < [argumentsAsStrings count]; argumentCount++) {
                    NSLog(@"IASelectorMatcher found argument = %@", [argumentsAsStrings objectAtIndex:argumentCount]);
                }
                
                IASelector* iaSelector = [[IASelector alloc] initWithSelector:selector argumentsAsStrings:argumentsAsStrings];
                return iaSelector;
            }   
        }
    }
    @catch (NSException *exception) {
        NSLog(@"IASelectorMatcher threw exception %@", exception.name);
    }
    @finally {
    }
    return nil;
}

@end
