//
//  Created by Pascal Roy on 11-12-12.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import "IAInMemoryLogger.h"

@implementation IAInMemoryLogger
@synthesize logEntries;

-(id) init {
    self = [super init];
    if (self) {
        logEntries = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) dealloc {
    [logEntries release];
    [super dealloc];
}

-(void) log : (NSString*) textToLog {
    [logEntries addObject:textToLog];
}

-(void) logEmptyLineSeparator {
    [logEntries addObject:IA_LOGGER_EMPTY_LINE_SEPARATOR_TEXT];
} 

-(NSString*) getLogEntry : (int) logIndex {
    return [logEntries objectAtIndex:logIndex];
}

@end
