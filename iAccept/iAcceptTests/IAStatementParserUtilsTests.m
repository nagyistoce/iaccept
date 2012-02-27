//
//  Created by Pascal Roy on 12-01-16.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAStatementParserUtilsTests.h"
#import "IAStatementParserUtils.h"

@implementation IAStatementParserUtilsTests

- (void)test_GivenQuotesAreBoundaries_WhenIRemoveBoundingDoubleQuotes_ThenTheyAreRemoved
{
    STAssertEqualObjects([IAStatementParserUtils removeBoundingDoubleQuotes : @"\"hello world\""], @"hello world", @"");
}

- (void)test_GivenQuotesAreNotBoundaries_WhenIRemoveBoundingDoubleQuotes_ThenTheyAreNotRemoved
{
    STAssertEqualObjects([IAStatementParserUtils removeBoundingDoubleQuotes : @"not \"hello world\" bounding"],@"not \"hello world\" bounding", @"");
}

- (void)test_GivenAStringWithNoCharacters_WhenICheckIfStringContainsAtLeastOneCharacter_ThenTheAnswerIsNo
{
    STAssertFalse([IAStatementParserUtils stringContainsAtLeastOneCharacter:@":,."], @"");
}

- (void)test_GivenAStringWithAtLeastOneCha_WhenICheckIfStringContainsAtLeastOneCharacter_ThenTheAnswerIsYes
{
    STAssertTrue([IAStatementParserUtils stringContainsAtLeastOneCharacter:@"a:.;"], @"");
}


@end
