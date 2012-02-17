//
//  ETPaymentViewController.h
//  PetShop
//
//  Created by Nicolas Desjardins on 12-01-30.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETPaymentViewController : UITabBarController<UINavigationControllerDelegate>

-(id)initWithOrderCost:(int)orderCost;

@property (nonatomic) int orderCost;

-(void)pushViewPaymentDone;

-(void)popView;

@end
