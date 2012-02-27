//
//  Created by Nicolas Desjardins on 12-01-18.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Framework-iAccept/IAViewOperator.h>
#import <Framework-iAccept/IABaseViewSearchParameters.h>

@interface IAPickerViewSearchParameters : IABaseViewSearchParameters<IAViewSearchParameters>

@property(strong, nonatomic) NSArray* titles;

+(IAPickerViewSearchParameters*) initWithTitles:(NSArray*)titles;

@end
