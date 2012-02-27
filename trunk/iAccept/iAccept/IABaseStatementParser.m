//
//  Created by Pascal Roy on 12-01-21.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IABaseStatementParser.h"
#import "IAException.h"
#import "IAParsedStatement.h"

@implementation IABaseStatementParser

@synthesize textToParse;

-(id) initWithText : (NSString*) aTextToParse {
    self = [super init];
    if (self) {
        self.textToParse = aTextToParse;
    }
    return self;
}

-(void) dealloc {
    [textToParse release];
 
    [super dealloc];
}

-(IAParsedStatement*) parse {
    [IAException raise:@"IABaseStatementParser subclasses must implement parse"];
    return nil;
}

-(NSInteger) countTextToParseWords {
    NSMutableCharacterSet *separators = [NSMutableCharacterSet whitespaceCharacterSet];
    NSArray *words = [textToParse componentsSeparatedByCharactersInSet:separators];
    return [words count];
}

-(NSArray*) textToParseWords {
    NSMutableCharacterSet *separators = [NSMutableCharacterSet whitespaceCharacterSet];    
    NSArray *textToParseWords = [self.textToParse componentsSeparatedByCharactersInSet:separators];
    return textToParseWords;
}

-(NSString*) description {
    NSMutableString* description = [[NSMutableString alloc]init];
    [description appendFormat:@"%@[", NSStringFromClass([self class])];
    [description appendFormat:@"textToParse=%@", textToParse];
    [description appendString:@"]"];
    return [description autorelease];
}

@end
