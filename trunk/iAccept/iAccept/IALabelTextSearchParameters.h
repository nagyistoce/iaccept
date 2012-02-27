//
//  Created by Nicolas Desjardins on 12-01-13.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IABaseViewSearchParameters.h>

@interface IALabelTextSearchParameters : IABaseViewSearchParameters<IAViewSearchParameters>

@property(strong, nonatomic) NSString* text;

+(IALabelTextSearchParameters*) initWithText:(NSString*)text;

@end
