//
//  ETDetailViewController.h
//  PetShop
//
//  Created by Nicolas Desjardins on 11-11-18.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETMasterViewController.h"

@interface ETDetailViewController : UIViewController <SubstitutableDetailViewController>

@property (strong, nonatomic) NSString* petKind;
@property (strong, nonatomic) UIImage* petImage;
@property (strong, nonatomic) NSString* petTitle;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *addToCartButton;

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *petKindImage;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *petKindLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *petTable;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *petPhotoImage;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *breedLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *nameLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *colorLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *bornLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *ageLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *priceLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *specialPriceLabel;

- (IBAction)addToCartButtonTouch:(id)sender;

- (void)setPetKind:(NSString*)petKind withTitle:(NSString*)title andPetImage:(UIImage*)image;

@end
