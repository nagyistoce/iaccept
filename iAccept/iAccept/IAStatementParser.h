//
//  Created by Pascal Roy on 12-01-29.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IAParsedStatement;
@protocol IAStatementParser <NSObject>

-(IAParsedStatement*) parse;

@end
