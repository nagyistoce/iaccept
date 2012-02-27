//
//  Created by Nicolas Desjardins on 12-01-26.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAViewSearchParameters.h>
#import <Framework-iAccept/IABaseViewSearchParameters.h>

@interface IATagSearchParameters : IABaseViewSearchParameters<IAViewSearchParameters>

@property(nonatomic) int tag;

+(IATagSearchParameters*) initWithTag:(int)tag;

@end
