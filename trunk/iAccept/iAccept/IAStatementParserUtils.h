//
//  Created by Pascal Roy on 12-01-16.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IAStatementParserUtils : NSObject

+(NSString*) removeBoundingDoubleQuotes : (NSString*)aString;
+(BOOL) stringContainsAtLeastOneCharacter : (NSString*) aString;

@end
