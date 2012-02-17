//
//  PetListFixture.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-01-24.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "PetListFixture.h"
#import <Framework-iAccept/IAThenResult.h>
#import <Framework-iAccept/IASplitViewOperator.h>
#import <Framework-iAccept/IAViewOperator.h>
#import <Framework-iAccept/IALabelOperator.h>
#import <Framework-iAccept/IANavigationBarOperator.h>
#import <Framework-iAccept/IATableOperator.h>
#import <Framework-iAccept/IAButtonOperator.h>
#import "PetDAO.h"
#import "Pet.h"


@implementation PetListFixture

- (IAViewOperator *)getPetTableRow:(NSString *)dogName {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator detailViewOperator];
    IATableOperator* petTable = (IATableOperator*)[detailOperator searchForViewOfClass:[UITableView class]];
    IAViewOperator* fidoCell = [petTable searchForCellContainingALabelWithText:dogName];
    return fidoCell;
}

-(IAThenResult*)containsADogNamedFido {
    IAViewOperator *fidoRow = [self getPetTableRow:@"Fido"];
    
    if (!fidoRow) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected a dog named Fido in table"];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

-(IAThenResult*)containsADogNamedBenji {
    IAViewOperator *benjiRow = [self getPetTableRow:@"Benji"];
    
    if (!benjiRow) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected a dog named Benji in table"];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

-(IAThenResult*) benjiTableCellContainsHisNameBreedPhotoAndPrice {
    IAViewOperator *row = [self getPetTableRow:@"Benji"];
    IAViewOperator* photo = [row searchForImage:[UIImage imageNamed:@"Dogo_small.png"]];
    IAViewOperator* breed = [row searchForLabelWithText:@"Argentine Dogo"];
    IAViewOperator* price = [row searchForLabelWithText:@"710"];
    
    IAViewOperator* specialPrice = [row searchForLabelWithText:@""];
    IAViewOperator* specialTagStar = [row searchForImage:[UIImage imageNamed:@"star.png"]];
    IAViewOperator* specialTagText = [row searchForLabelWithText:@"Special!"];
    
    
    if (!row || !photo || !breed || !price || ![specialPrice isHidden] || ![specialTagStar isHidden] || ![specialTagText isHidden]) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected a dog named Benji with his breed photo and price"];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

-(IAThenResult*) fidoTableCellContainsHisNameBreedPhotoPriceSpecialPriceAndSpecialTag {
    IAViewOperator *row = [self getPetTableRow:@"Fido"];
    IAViewOperator* photo = [row searchForImage:[UIImage imageNamed:@"GoldenRetriever_small.png"]];
    IAViewOperator* breed = [row searchForLabelWithText:@"Golden Retriever"];
    IAViewOperator* price = [row searchForLabelWithText:@"625"];
    
    IAViewOperator* specialPrice = [row searchForLabelWithText:@"575"];
    IAViewOperator* specialTagStar = [row searchForImage:[UIImage imageNamed:@"star.png"]];
    IAViewOperator* specialTagText = [row searchForLabelWithText:@"Special!"];
    
    if (!row || !photo || !breed || !price || !specialPrice || !specialTagText || !specialTagText || [specialPrice isHidden] || [specialTagStar isHidden] || [specialTagText isHidden]) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected a dog named Fido with his breed photo and price"];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

-(void)iTouchFidosRow {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator detailViewOperator];
    IATableOperator* petTable = (IATableOperator*)[detailOperator searchForViewOfClass:[UITableView class]];
    IAViewOperator* row = [petTable searchForCellContainingALabelWithText:@"Fido"];
    
    [petTable selectCell:row];
}

-(void)iTouchBenjisRow {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator detailViewOperator];
    IATableOperator* petTable = (IATableOperator*)[detailOperator searchForViewOfClass:[UITableView class]];
    IAViewOperator* row = [petTable searchForCellContainingALabelWithText:@"Benji"];
    
    [petTable selectCell:row];
}

-(void) iTouchTheAddToCartButton {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator detailViewOperator];
    IAButtonOperator* addToCartButton = [detailOperator searchForButtonWithText:@"Add to cart" forState:UIControlStateNormal];
    
    [addToCartButton touch];
}

-(IAThenResult*)doesNotContainsADogNamedFido {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator detailViewOperator];
    IATableOperator* petTable = (IATableOperator*)[detailOperator searchForViewOfClass:[UITableView class]];
    IAViewOperator* fidoCell = [petTable searchForCellContainingALabelWithText:@"Fido"];
    
    if (fidoCell) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected a no dog named fido in table"];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

- (Pet*)getPetNamed:(NSString *)benjiName {
    NSArray* pets = [PetDAO petsInArray];
    for (Pet* pet in pets) {
        if ([[pet name] isEqualToString:benjiName]) {
            return pet;
        }
    }
    return nil;
}

- (NSDateFormatter *)formatterForDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    NSLocale* caLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_CA"];
    [dateFormatter setLocale:caLocale];
    return dateFormatter;
}

