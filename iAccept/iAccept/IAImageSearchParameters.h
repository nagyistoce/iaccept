//
//  Created by Nicolas Desjardins on 12-01-25.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAViewSearchParameters.h>
#import <Framework-iAccept/IABaseViewSearchParameters.h>

@interface IAImageSearchParameters : IABaseViewSearchParameters<IAViewSearchParameters>

@property(strong, nonatomic) UIImage* image;

+(IAImageSearchParameters*) initWithImage:(UIImage*)image;

@end
