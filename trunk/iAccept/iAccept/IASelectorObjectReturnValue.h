//
//  Created by Pascal Roy on 12-01-23.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IASelectorReturnValue.h>

@interface IASelectorObjectReturnValue : NSObject<IASelectorReturnValue>

@property (nonatomic, retain) NSObject* value;

-(id) initWithValue : (NSObject*) aValue;

@end
