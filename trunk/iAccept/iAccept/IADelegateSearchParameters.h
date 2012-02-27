//
//  Created by Nicolas Desjardins on 12-01-19.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Framework-iAccept/IABaseViewSearchParameters.h>

@interface IADelegateSearchParameters : IABaseViewSearchParameters<IAViewSearchParameters>

@property(nonatomic, strong) id delegate;

+(IADelegateSearchParameters*) initWithDelegate:(id)delegate;

@end
