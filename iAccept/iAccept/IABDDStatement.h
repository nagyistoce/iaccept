//
//  IABDDStatement.h
//  iAccept
//
//  Created by Pascal Roy on 12-01-29.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAStatement.h>
@class IAParsedStatement;
@protocol IASelectorReturnValue;
@protocol IABDDStatement <IAStatement>

@property (nonatomic, retain) IABaseFixture* fixture;
@property (nonatomic) SEL selectorToCallOnTestFixture;

-(void) performStatementSelector:(IAParsedStatement*)parsedStatement;

@end
