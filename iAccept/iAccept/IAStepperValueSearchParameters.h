//
//  Created by Nicolas Desjardins on 12-02-06.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IABaseViewSearchParameters.h>

@interface IAStepperValueSearchParameters : IABaseViewSearchParameters<IAViewSearchParameters>

@property(nonatomic) double value;

+(IAStepperValueSearchParameters*)initWithValue:(double)value;

@end
