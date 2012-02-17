//
//  Util.h
//  PetShop
//
//  Created by Nicolas Desjardins on 12-01-31.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

+(BOOL)cardNumberValid:(NSString*)plainNumber;
+(NSString*)formatCardNumber:(NSMutableString*)plainNumber;
@end
