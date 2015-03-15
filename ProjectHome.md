## What is it? ##
iAccept allows teams to write BDD style acceptance tests and execute them on their iOS application.

## Can I use it now? ##
We're currently in alpha testing mode. We're working hard on the tutorials and the documentation of the
product.

Your first step should be to follow the Hello World tutorial. It will guide you through the steps and the
thinking that typically goes on while we are building our tests.

We're looking for people interested in BDD, ATDD or acceptance testing in general who would like to contribute to make this an interesting product for the community. If you are interested, please drop us a line at pascal.roy@elapsetech.com.

## What does a test scenario look like? (from the Pet Shop tutorial example) ##
**Feature** : As a customer, I want to see what promotions are currently available in order to save some bucks

&lt;BR&gt;


**Scenario** : Navigate to the promotions screen

&lt;BR&gt;



```
IAGiven(i launched the petshop in landscape);
IAWhen(i touch the promo button on the menu view);
IAThen(the main view displays the promotions);
```

## See it in action !!! ##
**_See iAccept test driving the demo Pet Shop application on the Xcode iOS simulator :_**

<a href='http://www.youtube.com/watch?feature=player_embedded&v=PIE53yj-iYo' target='_blank'><img src='http://img.youtube.com/vi/PIE53yj-iYo/0.jpg' width='425' height=344 /></a>


&lt;BR&gt;

http://www.youtube.com/watch?v=PIE53yj-iYo

**_See iAccept in action as it walks through the tutorial of an iPad game :_**

<a href='http://www.youtube.com/watch?feature=player_embedded&v=k7teZFx06lM' target='_blank'><img src='http://img.youtube.com/vi/k7teZFx06lM/0.jpg' width='425' height=344 /></a>


&lt;BR&gt;

http://www.youtube.com/watch?v=k7teZFx06lM

## What were our design goals ? ##
  * Non programmers can write test scenarios using a domain specific language;
  * Support for BDD syntax (Given, When, Then);
  * Tests can be executed on the simulator or on the real device;
  * Developers develop fixtures to control the application under test in Objective-C, no need to learn yet another  language;
  * Keep the installation really simple (Framework packaging);
  * Minimize external dependencies with other frameworks (often source of incompatibilities);
  * Use only documented Apple APIs;
  * Propose a test architecture that is both flexible, sturdy and resilient to change;
  * Create a community to allow developers to share good design principles, tips and tricks †;
  * Integrated with CI †.

† planned in the near future...