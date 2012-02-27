//
//  Created by Pascal Roy on 12-01-14.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IASelector;

@interface IASelectorTextParser : NSObject {
}

@property (nonatomic, copy) NSString* textToParse;
@property (nonatomic, copy) NSString* parsedText;
@property (nonatomic, copy) NSString* capitalizedTextToParse;
@property (nonatomic, copy) NSString* lowerCasedTextToParse;
@property (nonatomic, copy) NSArray *originalWords;
@property (nonatomic, copy) NSArray *lowercasedWords;
@property (nonatomic, copy) NSArray *capitalizedWords;

-(id)initWithTextToParse : (NSString*) aTextToParse;
-(void) parse;
-(NSUInteger) wordCount;

@end
