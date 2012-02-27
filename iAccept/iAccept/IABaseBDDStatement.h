//
//  Created by Pascal Roy on 12-01-29.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IABaseStatement.h>
#import <Framework-iAccept/IABDDStatement.h>
@class IAParsedStatement;

@protocol IAStatementParser;
@interface IABaseBDDStatement : IABaseStatement<IABDDStatement>

-(void) setFixtureFromParsedStatement : (IAParsedStatement*) parsedStatement;

@end
