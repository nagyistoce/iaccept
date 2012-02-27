//
//  Created by Nicolas Desjardins on 12-01-20.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Framework-iAccept/IABaseViewSearchParameters.h>

@interface IAPropertiesSearchParameters : IABaseViewSearchParameters<IAViewSearchParameters>

@property(nonatomic, strong) NSDictionary* properties;

+(IAPropertiesSearchParameters*) initWithPropertiesToMatch:(NSDictionary*)properties;


@end
