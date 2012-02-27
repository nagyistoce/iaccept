//
//  Created by Pascal Roy on 12-01-23.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IASelectorReturnValue.h>

@interface IASelectorDataTypeReturnValue : NSObject<IASelectorReturnValue>

@property (nonatomic, assign) void* value;

-(id)initWithValue : (void*) aValue;

@end
