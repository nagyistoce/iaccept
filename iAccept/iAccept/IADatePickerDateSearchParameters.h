//
//  Created by Nicolas Desjardins on 12-01-24.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Framework-iAccept/IABaseViewSearchParameters.h>

@interface IADatePickerDateSearchParameters : IABaseViewSearchParameters<IAViewSearchParameters>


@property(nonatomic, strong) NSDate* date;

+(IADatePickerDateSearchParameters*) initWithFormat:(NSString*)format forDate:(NSString*)date;



@end
