//
//  Created by Pascal Roy on 12-01-25.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IABaseStatementParserTests.h"
#import "IABaseStatementParser.h"
@implementation IABaseStatementParserTests


-(void) testInit {
    NSString* textToParse = @"sample screen";
    
    
    IABaseStatementParser* parser = [[IABaseStatementParser alloc] initWithText : textToParse];
    
    
    STAssertEqualObjects(parser.textToParse, textToParse, @""); 
    [parser release];
}

-(void) testInit_doesNotParseAnythingUntilParseIsSpecificallyCalled {
    NSString* textToParse = @"sample screen";
    
    
    IABaseStatementParser* parser = [[IABaseStatementParser alloc] initWithText : textToParse];
    
    
    [parser release];
}

-(void) testDescription {
    NSString* textToParse = @"sample screen";
    IABaseStatementParser* parser = [[IABaseStatementParser alloc] initWithText : textToParse];
    
    
    STAssertEqualObjects(parser.description, @"IABaseStatementParser[textToParse=sample screen]", @"");
    [parser release];
}

-(void) testCountTextToParseWords_usingSingleSpace {
    NSString* textToParse = @"sample screen";
    
    
    IABaseStatementParser* parser = [[IABaseStatementParser alloc] initWithText : textToParse];
    
    
    STAssertEquals([parser countTextToParseWords], 2, @"");
}


@end
