//
//  ETStorePolicyPage1Controller.h
//  PetShop
//
//  Created by Nicolas Desjardins on 12-02-03.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETStorePolicyPageController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property(strong, nonatomic) NSString* text;

- (IBAction)sendByEmail:(id)sender;
- (IBAction)sendByIM:(id)sender;


@end
