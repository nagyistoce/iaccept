//
//  Created by Nicolas Desjardins on 12-01-13.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAViewSearchParameters.h>
#import <Framework-iAccept/IABaseViewSearchParameters.h>

@interface IAButtonTextSearchParameters : IABaseViewSearchParameters<IAViewSearchParameters>

@property(strong, nonatomic) NSString* text;
@property(nonatomic) UIControlState state;

+(IAButtonTextSearchParameters*) initWithText:(NSString*)text andState:(UIControlState)state;

@end
