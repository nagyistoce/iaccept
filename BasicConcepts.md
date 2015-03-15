#Presents the basic concepts used in iAccept.

# Introduction #

This page presents the basic concepts used in iAccept.


# Details #

**BDD**: Initially presented as another way of doing Test Driven Development. Dan North and others developed the BDD framework over a period of years, finally framing it as a communication and collaboration framework for developers, QA and non-technical or business participants in a software project. Dan North gave the following description of BDD during the "Agile specifications, BDD and Testing eXchange" in November 2009 in London : "BDD is a second-generation, outside–in, pull-based, multiple-stakeholder, multiple-scale, high-automation, agile methodology. It describes a cycle of interactions with well-defined outputs, resulting in the delivery of working, tested software that matters".

**Feature** : a feature corresponds to a unit of functionality of the software under construction. It is a use case or a user story. An excellent format suggested by Mike Cohn is the following : As a (role) I want (something) so that (benefit).

**Scenario** : a scenario typically represents an acceptance criteria of a specific Feature. This is where things get extremely concrete since the scenarios contain the details of the feature. Scenarios either pass or don't pass. iAccept uses  a Gherkin like syntax to define scenarios. Gherkin is a Business Readable, Domain Specific Language created especially for behavior descriptions. The general form is the following : Given (the system is in a known state), when (an action is taken), then (the system produces the desired outcome).

**Statement** : a scenario is composed of a number of Given/When/Then statements. Gherkin calls them steps. We just think "statement" is more explicit and user friendly...

**Fixture** : fixtures allow the test framework to control and query the state of the application under test. It is the glue that allows the Domain Specific Language to be executable.


# Sample feature with scenarios #
Here's a sample of a feature with its associated scenarios (taken from Wikipedia) :

`[Feature`] Returns go to stock

&lt;BR&gt;


In order to keep track of stock

&lt;BR&gt;


As a store owner

&lt;BR&gt;


I want to add items back to stock when they're returned

&lt;BR&gt;



`[Scenario 1`] Refunded items should be returned to stock

&lt;BR&gt;


Given a customer previously bought a black sweater from me

&lt;BR&gt;


And I currently have three black sweaters left in stock

&lt;BR&gt;


When he returns the sweater for a refund

&lt;BR&gt;


Then I should have four black sweaters in stock

&lt;BR&gt;



[`Scenario 2`] Replaced items should be returned to stock

&lt;BR&gt;


Given that a customer buys a blue garment

&lt;BR&gt;


And I have two blue garments in stock

&lt;BR&gt;


And three black garments in stock.

&lt;BR&gt;


When he returns the garment for a replacement in black,

&lt;BR&gt;


Then I should have three blue garments in stock

&lt;BR&gt;


And two black garments in stock

&lt;BR&gt;

