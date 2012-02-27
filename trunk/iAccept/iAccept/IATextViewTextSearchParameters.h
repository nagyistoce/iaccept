//
//  Created by Nicolas Desjardins on 12-02-04.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IABaseViewSearchParameters.h>

@interface IATextViewTextSearchParameters : IABaseViewSearchParameters<IAViewSearchParameters>

@property(strong, nonatomic) NSString* text;

+(IATextViewTextSearchParameters*)initWithText:(NSString*)text;

@end
