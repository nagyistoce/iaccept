//
//  Created by Pascal Roy on 12-01-18.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IAThenResult : NSObject

@property (nonatomic, copy) NSString* thenConditionNotMetMessage;

+(IAThenResult*) makeThenStatementConditionMetReturnValue;
+(IAThenResult*) makeThenStatementConditionNotMetValue : (NSString*)aConditionNotMetMessage;
+(IAThenResult*) makeThenStatementConditionNotMetValue : (NSString*)aConditionNotMetMessage andForceRecall:(BOOL)recall;

-(BOOL) thenStatementConditionMet;
-(BOOL) wasCausedByExceptionThrownByFixtureSelector;

-(BOOL) recall;
@end
