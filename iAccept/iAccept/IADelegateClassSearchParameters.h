//
//  Created by Nicolas Desjardins on 12-01-19.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Framework-iAccept/IABaseViewSearchParameters.h>

@interface IADelegateClassSearchParameters : IABaseViewSearchParameters<IAViewSearchParameters>

@property(nonatomic, strong) Class clazz;

+(IADelegateClassSearchParameters*) initWithDelegateClass:(Class)clazz;


@end
