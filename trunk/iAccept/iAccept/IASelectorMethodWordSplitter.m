//
//  Created by Pascal Roy on 12-02-03.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IASelectorMethodWordSplitter.h"

@implementation IASelectorMethodWordSplitter

-(BOOL) isEndOfWordCharacter : (unichar)aCharacter previousCharacter : (unichar) aPreviousCharacter {
    NSCharacterSet *uppercaseLetterCharacterSet = [NSCharacterSet uppercaseLetterCharacterSet];
    NSCharacterSet *lowercaseLetterCharacterSet = [NSCharacterSet lowercaseLetterCharacterSet];
    NSCharacterSet *digitCharacterSet = [NSCharacterSet decimalDigitCharacterSet];
    
    if ([lowercaseLetterCharacterSet characterIsMember:aPreviousCharacter] &&
        [uppercaseLetterCharacterSet characterIsMember:aCharacter])
        return YES;

    if ([uppercaseLetterCharacterSet characterIsMember:aPreviousCharacter] &&
        [uppercaseLetterCharacterSet characterIsMember:aCharacter])
        return YES;
    
    if ([lowercaseLetterCharacterSet characterIsMember:aPreviousCharacter] &&
        [digitCharacterSet characterIsMember:aCharacter])
        return YES;

    if ([digitCharacterSet characterIsMember:aPreviousCharacter] &&
        [uppercaseLetterCharacterSet characterIsMember:aCharacter])
        return YES;

    return NO;
}

-(BOOL)isLastCharIndex : (NSUInteger)anIndex ofMethodName: (NSString*) aMethodName {
    return anIndex == [aMethodName length]-1; 
}

-(NSArray*) splitMethodNameIntoWords : (NSString*)aMethodName {
    NSMutableArray* words = [[NSMutableArray alloc] init];
    NSUInteger startingCharWordIndex = 0;
    unichar previousCharacter = [aMethodName characterAtIndex:0];

    for (NSUInteger charIndex = 0; charIndex < [aMethodName length]; charIndex++) {
        unichar character = [aMethodName characterAtIndex:charIndex];
        if (charIndex > 0) {
            
            if ([self isEndOfWordCharacter:character previousCharacter:previousCharacter] && ![self isLastCharIndex:charIndex ofMethodName:aMethodName] ) {
                NSUInteger wordLengthInChars = charIndex - startingCharWordIndex;                
                NSString* aWord = [aMethodName substringWithRange:NSMakeRange(startingCharWordIndex, wordLengthInChars)];
                [words addObject:aWord];                    
                startingCharWordIndex = charIndex;
            }
            
            if ([self isLastCharIndex:charIndex ofMethodName:aMethodName]) {         
                if ([self isEndOfWordCharacter:character previousCharacter:previousCharacter]) {
                
                    NSUInteger wordLengthInChars = charIndex - startingCharWordIndex;                
                    NSString* previousToLastWord = [aMethodName substringWithRange:NSMakeRange(startingCharWordIndex, wordLengthInChars)];
                    [words addObject:previousToLastWord];                    
                
                    NSString* lastWord = [aMethodName substringWithRange:NSMakeRange([aMethodName length]-1, 1)];
                    [words addObject:lastWord];                
                }   
                else {
                    NSUInteger wordLengthInChars = charIndex - startingCharWordIndex + 1;                
                    NSString* aWord = [aMethodName substringWithRange:NSMakeRange(startingCharWordIndex, wordLengthInChars)];
                    [words addObject:aWord];                    
                
                }
            }

        }
        previousCharacter = character;
    }    
    return [words autorelease];
}

@end
