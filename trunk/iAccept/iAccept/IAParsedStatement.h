//
//  Created by Pascal Roy on 12-01-29.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IAParsedStatement : NSObject

@property (nonatomic, copy) NSString* textToParse;

@property (nonatomic, copy) NSString* fixtureSourceText;
@property (nonatomic, copy) NSString* fixtureParsedText;
@property (nonatomic, copy) NSString* fixtureClassName;

@property (nonatomic, copy) NSString* selectorSourceText;
@property (nonatomic, copy) NSString* selectorParsedText;
@property (nonatomic, copy) NSString* selectorName;


@end
