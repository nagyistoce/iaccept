//
//  Created by Pascal Roy on 11-11-12.
//  Copyright 2011 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const IA_LOGGER_EMPTY_LINE_SEPARATOR_TEXT;
extern NSString* const IA_LOGGER_TESTS_STARTED;

@protocol IALogger <NSObject>

-(void) log : (NSString*) textToLog;
-(void) logEmptyLineSeparator;

@end
