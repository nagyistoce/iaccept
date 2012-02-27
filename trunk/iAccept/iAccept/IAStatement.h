//
//  Created by Pascal Roy on 11-11-16.
//  Copyright 2011 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IAStatementResult;
@class IATest;
@class IABaseFixture;

@protocol IAStatement <NSObject>

@property (nonatomic, retain) IATest* parentTest;
@property (nonatomic) int suiteLineNo;
@property (nonatomic, copy) NSString* statementText;

-(void) run;

@end
