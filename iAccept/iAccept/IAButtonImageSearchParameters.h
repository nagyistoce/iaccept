//
//  Created by Nicolas Desjardins on 12-01-13.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAViewSearchParameters.h>
#import <Framework-iAccept/IABaseViewSearchParameters.h>

@interface IAButtonImageSearchParameters : IABaseViewSearchParameters<IAViewSearchParameters>

@property(strong, nonatomic) UIImage* image;
@property(nonatomic) UIControlState state;

+(IAButtonImageSearchParameters*) initWithImage:(UIImage*)image andState:(UIControlState)state;

@end
