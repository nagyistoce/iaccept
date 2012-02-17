//
//  ETAnimalWellfareViewController.h
//  PetShop
//
//  Created by Nicolas Desjardins on 12-02-08.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETMasterViewController.h"

@interface ETAnimalWellfareViewController : UIViewController<SubstitutableDetailViewController, UIScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)pageChanged:(id)sender;
- (IBAction)sendByEmail:(id)sender;
- (IBAction)sendWithGmail:(id)sender;
@end
