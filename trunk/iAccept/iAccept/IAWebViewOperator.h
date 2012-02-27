//
//  Created by Nicolas Desjardins on 12-02-09.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAViewOperator.h>

@interface IAWebViewOperator : IAViewOperator

+(IAWebViewOperator*) webViewOperatorForUIWebView:(UIWebView*)uiWebView;

-(UIWebView*)uiWebView;

-(NSString*)loadedURL;

-(BOOL)isLoading;
@end
