//
//  Created by Pascal Roy on 12-01-21.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IASelector;

@interface IASelectorMatcher : NSObject

-(IASelector*) match : (NSString*)selectorText onFixtureClass: (Class) aFixtureClass;

@end
