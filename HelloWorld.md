IMPORTANT : THIS TUTORIAL IS CURRENTLY UNDER CONSTRUCTION - DO NOT USE YET!!!

In this tutorial, we will build a new application to show you how to get started from scratch.  If you have experience with Objective-C and iOS development, you can skip directly to the FirstTest wiki page that will show you how to add acceptance tests to an existing project.

<h2> Our requirements </h2>
We'll be building a very simple Hello World application.

Let's say we would like to have the following features :

<b><i>Feature 1: Say Hello</i></b>
  * In order to show you how to setup an iAccept project and test the initial state of the application in the tutorial
  * as your guide
  * I want the application to display an Hello World! message at startup

<b><i>Feature 2: Say Goodbye</i></b>
  * In order to be able to show you how to test an action on the application and validate the results in the tutorial
  * as your guide
  * I want the application to display Goodbye when the talk button is touched

<b><i>Feature 3: Say I am Back</i></b>
  * In order to be able to show you how to refactor test code and introduce how you can use a specific syntax to pass arguments to your fixtures in the tutorial
  * as your guide
  * I want the application to display I am back when the talk button is touched while displaying Goodbye

In ATDD (Acceptance tests driven development), we want to first define the acceptance criteria of any functionality we are going to be building. The goal is to provide an unambiguous definition of the requirements to the development team so they know exactly what they need to do in the form of executable acceptance tests.

As a team, we've defined our iAccept acceptance test scenarios for these features :

<b><i>Scenario 1 :  Say hello</i></b>
  * Given I started the application
  * Then displayed message is Hello World

<b><i>Scenario 2 :  Say goodbye</i></b>
  * Given I started the application
  * When I touch the talk button
  * Then displayed message is Goodbye

<b><i>Scenario 3 :  Say I am back</i></b>
  * Given the Goodbye message is displayed
  * When I touch the talk button
  * Then displayed message is I am back


<h2> First, let's setup our project environment... </h2>

Before we start, you must have Xcode installed on your mac.  This tutorial is done with Xcode 4.3.  We assume that you use ARC (automatic reference counting) too.

Here we go!

<h3>Step 1 : Creating the Helloworld project </h3>

Step 1.1 : <i>Open Xcode and click on "Create a new Xcode project".</i>

