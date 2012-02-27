//
//  Created by Nicolas Desjardins on 12-01-13.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAViewSearchParameters.h>
#import <Framework-iAccept/IABaseViewSearchParameters.h>

@interface IAViewClassSearchParameters : IABaseViewSearchParameters<IAViewSearchParameters>

@property(nonatomic, strong) Class clazz;

+(IAViewClassSearchParameters*) initWithClass:(Class)clazz;

@end
