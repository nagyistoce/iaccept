//
//  Created by Pascal Roy on 12-01-24.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IABaseStatementParser.h>

@interface IAGivenThenStatementParser : IABaseStatementParser

@property (nonatomic) NSInteger fixtureSourceTextStartWordIndex;
@property (nonatomic) NSInteger fixtureParsedTextStartWordIndex;
@property (nonatomic) NSInteger fixtureSourceTextEndWordIndex;
@property (nonatomic) NSInteger selectorSourceTextStartWordIndex;
@property (nonatomic) NSInteger selectorSourceTextEndWordIndex;

-(NSString*) textFromWords : (NSArray*) words startWordIndex : (NSInteger)aStartWordIndex endWordIndex : (NSInteger)anEndWordIndex;

@end
