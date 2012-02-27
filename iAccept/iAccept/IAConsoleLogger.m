//
//  Created by Pascal Roy on 11-11-12.
//  Copyright 2011 Elapse Technologies. All rights reserved.
//

#import "IAConsoleLogger.h"

@implementation IAConsoleLogger

NSString * const IA_LOGGER_EMPTY_LINE_SEPARATOR_TEXT = @" ";

-(void) log : (NSString*) textToLog {
    NSLog(@"%@", textToLog);
}

-(void) logEmptyLineSeparator {
    NSLog(@" ");
}

@end
