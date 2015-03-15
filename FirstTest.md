The first thing you need to do is to launch your application under test.  To do so, you need to add some code to the main.m source file under your testing target.

> ![http://iaccept.googlecode.com/svn/wiki/images/firsttest_1.png](http://iaccept.googlecode.com/svn/wiki/images/firsttest_1.png)

Add the missing lines to your main.m file so it looks like this :

```
#import <UIKit/UIKit.h>
#import <Framework-iAccept/IARunner.h>
#import <Framework-iAccept/IADefaultRunnerExitHandler.h>
#import <Framework-iAccept/IAConfig.h>
#import "ETAppDelegate.h"

int main(int argc, char *argv[])
{
  @autoreleasepool {
        
    IARunner* runner = [[IARunner alloc]init];
    [runner addObserver:[[IADefaultRunnerExitHandler alloc] init]];
    [[IAConfig sharedInstance] setDelayBetweenTestsInSeconds:0.1];
    [[IAConfig sharedInstance] setDelayBetweenTestStatementsInSeconds:0.4];
        
    [runner runAfterDelay:1];
    return UIApplicationMain(argc, argv, nil, NSStringFromClass([ETAppDelegate class]));
  }
}
```


The IARunner is the the engine of iAccept.  It is responsible to run all the defined tests.
The observer (IADefaultRunnerExitHandler) is responsible to do a clean exit at the end of the test run.
You have then the possibility to modify the behavior of iAccept with IAConfig.
In this example we set the delay between test suite execution and the delay between each step in the test suite.

The header ETAppDelegate.h is the application delegate of the application under test.

> ![http://iaccept.googlecode.com/svn/wiki/images/firsttest_2.png](http://iaccept.googlecode.com/svn/wiki/images/firsttest_2.png)

Then, we need to tell iAccept how do get a handle on the application.  We do this by creating a default fixture class.

> ![http://iaccept.googlecode.com/svn/wiki/images/firsttest_3.png](http://iaccept.googlecode.com/svn/wiki/images/firsttest_3.png)

```
#import <Foundation/Foundation.h>
#import <Framework-iAccept/IABaseFixture.h>
#import <Framework-iAccept/IADefaultAppFixture.h>

@interface PetShopFixture : IABaseFixture<IADefaultAppFixture>

@end
```

What is special about this fixture is that it conform to the IADefaultAppFixture protocol.  This protocol only a tag to tell the Runner that if it cannot find a fixture for a specific test, it can use this one.

The IABaseFixture class is the base class of all fixtures.

We leave the implementation empty for now.

Now that we have a base fixture for our application we can write our first test definition.

```
#import <Foundation/Foundation.h>
#import <Framework-iAccept/IABaseTestSuite.h>

@interface MainNavigationViewBehaviors : IABaseTestSuite

@end
```

All test definitions are subclasses of IABaseTestSuite.

In our first test, we want to test that if we touch the promotion star button in the menu part of the split view, the promotion screen is shown on the main part of the split view.

> ![http://iaccept.googlecode.com/svn/wiki/images/firsttest_4.png](http://iaccept.googlecode.com/svn/wiki/images/firsttest_4.png)

So we write our first behavior definition with a method that begins with the word test (not unlike xUnit tests).

```
#import "MainNavigationViewBehaviors.h"

@implementation MainNavigationViewBehaviors

-(void)testOpenPromo {
    IAGiven(i start with an empty shopping cart);
    IAGiven(i launched the petshop in landscape);
    
    IAWhen(i touch the promo button on menu view);
    IAThen(the main view displays the promotions);
}

@end
```

With the first two lines, we define the prerequisites for our test.  The type IAGiven is used for this.

We want to start with an empty shopping cart and we want to be in landscape.

IAccept will remove the spaces and camel-case the words of the sentence and then search for a method with that name.  So, our first Given must be implemented has a method named "iStartWithAnEmptyShoppingCart".

By default, iAccept will search for those methods our default fixture.  So let’s go code them.


```
#import "PetShopFixture.h"

#import <Framework-iAccept/IADeviceOperator.h>
#import "ETAppDelegate.h"

@implementation PetShopFixture

-(void)iStartWithAnEmptyShoppingCart {
    ETAppDelegate*  appDeletage = [self appDelegate];
    [appDeletage emptyShoppingCart];
}

-(void)iLaunchedThePetshopInLandscape {
    [IADeviceOperator forceLandscapeOrientation];
}

@end

```

Look at the method `-(void)iStartWithAnEmptyShoppingCart`. The first thing it does is getting a reference to the application under test (AUT) and then calls a method that will clear the shopping cart.  You see that you get a lot of flexibility to play with the state of your application.

The method `-(void)iLaunchedThePetshopInLandscape` is using an operator that can interact with the device’s properties.  In this case, it’s forcing the display in landscape.

The IAWhen type, is used to do an action.  In our example, the action is to touch the button.

If you look closely  at the test sentence, you can see two sections.  The first one at the left of « on » and another one at its right.


<font color='red'>i touch the promo button</font> on <font color='red'>menu view</font>

The right part is the fixture’s method that will do the job of touching the button.
The left part is the way to tell iAccept to use another fixture than the default one.

It is important to segregate our fixtures to keep the code manageable and reusable.

So, we need to create a fixture named "MenuViewFixture" to handle our "iTouchThePromoButton" action.

```
#import <Framework-iAccept/IABaseFixture.h>

@interface MenuViewFixture : IABaseFixture

@end
```

```
#import "MenuViewFixture.h"

#import "ETAppDelegate.h"
#import "ETMasterViewController.h"
#import <Framework-iAccept/IASplitViewOperator.h>
#import <Framework-iAccept/IAViewOperator.h>
#import <Framework-iAccept/IAButtonOperator.h>

@implementation MenuViewFixture


-(void) iTouchThePromoButton {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]];

    IAViewOperator* masterViewOperator = [splitOperator masterViewOperator];
    
    IAButtonOperator* promoButton = [masterViewOperator searchForButtonWithImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];

    [promoButton touch]; 
}

@end

```

```
IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]];
```
This line is creating a split view operator.  We need it to get the master and the detail views.
```
IAViewOperator* masterViewOperator = [splitOperator masterViewOperator];
```
We retrieve the split view’s master view.  A generic view operator is returned because we do not have a specific operator for this kind of view.
```
IAButtonOperator* promoButton = [masterViewOperator searchForButtonWithImage:[UIImage imageNamed:@"star.png"]  forState:UIControlStateNormal];
```
Here, we use the master view operator as our base search view.  Every view operators has search methods to find a specific subview. In this scenario, we search for a button that has the image star.png has its image when in normal state.

Because we have a specific operator for a button view, the right operator’s type is returned.
If the button was not found, we would have get a nil object.

```
[promoButton touch];
```
Now that we have our button operator, we can issue a touch action by using the operator's touch method.

The last step of our test is to validate that the button’s touch really triggered the promotion screen to appear.

We can achieve that with the IAThen type.

<font color='green'>the</font> <font color='red'>main view</font> <font color='blue'>displays the promotions</font>

Has you can see, the IAThen type has a structure too.

In red, you have the name of the fixture that will handle the verification.

In blue, it is the method name that will handle the verification.  In the same way has in IAWhen,  the method name is a camel-case concatenation of the words.

In green you have the « the »  keyword that will be stripped, it useful only for readability.

We can now implement our MainViewFixture

```
#import <Framework-iAccept/IABaseFixture.h>

@interface MainViewFixture : IABaseFixture

@end
```

```
#import "MainViewFixture.h"

#import <Framework-iAccept/IASplitViewOperator.h>
#import <Framework-iAccept/IAViewOperator.h>
#import <Framework-iAccept/IANavigationBarOperator.h>

@implementation MainViewFixture

-(IAThenResult*) displaysThePromotions {
    NSString* title = @"Manager's Deals Of The Week!";
    
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 

    IAViewOperator* detailViewOperator = [splitOperator rootViewOfDetailViewOperator];

    IANavigationBarOperator* navBar = [detailViewOperator searchForNavigationBarWithTitle:title];
    
    if (!navBar || ![[navBar title] isEqualToString:title]) {
        return [IAThenResult makeThenStatementConditionNotMetValue:[NSString stringWithFormat:@"Expected @% displayed, but was @%.", title, [navBar title]] ];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

@end
```

In the method  `-(IAThenResult*)displaysThePromotions` we have the known split view operator that will give us the detail view operator.

```
IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 

IAViewOperator* detailViewOperator = [splitOperator rootViewOfDetailViewOperator];
```

We can now check for a navigation bar that has our screen title in the hiearchy.  If we find it, it means that our promotion screen is showing.

```
IANavigationBarOperator* navBar = [detailViewOperator searchForNavigationBarWithTitle:title];
```

To tell iAccept that our verification was positive or negative, we use the IAThenResult class.

If the verification was positive, we construct a positive IAThenResult,

```
return [IAThenResult makeThenStatementConditionMetReturnValue];
```

else we return a negative IAThenResult with a message containing the reason.

```
return [IAThenResult makeThenStatementConditionNotMetValue:[NSString stringWithFormat:@"Expected @% displayed, but was @%.", title, [navBar title]]];
```

We are done with that first test.  If you execute your target, you should see in the console that the test was successful.

You can now explore the PetShop application to see all the operators available to you and get a good feel of how to use them.