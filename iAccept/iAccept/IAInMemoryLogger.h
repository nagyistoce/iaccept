//
//  Created by Pascal Roy on 11-12-12.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IALogger.h>

@interface IAInMemoryLogger : NSObject<IALogger>

@property (nonatomic, retain) NSMutableArray* logEntries;


-(NSString*) getLogEntry : (int) logIndex;

@end