![http://iaccept.googlecode.com/svn/wiki/images/helloworld1.png](http://iaccept.googlecode.com/svn/wiki/images/helloworld1.png)

Step 1.2 : <i>Select iOS Application -> Single View Application.</i>

![http://iaccept.googlecode.com/svn/wiki/images/helloworld2.png](http://iaccept.googlecode.com/svn/wiki/images/helloworld2.png)

Step 1.3 : <i>Click next and enter your Application details.</i>

![http://iaccept.googlecode.com/svn/wiki/images/helloworld3.png](http://iaccept.googlecode.com/svn/wiki/images/helloworld3.png)

Step 1.4 : <i>Choose the location of your project and click Create.</i>

![http://iaccept.googlecode.com/svn/wiki/images/helloworld4.png](http://iaccept.googlecode.com/svn/wiki/images/helloworld4.png)

Step 1.5 : We now have a new single view project.

![http://iaccept.googlecode.com/svn/wiki/images/helloworld5.png](http://iaccept.googlecode.com/svn/wiki/images/helloworld5.png)

<h3>Step 2 : Creating a target to hold our acceptance tests </h3>
By putting the tests in a different target, we make it easier to isolate them so they wont be embedded in our application. We will be able to ship it without any dependency to the test framework.

Step 2.1 :<i> At the bottom of the screen, click on the Add Target button.  You must be in the project settings.</i>

![http://iaccept.googlecode.com/svn/wiki/images/helloworld6.png](http://iaccept.googlecode.com/svn/wiki/images/helloworld6.png)

You will then see the template screen.  Choose Empty Application.

![http://iaccept.googlecode.com/svn/wiki/images/helloworld7.png](http://iaccept.googlecode.com/svn/wiki/images/helloworld7.png)

Step 2.2 : <i>Click next and enter the new target's details.  I like to use the name of my application prefixed with "at" standing for "acceptance tests". </i>

![http://iaccept.googlecode.com/svn/wiki/images/helloworld8.png](http://iaccept.googlecode.com/svn/wiki/images/helloworld8.png)

Step 2.3: <i>Click Finish.</i> We now have our test taget.  To be able to use iAccept, we must link the iAccept framework with our target.  Go in the atHelloWorld target settings, and click the summary tab.  Scroll down until you see the "Link Frameworks and Libraries" section.

![http://iaccept.googlecode.com/svn/wiki/images/helloworld9.png](http://iaccept.googlecode.com/svn/wiki/images/helloworld9.png)

Step 2.4: <i>Click the + sign and the bottom of the section and thne click the Add Other... button.</i>

![http://iaccept.googlecode.com/svn/wiki/images/helloworld10.png](http://iaccept.googlecode.com/svn/wiki/images/helloworld10.png)

Step 2.5: <i>Navigate to the location of the iAccept framework you downloaded from the Downloads section of this site and select the unzipped framework.  Click Open.</i>

![http://iaccept.googlecode.com/svn/wiki/images/helloworld11.png](http://iaccept.googlecode.com/svn/wiki/images/helloworld11.png)

Step 2.6: <i>You can now see the iAccept framework in the list.</i>

![http://iaccept.googlecode.com/svn/wiki/images/helloworld12.png](http://iaccept.googlecode.com/svn/wiki/images/helloworld12.png)

Step 2.7: <i>iAccept has a dependency on the MapKit framework from the iOS sdk.  You must add this dependency by clicking the + button then add the MapKit framework under IOS 5.0.</i>

![http://iaccept.googlecode.com/svn/wiki/images/helloworld13.png](http://iaccept.googlecode.com/svn/wiki/images/helloworld13.png)

Step 2.8: <i>Your linked frameworks list should look like this:</i>

![http://iaccept.googlecode.com/svn/wiki/images/helloworld14.png](http://iaccept.googlecode.com/svn/wiki/images/helloworld14.png)

Step 2.9 : To test HelloWorld application, we need to add its files in atHelloWorld target.
Under "Compile Sources", you add the files ETAppDelegate.m and ETViewController.m.
Under "Copy Bundle Resources" you add ETViewController.xib by clicking on the + button at the end of each section.  After doing so, it should look like this:

![http://iaccept.googlecode.com/svn/wiki/images/helloworld17.png](http://iaccept.googlecode.com/svn/wiki/images/helloworld17.png)

Step 2.10: <i>Open the atHelloWorld target in the tree in the left pane of Xcode and delete the files ETAppDelegate.h and ETAppDelegate.m.  Sinc atHelloWorld is the test target, we dont need those files.</i>

![http://iaccept.googlecode.com/svn/wiki/images/helloworld16.png](http://iaccept.googlecode.com/svn/wiki/images/helloworld16.png)

Step 2.11: To finish the setup, go in the main.m file of atHelloWorld target.

![http://iaccept.googlecode.com/svn/wiki/images/helloworld15.png](http://iaccept.googlecode.com/svn/wiki/images/helloworld15.png)

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

<h3>Step 3 : Writing the acceptance tests first !!! </h3>

We're all setup and our team has come with some test scenarios . How do we turn that into an executable specification?

Step 3.1: <i></i>

<h2> Writing the code for US1 : Say Hello </h2>

With iAccept, you write the executable specification in a test class.  Each test class contains the scenarios for a view.   By organizing the tests this way, it is easy and fast to find tests and to know where to put them.

We create a new class named <i>HelloWorldScenarios</i>.  To stay organized, we will create it in a group named scenarios.

To create the group, right click on atHelloWorld tree item in the left panel of Xcode and select <i>New Group</i>.  You can then rename it to <i>scenario</i>.

Right click on you scenario group and select <i>New File</i>.  Choose iOS -> Cocoa Touch -> Objective-C class

![http://iaccept.googlecode.com/svn/wiki/images/helloworld19.png](http://iaccept.googlecode.com/svn/wiki/images/helloworld19.png)

Click <i>Next</i> and give you new class the name <i>HelloWorldScenarios</i>.

![http://iaccept.googlecode.com/svn/wiki/images/helloworld20.png](http://iaccept.googlecode.com/svn/wiki/images/helloworld20.png)

Then, choose where you will save your new class, the default location is fine.  Be sure to use your <i>scenarios</i> group and to select only your atHelloWorld target.

![http://iaccept.googlecode.com/svn/wiki/images/helloworld21.png](http://iaccept.googlecode.com/svn/wiki/images/helloworld21.png)

Click <i>Create</i>.

You can now see your new class files undre your <i>scenarios</i> group.  The file HelloWorldScenarios.h is the header file.  Since our class will not be used by another class directly, we wont add a definition for our scenarios in this file.  The only thing needed is to add the parent class from iAccept. All our scenarios are going to be in the file HelloWorldScenarios.h.

![http://iaccept.googlecode.com/svn/wiki/images/helloworld22.png](http://iaccept.googlecode.com/svn/wiki/images/helloworld22.png)

Now we will write our first scenario.  We need to import the iAccept parent class for all scenario suite <i>IABaseScenarioSuite</i>.  The header file should look like this:

```
#import <Foundation/Foundation.h>
#import <Framework-iAccept/IABaseScenarioSuite.h>

@interface HelloWorldScenarios : IABaseScenarioSuite

@end
```

In our implementation file we will add a method beginning with the keyword <i>scenario</i>.  This keyword tells iAccept that the method is a scenario and it needs to execute it.

```
#import "HelloWorldScenarios.h"

@implementation HelloWorldScenarios

-(void)scenarioSayHello {
    IAGiven(i started the application);
    IAThen(displayed message is Hello World);
}

@end
```

The next thing needed is a fixture.  A fixture is where you write the code to do what the scenario step mandate.  For each iAccept project (target) you need a default fixture.  You identify a default fixture with a protocol named <i>IADefaultAppFixture</i>.

To stay organized, we create a group named <i>fixtures</i>.

In that group, we create a new Objective-C class named <i>HelloWorldFixture</i>.

In the header file, we extend the class <i>IABaseFixture</i> has this parent will give us services and we add the protocol <i>IADefaultAppFixture</i> to identify it has our default fixture.

The code should look like this:

```
#import <Foundation/Foundation.h>
#import <Framework-iAccept/IABaseFixture.h>
#import <Framework-iAccept/IADefaultAppFixture.h>

@interface HelloWorldFixture : IABaseFixture<IADefaultAppFixture>

@end
```

Next step is to write the actual method that will implement our test.  Each scenario statement (IAGiven, IAWhen and IAThen) will call a method our fixture.  iAccept will concatenate the words of the statement with camel-casing, search of the method and then execute it.

For example, the statement `IAGiven(i started the application);` will try to call a method called `-(void)iStartedTheApplication`.


The final implementation of this method will look like this:

```
#import "HelloWorldFixture.h"
#import <Framework-iAccept/IAViewOperator.h>
#import <Framework-iAccept/IALabelOperator.h>

NSString * const STARTUP_MESSAGE = @"Hello World!";

@implementation HelloWorldFixture

- (void)resetMessage:(IALabelOperator *)messageLabel {
    NSString* messageText = [messageLabel text];
    
    if (![messageText isEqualToString:STARTUP_MESSAGE]) {
        [messageLabel setText:STARTUP_MESSAGE];
    }
}

-(void)iStartedTheApplication {
    IAViewOperator* helloWorldViewOperator = [IAViewOperator viewOperatorForAppDelegateRootView:[self appDelegate]];

    IALabelOperator* messageLabel = (IALabelOperator*)[helloWorldViewOperator searchForViewWithTag:1];
    
    [self resetMessage:messageLabel];
}

@end
```

The first line of method `-(void)iStartedTheApplication`, is creating a <i>IAViewOperator</i> with the root <i>UIView</i> of our application.

Operators are used to do things on views (buttons, tables, labels...).  All view operators have a search capability to search for subviews.

In our example's second line, we use the <i>helloWorldViewOperator</i> to search for a subview identified by the tag 1.  In this scenario, we know that we have a one level hierarchy, so there is no possibility of conflict.  If we had a deeper hierarchy, we could have used the <i>toDepth:(int)depth</i> parameter. i.e. `[helloWorldViewOperator searchForViewWithTag:1 toDepth:1]`

Now that we have an handle on our future message label, we can reset its value so we begin the scenario with a known state.  This is what the method <i>resetMessage</i> does.

The second statement is verifying if the application starts with the message <i>Hello World!</i> in the message label.  Has with the IAGiven statement, we will create a method named <i>displayedMessageIsHelloWorld</i> derived from the sentence.

We will use the same operators has in the <i>iStartedTheApplication</i> method.

Here is the new code :

```
#import "HelloWorldFixture.h"
#import <Framework-iAccept/IAViewOperator.h>
#import <Framework-iAccept/IALabelOperator.h>
#import <Framework-iAccept/IAThenResult.h>

NSString * const STARTUP_MESSAGE = @"Hello World";

@implementation HelloWorldFixture

- (void)resetMessage:(IALabelOperator *)messageLabel {
    NSString* messageText = [messageLabel text];
    
    if (![messageText isEqualToString:STARTUP_MESSAGE]) {
        [messageLabel setText:STARTUP_MESSAGE];
    }
}

- (IALabelOperator *)findMessageLabel {
    IAViewOperator* helloWorldViewOperator = [IAViewOperator viewOperatorForAppDelegateRootView:[self appDelegate]];
    
    IALabelOperator* messageLabel = (IALabelOperator*)[helloWorldViewOperator searchForViewWithTag:1 toDepth:0];
    return messageLabel;
}

-(void)iStartedTheApplication {
    IALabelOperator *messageLabel = [self findMessageLabel];
    [self resetMessage:messageLabel];
}

-(IAThenResult*)displayedMessageIsHelloWorld {
    IALabelOperator *messageLabel = [self findMessageLabel];
    
    if (messageLabel && [[messageLabel text] isEqualToString:STARTUP_MESSAGE]) {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    } else {
        return [IAThenResult makeThenStatementConditionNotMetValue:[NSString stringWithFormat:@"Expected message to be '%@', but was '%@'", STARTUP_MESSAGE, [messageLabel text]]];
    }
}

@end
```

Our new method `-(IAThenResult*)displayedMessageIsHelloWorld` has a return value.  The <i>IAThenResult</i> class tells iAccept the state of the verification done.  If a `[IAThenResult makeThenStatementConditionMetReturnValue]` is returned, then iAccept will continue with the next scenario.  If `[IAThenResult makeThenStatementConditionNotMetValue...]` is returned, then iAccept will recall <i>displayedMessageIsHelloWorld</i> until the timeout is reached.

In this example, we return a positive answer if the label operator is not nil (meaning it was found) and the label's text is "Hello World".

If that is not the case, then we return a negative answer with a message describing the reason.

If we execute our scenario by clicking Run on our atHelloWorld target in Xcode, we will see in the console a failure.

```
2012-02-24 10:35:49.326 atHelloWorld[604:11603] TEST_FAILED [test=scenarioSayHello, errorMessage=[HelloWorldFixture displayedMessageIsHelloWorld] test timed out (30.000 seconds) [Expected message to be 'Hello World', but was '(null)']: at line 15, time=31.019733sec]
2012-02-24 10:35:49.328 atHelloWorld[604:11603] TEST_SUITE_FAILED [suite=HelloWorldScenarios, tests=1, passed=0, failed=1 time=31.019733sec]
2012-02-24 10:35:49.329 atHelloWorld[604:11603]  
2012-02-24 10:35:49.331 atHelloWorld[604:11603] TESTS_FAILED [suites=1, tests=1, tests passed=0, tests failed=1, statements=2, time=31.019733sec]
```

This is good because we did not implement our application yet!  And when we'll do it, we will know it's working.

Now go in the HelloWorld project's <i>ETViewController.xib</i> and add a label.

![http://iaccept.googlecode.com/svn/wiki/images/helloworld23.png](http://iaccept.googlecode.com/svn/wiki/images/helloworld23.png)

In the label's properties, put 1 in the tag attribute. It is our search hook.

![http://iaccept.googlecode.com/svn/wiki/images/helloworld26.png](http://iaccept.googlecode.com/svn/wiki/images/helloworld26.png)

You then need a reference of the label in your view controller, you do this by dragging the New Referencing Outlet link in your view controller header like this :

![http://iaccept.googlecode.com/svn/wiki/images/helloworld24.png](http://iaccept.googlecode.com/svn/wiki/images/helloworld24.png)

then you give your outlet a name.

![http://iaccept.googlecode.com/svn/wiki/images/helloworld25.png](http://iaccept.googlecode.com/svn/wiki/images/helloworld25.png)

Your<i>ETViewController.h</i> will look like this :

```
#import <UIKit/UIKit.h>

@interface ETViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@end
```

In the class <i>ETViewController.m</i> edit method <i>viewDidLoad</i> like this:

```
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [messageLabel setText:@"Hello World"];
}
```

Execute atHelloWorld again, your scenario is now a success!

```
2012-02-24 13:22:13.221 atHelloWorld[439:11603] TEST_SUITE_PASSED [suite=HelloWorldScenarios, tests=1, passed=1, failed=0 time=1.060791sec]
2012-02-24 13:22:13.222 atHelloWorld[439:11603]  
2012-02-24 13:22:13.223 atHelloWorld[439:11603] TESTS_PASSED [suites=1, tests=1, tests passed=1, tests failed=0, statements=2, time=1.060791sec]
```

Good job, our first scenario is a success and from now on we are sure this functionality will always work.

<h2> Writing the code for US2 : Say Goodbye </h2>

We continue with our use case 2 by adding a new method named <i>scenarioSayGoodBye</i> in our <i>HelloWorldScenarios</i> class that will specify this second scenario.

```
#import "HelloWorldScenarios.h"

@implementation HelloWorldScenarios

-(void)scenarioSayHello {
    IAGiven(i started the application);
    IAThen(displayed message is Hello World);
}

-(void)scenarioSayGoodbye {
    IAGiven(i started the application);
    IAWhen(i touch the talk button);
    IAThen(displayed message is Goodbye);
}

@end
```

The new statement here is IAWhen.  IAWhen serves has an action statement.  This is the one used when we want to do an interaction with our app like touching a button or scrolling a list.

Like the IAGiven and the IAThen statements, ITWhen will call a method who's name is derived from the sentence.  Her this method is <i>iTouchTheTalkButton</i>.

In our <i>HelloWorldFixture</i> we add the method.  The implementation looks like this :

```
#import "HelloWorldFixture.h"
#import <Framework-iAccept/IAViewOperator.h>
#import <Framework-iAccept/IALabelOperator.h>
#import <Framework-iAccept/IAThenResult.h>
#import <Framework-iAccept/IAButtonOperator.h>


NSString * const STARTUP_MESSAGE = @"Hello World";

@implementation HelloWorldFixture

- (void)resetMessage:(IALabelOperator *)messageLabel {
    NSString* messageText = [messageLabel text];
    
    if (![messageText isEqualToString:STARTUP_MESSAGE]) {
        [messageLabel setText:STARTUP_MESSAGE];
    }
}

- (IALabelOperator *)findMessageLabel {
    IAViewOperator* helloWorldViewOperator = [IAViewOperator viewOperatorForAppDelegateRootView:[self appDelegate]];
    
    IALabelOperator* messageLabel = (IALabelOperator*)[helloWorldViewOperator searchForViewWithTag:1 toDepth:0];
    return messageLabel;
}

-(void)iStartedTheApplication {
    IALabelOperator *messageLabel = [self findMessageLabel];
    [self resetMessage:messageLabel];
}

-(IAThenResult*)displayedMessageIsHelloWorld {
    IALabelOperator *messageLabel = [self findMessageLabel];
    
    if (messageLabel && [[messageLabel text] isEqualToString:STARTUP_MESSAGE]) {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    } else {
        return [IAThenResult makeThenStatementConditionNotMetValue:[NSString stringWithFormat:@"Expected message to be '%@', but was '%@'", STARTUP_MESSAGE, [messageLabel text]]];
    }
}

-(void)iTouchTheTalkButton {
    IAViewOperator* helloWorldViewOperator = [IAViewOperator viewOperatorForAppDelegateRootView:[self appDelegate]];
    
    IAButtonOperator* talkButton = [helloWorldViewOperator searchForButtonWithText:@"Talk" forState:UIControlStateNormal];
    
    [talkButton touch];
}

@end
```

The first line of the method is the now classic root view operator.  From our root view operator, we search for a button with the text "Talk" for the normal state of that button.

Finally, we issue the touch action on the button.

The last statement is the verification and we implement it with an IAThen.  Since we are good programmers, we can smell a duplication between the preceding `IAThen(displayed message is Hello World);` and our new `IAThen(displayed message is Goodbye);`.

Wouldn't it be nice to have a parameter for the label's text?  Ok then, lets do it.

We can refactor our <i>HelloWorldFixture</i> to introduce the parameter on method <i>displayedMessageIsHelloWorld</i> and iAccept will do the rest.

```
#import "HelloWorldFixture.h"
#import <Framework-iAccept/IAViewOperator.h>
#import <Framework-iAccept/IALabelOperator.h>
#import <Framework-iAccept/IAThenResult.h>
#import <Framework-iAccept/IAButtonOperator.h>

NSString * const STARTUP_MESSAGE = @"Hello World";

@implementation HelloWorldFixture

- (void)resetMessage:(IALabelOperator *)messageLabel {
    NSString* messageText = [messageLabel text];
    
    if (![messageText isEqualToString:STARTUP_MESSAGE]) {
        [messageLabel setText:STARTUP_MESSAGE];
    }
}

- (IALabelOperator *)findMessageLabel {
    IAViewOperator* helloWorldViewOperator = [IAViewOperator viewOperatorForAppDelegateRootView:[self appDelegate]];
    
    IALabelOperator* messageLabel = (IALabelOperator*)[helloWorldViewOperator searchForViewWithTag:1 toDepth:0];
    return messageLabel;
}

-(void)iStartedTheApplication {
    IALabelOperator *messageLabel = [self findMessageLabel];
    [self resetMessage:messageLabel];
}

-(IAThenResult*)displayedMessageIs:(NSString*)message {
    IALabelOperator *messageLabel = [self findMessageLabel];
    
    if (messageLabel && [[messageLabel text] isEqualToString:message]) {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    } else {
        return [IAThenResult makeThenStatementConditionNotMetValue:[NSString stringWithFormat:@"Expected message to be '%@', but was '%@'", message, [messageLabel text]]];
    }
}

-(void)iTouchTheTalkButton {
    IAViewOperator* helloWorldViewOperator = [IAViewOperator viewOperatorForAppDelegateRootView:[self appDelegate]];
    
    IAButtonOperator* talkButton = [helloWorldViewOperator searchForButtonWithText:@"Talk" forState:UIControlStateNormal];
    
    [talkButton touch];
}

@end
```


Now is the time to implement this scenario in our app.

First, go in the file <i>ETViewController.xib</i> and add a button.  Then put "Talk" in the <i>Title</i> property.

![http://iaccept.googlecode.com/svn/wiki/images/helloworld27.png](http://iaccept.googlecode.com/svn/wiki/images/helloworld27.png)

We now need to add an event handler for when the button is touched.  In the button's connections inspector, drag the <i>Touch Up Inside</i> event into the <i>ETViewController.h</i> file.

![http://iaccept.googlecode.com/svn/wiki/images/helloworld28.png](http://iaccept.googlecode.com/svn/wiki/images/helloworld28.png)

Give a name for your event handler method.  I named it <i>talkButtonTouched</i>.

![http://iaccept.googlecode.com/svn/wiki/images/helloworld29.png](http://iaccept.googlecode.com/svn/wiki/images/helloworld29.png)

The code for <i>ETViewController.h</i> is now :

```
#import <UIKit/UIKit.h>

@interface ETViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
- (IBAction)talkButtonTouched:(id)sender;
@end
```

In the file <i>ETViewController.m</i>, we add the logic that handle the touch of the Talk button.

```
#import "ETViewController.h"

@interface ETViewController ()

@end

@implementation ETViewController
@synthesize messageLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [messageLabel setText:@"Hello World"];
}

- (void)viewDidUnload
{
    [self setMessageLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (IBAction)talkButtonTouched:(id)sender {
    if ([messageLabel.text isEqualToString:@"Hello World"]) {
        messageLabel.text = @"Goodbye";
    }
}
@end
```

The generated method `- (IBAction)talkButtonTouched:(id)sender` contains the event handling code.  Here, we change the label text for "Goodbye" if it was "Hello World".

Run the atHelloWorld target again and voilà!

```
2012-02-24 14:19:40.070 atHelloWorld[668:11603] TESTS_STARTED
2012-02-24 14:19:40.073 atHelloWorld[668:11603]  
2012-02-24 14:19:41.074 atHelloWorld[668:11603] TEST_SUITE_STARTED [suite=HelloWorldScenarios]
2012-02-24 14:19:41.076 atHelloWorld[668:11603] recordThenStatement displayed message is Hello World
2012-02-24 14:19:41.178 atHelloWorld[668:11603] Running i started the application at line 14
2012-02-24 14:19:41.215 atHelloWorld[668:11603] parseSelectorText: selectorSourceTextStartWordIndex =0, selectorSourceTextEndWordIndex=3
2012-02-24 14:19:41.217 atHelloWorld[668:11603] parseSelectorText: selectorSourceText =i started the application, selectorParsedText=i started the application
2012-02-24 14:19:41.219 atHelloWorld[668:11603] IASelectorMatcher selectorText = i started the application, methodName=iStartedTheApplication
2012-02-24 14:19:41.219 atHelloWorld[668:11603] i started the application Done
2012-02-24 14:19:41.621 atHelloWorld[668:11603] Running displayed message is Hello World at line 15
2012-02-24 14:19:41.724 atHelloWorld[668:11603] parseSelectorText: selectorSourceTextStartWordIndex =0, selectorSourceTextEndWordIndex=4
2012-02-24 14:19:41.727 atHelloWorld[668:11603] parseSelectorText: selectorSourceText =displayed message is Hello World, selectorParsedText=displayed message is Hello World
2012-02-24 14:19:41.728 atHelloWorld[668:11603] ParsedStatement = IAParsedStatement[textToParse=displayed message is Hello World,fixtureSourceText=(null),fixtureParsedText=(null),selectorSourceText=displayed message is Hello World,selectorParsedText=displayed message is Hello World,selectorName=displayedMessageIsHelloWorld]
2012-02-24 14:19:41.730 atHelloWorld[668:11603] IASelectorMatcher selectorText = displayed message is Hello World, methodName=displayedMessageIs:
2012-02-24 14:19:41.732 atHelloWorld[668:11603] IASelectorMatcher found argument = Hello World
2012-02-24 14:19:41.733 atHelloWorld[668:11603] displayed message is Hello World Done
2012-02-24 14:19:42.135 atHelloWorld[668:11603] TEST_PASSED [test=scenarioSayHello, statements=2, time=1.057849sec]
2012-02-24 14:19:42.137 atHelloWorld[668:11603] recordThenStatement displayed message is Goodbye
2012-02-24 14:19:42.239 atHelloWorld[668:11603] Running i started the application at line 19
2012-02-24 14:19:42.242 atHelloWorld[668:11603] parseSelectorText: selectorSourceTextStartWordIndex =0, selectorSourceTextEndWordIndex=3
2012-02-24 14:19:42.243 atHelloWorld[668:11603] parseSelectorText: selectorSourceText =i started the application, selectorParsedText=i started the application
2012-02-24 14:19:42.246 atHelloWorld[668:11603] IASelectorMatcher selectorText = i started the application, methodName=iStartedTheApplication
2012-02-24 14:19:42.247 atHelloWorld[668:11603] i started the application Done
2012-02-24 14:19:42.650 atHelloWorld[668:11603] Running i touch the talk button at line 20
2012-02-24 14:19:42.654 atHelloWorld[668:11603] IASelectorMatcher selectorText = i touch the talk button, methodName=iTouchTheTalkButton
2012-02-24 14:19:42.656 atHelloWorld[668:11603] i touch the talk button Done
2012-02-24 14:19:43.058 atHelloWorld[668:11603] Running displayed message is Goodbye at line 21
2012-02-24 14:19:43.161 atHelloWorld[668:11603] parseSelectorText: selectorSourceTextStartWordIndex =0, selectorSourceTextEndWordIndex=3
2012-02-24 14:19:43.164 atHelloWorld[668:11603] parseSelectorText: selectorSourceText =displayed message is Goodbye, selectorParsedText=displayed message is Goodbye
2012-02-24 14:19:43.165 atHelloWorld[668:11603] ParsedStatement = IAParsedStatement[textToParse=displayed message is Goodbye,fixtureSourceText=(null),fixtureParsedText=(null),selectorSourceText=displayed message is Goodbye,selectorParsedText=displayed message is Goodbye,selectorName=displayedMessageIsGoodbye]
2012-02-24 14:19:43.167 atHelloWorld[668:11603] IASelectorMatcher selectorText = displayed message is Goodbye, methodName=displayedMessageIs:
2012-02-24 14:19:43.169 atHelloWorld[668:11603] IASelectorMatcher found argument = Goodbye
2012-02-24 14:19:43.170 atHelloWorld[668:11603] displayed message is Goodbye Done
2012-02-24 14:19:43.571 atHelloWorld[668:11603] TEST_PASSED [test=scenarioSayGoodbye, statements=3, time=1.432797sec]
2012-02-24 14:19:43.573 atHelloWorld[668:11603] TEST_SUITE_PASSED [suite=HelloWorldScenarios, tests=2, passed=2, failed=0 time=2.490646sec]
2012-02-24 14:19:43.574 atHelloWorld[668:11603]  
2012-02-24 14:19:43.576 atHelloWorld[668:11603] TESTS_PASSED [suites=1, tests=2, tests passed=2, tests failed=0, statements=5, time=2.490646sec]
2012-02-24 14:19:43.576 atHelloWorld[668:11603]  
```

<h2> Writing the code for US3 : Say i am back </h2>

Let's go in our <i>HelloWorldScenarios</i> suite and add our last scenario.

```
#import "HelloWorldScenarios.h"

@implementation HelloWorldScenarios

-(void)scenarioSayHello {
    IAGiven(i started the application);
    IAThen(displayed message is Hello World);
}

-(void)scenarioSayGoodbye {
    IAGiven(i started the application);
    IAWhen(i touch the talk button);
    IAThen(displayed message is Goodbye);
}

-(void)scenarioSayIAmBack {
    IAGiven(the Goodbye message is displayed);
    IAWhen(i touch the talk button);
    IAThen(displayed message is I am back);
}

@end
```

IAGiven statement is used to set up the state of the application before a scenario execution.  Here we state that the message text is "Goodbye".  It will be the responsibility of the fixture's method <i>theGoodbyeMessageIsDisplayed</i> to set that state.

So let's implement that in our fixture :

```
#import "HelloWorldFixture.h"
#import <Framework-iAccept/IAViewOperator.h>
#import <Framework-iAccept/IALabelOperator.h>
#import <Framework-iAccept/IAThenResult.h>
#import <Framework-iAccept/IAButtonOperator.h>

NSString * const STARTUP_MESSAGE = @"Hello World";

@implementation HelloWorldFixture

- (void)resetMessage:(IALabelOperator *)messageLabel {
    NSString* messageText = [messageLabel text];
    
    if (![messageText isEqualToString:STARTUP_MESSAGE]) {
        [messageLabel setText:STARTUP_MESSAGE];
    }
}

- (IALabelOperator *)findMessageLabel {
    IAViewOperator* helloWorldViewOperator = [IAViewOperator viewOperatorForAppDelegateRootView:[self appDelegate]];
    
    IALabelOperator* messageLabel = (IALabelOperator*)[helloWorldViewOperator searchForViewWithTag:1 toDepth:0];
    return messageLabel;
}

-(void)iStartedTheApplication {
    IALabelOperator *messageLabel = [self findMessageLabel];
    [self resetMessage:messageLabel];
}

-(IAThenResult*)displayedMessageIs:(NSString*)message {
    IALabelOperator *messageLabel = [self findMessageLabel];
    
    if (messageLabel && [[messageLabel text] isEqualToString:message]) {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    } else {
        return [IAThenResult makeThenStatementConditionNotMetValue:[NSString stringWithFormat:@"Expected message to be '%@', but was '%@'", message, [messageLabel text]]];
    }
}

-(void)iTouchTheTalkButton {
    IAViewOperator* helloWorldViewOperator = [IAViewOperator viewOperatorForAppDelegateRootView:[self appDelegate]];
    
    IAButtonOperator* talkButton = [helloWorldViewOperator searchForButtonWithText:@"Talk" forState:UIControlStateNormal];
    
    [talkButton touch];
}

-(void)theGoodbyeMessageIsDisplayed {
    IALabelOperator *messageLabel = [self findMessageLabel];
    messageLabel.text = @"Goodbye";
}

@end
```

We are done with our scenario, we can go in our app to implement it.

In <i>ETViewController.m</i> we add the logic for "I am back" in the button touch event handler.

```
#import "ETViewController.h"

@interface ETViewController ()

@end

@implementation ETViewController
@synthesize messageLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [messageLabel setText:@"Hello World"];
}

- (void)viewDidUnload
{
    [self setMessageLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (IBAction)talkButtonTouched:(id)sender {
    if ([messageLabel.text isEqualToString:@"Hello World"]) {
        messageLabel.text = @"Goodbye";
    } else if ([messageLabel.text isEqualToString:@"Goodbye"]) {
        messageLabel.text = @"I am back";
    }
}
@end
```

Ok, I think we are pertty much done,  let's run atHelloWorld!

```
2012-02-24 14:31:42.851 atHelloWorld[718:11603] TESTS_STARTED
2012-02-24 14:31:42.854 atHelloWorld[718:11603]  
2012-02-24 14:31:43.855 atHelloWorld[718:11603] TEST_SUITE_STARTED [suite=HelloWorldScenarios]
2012-02-24 14:31:43.856 atHelloWorld[718:11603] recordThenStatement displayed message is Hello World
2012-02-24 14:31:43.957 atHelloWorld[718:11603] Running i started the application at line 14
2012-02-24 14:31:43.983 atHelloWorld[718:11603] parseSelectorText: selectorSourceTextStartWordIndex =0, selectorSourceTextEndWordIndex=3
2012-02-24 14:31:43.984 atHelloWorld[718:11603] parseSelectorText: selectorSourceText =i started the application, selectorParsedText=i started the application
2012-02-24 14:31:43.985 atHelloWorld[718:11603] IASelectorMatcher selectorText = i started the application, methodName=iStartedTheApplication
2012-02-24 14:31:43.986 atHelloWorld[718:11603] i started the application Done
2012-02-24 14:31:44.386 atHelloWorld[718:11603] Running displayed message is Hello World at line 15
2012-02-24 14:31:44.489 atHelloWorld[718:11603] parseSelectorText: selectorSourceTextStartWordIndex =0, selectorSourceTextEndWordIndex=4
2012-02-24 14:31:44.492 atHelloWorld[718:11603] parseSelectorText: selectorSourceText =displayed message is Hello World, selectorParsedText=displayed message is Hello World
2012-02-24 14:31:44.493 atHelloWorld[718:11603] ParsedStatement = IAParsedStatement[textToParse=displayed message is Hello World,fixtureSourceText=(null),fixtureParsedText=(null),selectorSourceText=displayed message is Hello World,selectorParsedText=displayed message is Hello World,selectorName=displayedMessageIsHelloWorld]
2012-02-24 14:31:44.495 atHelloWorld[718:11603] IASelectorMatcher selectorText = displayed message is Hello World, methodName=displayedMessageIs:
2012-02-24 14:31:44.496 atHelloWorld[718:11603] IASelectorMatcher found argument = Hello World
2012-02-24 14:31:44.498 atHelloWorld[718:11603] displayed message is Hello World Done
2012-02-24 14:31:44.899 atHelloWorld[718:11603] TEST_PASSED [test=scenarioSayHello, statements=2, time=1.043193sec]
2012-02-24 14:31:44.900 atHelloWorld[718:11603] recordThenStatement displayed message is Goodbye
2012-02-24 14:31:45.001 atHelloWorld[718:11603] Running i started the application at line 19
2012-02-24 14:31:45.003 atHelloWorld[718:11603] parseSelectorText: selectorSourceTextStartWordIndex =0, selectorSourceTextEndWordIndex=3
2012-02-24 14:31:45.004 atHelloWorld[718:11603] parseSelectorText: selectorSourceText =i started the application, selectorParsedText=i started the application
2012-02-24 14:31:45.006 atHelloWorld[718:11603] IASelectorMatcher selectorText = i started the application, methodName=iStartedTheApplication
2012-02-24 14:31:45.008 atHelloWorld[718:11603] i started the application Done
2012-02-24 14:31:45.410 atHelloWorld[718:11603] Running i touch the talk button at line 20
2012-02-24 14:31:45.414 atHelloWorld[718:11603] IASelectorMatcher selectorText = i touch the talk button, methodName=iTouchTheTalkButton
2012-02-24 14:31:45.416 atHelloWorld[718:11603] i touch the talk button Done
2012-02-24 14:31:45.818 atHelloWorld[718:11603] Running displayed message is Goodbye at line 21
2012-02-24 14:31:45.919 atHelloWorld[718:11603] parseSelectorText: selectorSourceTextStartWordIndex =0, selectorSourceTextEndWordIndex=3
2012-02-24 14:31:45.920 atHelloWorld[718:11603] parseSelectorText: selectorSourceText =displayed message is Goodbye, selectorParsedText=displayed message is Goodbye
2012-02-24 14:31:45.920 atHelloWorld[718:11603] ParsedStatement = IAParsedStatement[textToParse=displayed message is Goodbye,fixtureSourceText=(null),fixtureParsedText=(null),selectorSourceText=displayed message is Goodbye,selectorParsedText=displayed message is Goodbye,selectorName=displayedMessageIsGoodbye]
2012-02-24 14:31:45.921 atHelloWorld[718:11603] IASelectorMatcher selectorText = displayed message is Goodbye, methodName=displayedMessageIs:
2012-02-24 14:31:45.922 atHelloWorld[718:11603] IASelectorMatcher found argument = Goodbye
2012-02-24 14:31:45.922 atHelloWorld[718:11603] displayed message is Goodbye Done
2012-02-24 14:31:46.323 atHelloWorld[718:11603] TEST_PASSED [test=scenarioSayGoodbye, statements=3, time=1.422304sec]
2012-02-24 14:31:46.325 atHelloWorld[718:11603] recordThenStatement displayed message is I am back
2012-02-24 14:31:46.428 atHelloWorld[718:11603] Running the Goodbye message is displayed at line 25
2012-02-24 14:31:46.430 atHelloWorld[718:11603] parseSelectorText: selectorSourceTextStartWordIndex =0, selectorSourceTextEndWordIndex=4
2012-02-24 14:31:46.432 atHelloWorld[718:11603] parseSelectorText: selectorSourceText =the Goodbye message is displayed, selectorParsedText=the Goodbye message is displayed
2012-02-24 14:31:46.435 atHelloWorld[718:11603] IASelectorMatcher selectorText = the Goodbye message is displayed, methodName=theGoodbyeMessageIsDisplayed
2012-02-24 14:31:46.437 atHelloWorld[718:11603] the Goodbye message is displayed Done
2012-02-24 14:31:46.838 atHelloWorld[718:11603] Running i touch the talk button at line 26
2012-02-24 14:31:46.843 atHelloWorld[718:11603] IASelectorMatcher selectorText = i touch the talk button, methodName=iTouchTheTalkButton
2012-02-24 14:31:46.845 atHelloWorld[718:11603] i touch the talk button Done
2012-02-24 14:31:47.246 atHelloWorld[718:11603] Running displayed message is I am back at line 27
2012-02-24 14:31:47.349 atHelloWorld[718:11603] parseSelectorText: selectorSourceTextStartWordIndex =0, selectorSourceTextEndWordIndex=5
2012-02-24 14:31:47.351 atHelloWorld[718:11603] parseSelectorText: selectorSourceText =displayed message is I am back, selectorParsedText=displayed message is I am back
2012-02-24 14:31:47.352 atHelloWorld[718:11603] ParsedStatement = IAParsedStatement[textToParse=displayed message is I am back,fixtureSourceText=(null),fixtureParsedText=(null),selectorSourceText=displayed message is I am back,selectorParsedText=displayed message is I am back,selectorName=displayedMessageIsIAmBack]
2012-02-24 14:31:47.354 atHelloWorld[718:11603] IASelectorMatcher selectorText = displayed message is I am back, methodName=displayedMessageIs:
2012-02-24 14:31:47.356 atHelloWorld[718:11603] IASelectorMatcher found argument = I am back
2012-02-24 14:31:47.357 atHelloWorld[718:11603] displayed message is I am back Done
2012-02-24 14:31:47.759 atHelloWorld[718:11603] TEST_PASSED [test=scenarioSayIAmBack, statements=3, time=1.432687sec]
2012-02-24 14:31:47.762 atHelloWorld[718:11603] TEST_SUITE_PASSED [suite=HelloWorldScenarios, tests=3, passed=3, failed=0 time=3.898184sec]
2012-02-24 14:31:47.765 atHelloWorld[718:11603]  
2012-02-24 14:31:47.773 atHelloWorld[718:11603] TESTS_PASSED [suites=1, tests=3, tests passed=3, tests failed=0, statements=8, time=3.898184sec]
2012-02-24 14:31:47.782 atHelloWorld[718:11603]  
```

Great work you just finished your first ATDD journey.  Hope you enjoyed the ride!