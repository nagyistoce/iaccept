//
//  Created by Pascal Roy on 12-01-29.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAParsedStatement.h"

@implementation IAParsedStatement

@synthesize textToParse;

@synthesize fixtureSourceText;
@synthesize fixtureParsedText;
@synthesize fixtureClassName;

@synthesize selectorSourceText;
@synthesize selectorParsedText;
@synthesize selectorName;

-(id) init {
    self = [super init];
    if (self) {
    
    }
    return self;
}

-(void) dealloc {
    [textToParse release];
    
    [fixtureSourceText release];
    [fixtureParsedText release];
    [fixtureClassName release];
    
    [selectorSourceText release];
    [selectorParsedText release];
    [selectorName release];
    
    [super dealloc];
}


-(NSString*) description {
    NSMutableString* description = [[NSMutableString alloc]init];
    [description appendFormat:@"%@[", NSStringFromClass([self class])];
    [description appendFormat:@"textToParse=%@,", textToParse];
    [description appendFormat:@"fixtureSourceText=%@,", fixtureSourceText];
    [description appendFormat:@"fixtureParsedText=%@,", fixtureParsedText];
    [description appendFormat:@"selectorSourceText=%@,", selectorSourceText];
    [description appendFormat:@"selectorParsedText=%@,", selectorParsedText];
    [description appendFormat:@"selectorName=%@", selectorName];
    [description appendString:@"]"];
    return [description autorelease];
}

@end
