//
//  Created by Nicolas Desjardins on 12-01-13.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IABaseViewSearchParameters.h>

@interface IANavigationBarTitleSearchParameters : IABaseViewSearchParameters<IAViewSearchParameters>

@property(strong, nonatomic) NSString* title;

+(IANavigationBarTitleSearchParameters*) initWithTitle:(NSString*)title;

@end
