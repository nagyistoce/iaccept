//
//  Created by Pascal Roy on 12-01-28.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAThenResult.h>

@interface IAThenExceptionReturnValue : IAThenResult

@property (nonatomic, copy) NSException* exception;

+(IAThenResult*) makeExceptionReturnValue :  (NSString*)aMessage exception : (NSException*)anException;
-(id) initWithConditionMessage : (NSString*)aMessage exception : (NSException*)anException;

@end
