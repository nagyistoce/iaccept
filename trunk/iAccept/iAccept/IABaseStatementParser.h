//
//  Created by Pascal Roy on 12-01-21.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAStatementParser.h>

@interface IABaseStatementParser : NSObject<IAStatementParser>

@property (nonatomic, copy) NSString* textToParse;

-(id) initWithText : (NSString*) aTextToParse;
-(NSInteger) countTextToParseWords ;
-(NSArray*) textToParseWords;

@end
