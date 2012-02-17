//
//  ETPaymentDOneViewController.h
//  PetShop
//
//  Created by Nicolas Desjardins on 12-01-30.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ETPaymentDoneViewController : UIViewController<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *storeMap;

@end
