//
//  Created by Pascal Roy on 12-01-18.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAThenResult.h"

@interface IAThenResult(){
    
}

@property(nonatomic) BOOL recall;

@end

@implementation IAThenResult

@synthesize recall = _recall;
@synthesize thenConditionNotMetMessage;


+(IAThenResult*) makeThenStatementConditionMetReturnValue {
    return [[[IAThenResult alloc] init] autorelease];
}
+(IAThenResult*) makeThenStatementConditionNotMetValue : (NSString*)aConditionNotMetMessage {
    IAThenResult* value = [[IAThenResult alloc] init];
    value.thenConditionNotMetMessage = aConditionNotMetMessage;
    value.recall = NO;
    return [value autorelease];                                     
}

+(IAThenResult*) makeThenStatementConditionNotMetValue : (NSString*)aConditionNotMetMessage andForceRecall:(BOOL)forceRecall {
    IAThenResult* result = [self makeThenStatementConditionNotMetValue:aConditionNotMetMessage];
    result.recall = forceRecall;
    return result;
}

-(BOOL) thenStatementConditionMet {
    return (thenConditionNotMetMessage == nil);
}

-(void)dealloc {
    [thenConditionNotMetMessage release];
    [super dealloc];
}

-(BOOL) wasCausedByExceptionThrownByFixtureSelector {
    return NO;
}

@end
