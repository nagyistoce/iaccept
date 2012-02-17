//
//  ETPaymentDOneViewController.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-01-30.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "ETPaymentDoneViewController.h"
#import "StoreMapAnnotation.h"

@implementation ETPaymentDoneViewController
@synthesize storeMap = _storeMap;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _storeMap.delegate=self;
    
    MKCoordinateRegion region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(45.508867,-73.554242), MKCoordinateSpanMake(0.04, 0));
    [_storeMap setRegion:region];
    
    StoreMapAnnotation* storeLocation = [[StoreMapAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(45.508867,-73.554242)];
    [_storeMap addAnnotation:storeLocation];
    
    UIBarButtonItem *okButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(handleBack:)];
    self.navigationItem.leftBarButtonItem = okButton;
}

- (void) handleBack:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [self setStoreMap:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
	MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"store"];
	annView.animatesDrop=TRUE;
	return annView;
}

@end
