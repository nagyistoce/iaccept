//
//  Created by Nicolas Desjardins on 12-02-09.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAWebViewOperator.h"

@implementation IAWebViewOperator

+(IAWebViewOperator*) webViewOperatorForUIWebView:(UIWebView*)uiWebView {
    IAWebViewOperator* operator = [[IAWebViewOperator alloc] init];
    [operator setUiView:uiWebView];
    return [operator autorelease];
}

-(UIWebView*)uiWebView {
    return (UIWebView*)[self uiView];
}

-(NSString*)loadedURL {
    return self.uiWebView.request.URL.absoluteString;
}

-(BOOL)isLoading {
    return [self.uiWebView isLoading];
}

@end
