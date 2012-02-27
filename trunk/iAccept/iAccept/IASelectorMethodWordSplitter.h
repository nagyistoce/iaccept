//
//  Created by Pascal Roy on 12-02-03.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IASelectorMethodWordSplitter : NSObject

-(NSArray*) splitMethodNameIntoWords : (NSString*)aMethodName;
-(BOOL) isEndOfWordCharacter : (unichar)aCharacter previousCharacter : (unichar) aPreviousCharacter;

@end
