//
//  Created by Nicolas Desjardins on 12-02-08.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IABaseViewSearchParameters.h>

@interface IASegmentedControlSegmentSearchParameters : IABaseViewSearchParameters

@property(strong, nonatomic) NSArray* segments;

+(IASegmentedControlSegmentSearchParameters*)initWithSegmentsTitles:(NSArray*)segments;

@end