- (IAThenResult*)verifyPetDetailInformation:(NSString *)petName {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator detailViewOperator];
    
    Pet *pet = [self getPetNamed:petName];
    
    NSDateFormatter *dateFormatter = [self formatterForDate];
    NSString* date = [dateFormatter stringFromDate:[pet birth]];
    
    IAViewOperator* breed = [detailOperator searchForLabelWithText:[pet race] toDepth:0];
    IAViewOperator* name = [detailOperator searchForLabelWithText:[pet name] toDepth:0];
    IAViewOperator* color = [detailOperator searchForLabelWithText:[pet color] toDepth:0];
    IAViewOperator* birth = [detailOperator searchForLabelWithText:date toDepth:0];
    IAViewOperator* age = [detailOperator searchForLabelWithText:[pet age] toDepth:0];
    IAViewOperator* price = [detailOperator searchForLabelWithText:[[pet price] stringValue] toDepth:0];
    
    if ( !breed || !name || !color || !birth || !age || !price ) {
        return [IAThenResult makeThenStatementConditionNotMetValue:[NSString stringWithFormat:@"Expected %@ info in the details", petName]];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

-(IAThenResult*)benjisInformationsAreDisplayedInTheDetails {
    return [self verifyPetDetailInformation:@"Benji"];
}

-(IAThenResult*)fidosInformationsAreDisplayedInTheDetails {
    return [self verifyPetDetailInformation:@"Fido"];
}

-(IAThenResult*)specialPriceAndTagAreNotDisplayed {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator detailViewOperator];
    
    IAViewOperator* specialLabel = [detailOperator searchForViewWithTag:1 toDepth:0];
    IAViewOperator* specialPrice = [detailOperator searchForViewWithTag:2 toDepth:0];
    IAViewOperator* specialDollarSign = [detailOperator searchForViewWithTag:3 toDepth:0];
    IAViewOperator* specialStarImage = [detailOperator searchForViewWithTag:4 toDepth:0];
    IAViewOperator* specialPct = [detailOperator searchForViewWithTag:5 toDepth:0];
    IAViewOperator* specialPctLabel = [detailOperator searchForViewWithTag:6 toDepth:0];
    
    if ( ![specialLabel isHidden] || ![specialPrice isHidden] || ![specialDollarSign isHidden] || ![specialStarImage isHidden] || ![specialPct isHidden] || ![specialPctLabel isHidden] ) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected special price and tag to be hidden"];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

-(IAThenResult*)specialPriceAndTagAreDisplayed {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator detailViewOperator];
    
    IAViewOperator* specialLabel = [detailOperator searchForViewWithTag:1 toDepth:0];
    IAViewOperator* specialPrice = [detailOperator searchForViewWithTag:2 toDepth:0];
    IAViewOperator* specialDollarSign = [detailOperator searchForViewWithTag:3 toDepth:0];
    IAViewOperator* specialStarImage = [detailOperator searchForViewWithTag:4 toDepth:0];
    IAViewOperator* specialPct = [detailOperator searchForViewWithTag:5 toDepth:0];
    IAViewOperator* specialPctLabel = [detailOperator searchForViewWithTag:6 toDepth:0];
    
    if ( [specialLabel isHidden] || [specialPrice isHidden] || [specialDollarSign isHidden] || [specialStarImage isHidden] || [specialPct isHidden] || [specialPctLabel isHidden] ) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected special price and tag to be visible"];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

@end
