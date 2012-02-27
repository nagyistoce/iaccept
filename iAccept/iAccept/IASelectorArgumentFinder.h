//
//  Created by Pascal Roy on 12-02-03.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IASelectorArgumentFinder : NSObject

-(NSArray*)findArgumentsForSelector: (NSString*)methodName inText: (NSString*)aText;

-(NSUInteger) findStartingCharIndexOfToken : (NSString*)token inString : (NSString*)aString;
-(NSUInteger) findEndingCharIndexOfToken : (NSString*)token inString : (NSString*)aString;

@end
