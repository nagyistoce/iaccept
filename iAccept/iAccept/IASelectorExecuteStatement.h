//
//  Created by Pascal Roy on 11-12-21.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAStatement.h>

@interface IASelectorExecuteStatement : NSObject<IAStatement>

@property (nonatomic) SEL selector;
@property (nonatomic, retain) NSObject* targetOfSelector;
@property (nonatomic, retain) IATest* parentTest;
@property (nonatomic) int suiteLineNo;

- (id)initWithSelector : (SEL)aSelector onTargetOfSelector : (NSObject*) aTargetOfSelector test : (IATest*) aTest suiteLineNo : (int)theSuiteLineNo;

- (SEL) getSelector;
- (NSObject*) getTargetOfSelector;
-(void) run;

@end
