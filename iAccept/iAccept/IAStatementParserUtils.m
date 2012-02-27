//
//  Created by Pascal Roy on 12-01-16.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAStatementParserUtils.h"
#import "IASelectorMethodWordSplitter.h"

@implementation IAStatementParserUtils

+(NSString*) removeBoundingDoubleQuotes : (NSString*)aString {
    NSRegularExpression *regexStartingDoubleQuote = [NSRegularExpression regularExpressionWithPattern:@"^\"" options:0 error:NULL];
    NSString* aStringWithoutTheStartingDoubleQuote = [regexStartingDoubleQuote stringByReplacingMatchesInString:aString options:0 range:NSMakeRange(0,[aString length]) withTemplate:@""]; 
    NSRegularExpression *regexEndingDoubleQuote = [NSRegularExpression regularExpressionWithPattern:@"\"$" options:0 error:NULL];
    NSString* aStringWithoutBoundingDoubleQuotes = [regexEndingDoubleQuote stringByReplacingMatchesInString:aStringWithoutTheStartingDoubleQuote options:0 range:NSMakeRange(0,[aStringWithoutTheStartingDoubleQuote length]) withTemplate:@""]; 
    return aStringWithoutBoundingDoubleQuotes;
}

+(BOOL) stringContainsAtLeastOneCharacter : (NSString*) aString {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@" *\\w+ *" options:0 error:NULL];    
    NSTextCheckingResult* result = [regex firstMatchInString:aString options:0 range: NSMakeRange(0, [aString length])];
    
    if (result!=nil && result.range.location!= NSNotFound) {
        return YES;
    }
    return NO;
}

@end
