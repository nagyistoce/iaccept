//
//  Created by Nicolas Desjardins on 12-01-18.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Framework-iAccept/IABaseViewSearchParameters.h>

@interface IATextFieldTextSearchParameters : IABaseViewSearchParameters<IAViewSearchParameters>

@property(strong, nonatomic) NSString* text;

+(IATextFieldTextSearchParameters*) initWithText:(NSString*)text;

@end
