//
//  ETAnimalWellfareViewController.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-02-08.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "ETAnimalWellfareViewController.h"

@implementation ETAnimalWellfareViewController

@synthesize pageControl;
@synthesize scrollView;


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
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)initScrollViewContentSize
{
    
    int pageCount = 3;
    for (int i = 0; i < pageCount; i++) {
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        
        UITextView *subview = [[UITextView alloc] initWithFrame:frame];
        [subview setEditable:NO];
        if (i==0) {
            [subview setText:@"Page 1 : \r\nThe 21st-century debates about how humans should treat animals can be traced to the ancient world. The idea that the use of animals by humans—for food, clothing, entertainment, and as research subjects—is morally acceptable, springs mainly from two sources. First, there is the idea of a divine hierarchy based on the theological concept of dominion, from Genesis (1:20–28), where Adam is given dominion over the fish of the sea, and over the fowl of the air, and over the cattle, and over all the earth, and over every creeping thing that creepeth upon the earth. Although the concept of dominion need not entail property rights, it has been interpreted over the centuries to imply ownership. There is also the idea that animals are inferior because they lack rationality and language, and as such are worthy of less consideration than humans, or even none.[6] Springing from this is the idea that individual animals have no separate moral identity: a pig is simply an example of the class of pigs, and it is to the class, not to the individual, that human stewardship should be applied. This leads to the argument that the use of individual animals is acceptable so long as the species is not threatened with extinction.[7]"];
        } else if (i==1) {
            [subview setText:@"Page 2 : \r\nThe great influence of the 17th century was the French philosopher, René Descartes (1596–1650), whose Meditations (1641) informed attitudes about animals well into the 20th century.[8] Writing during the scientific revolution—of which he was one of the chief architects—Descartes proposed a mechanistic theory of the universe, the aim of which was to show that the world could be mapped out without allusion to subjective experience.[10]	Hold then the same view of the dog which has lost his master, which has sought him in all the thoroughfares with cries of sorrow, which comes into the house troubled and restless, goes downstairs, goes upstairs; goes from room to room, finds at last in his study the master he loves, and betokens his gladness by soft whimpers, frisks, and caresses. There are barbarians who seize this dog, who so greatly surpasses man in fidelity and friendship, and nail him down to a table and dissect him alive, to show you the mesaraic veins! You discover in him all the same organs of feeling as in yourself. Answer me, mechanist, has Nature arranged all the springs of feeling in this animal to the end that he might not feel? — Voltaire (1694–1778)[11]          His mechanistic approach was extended to the issue of animal consciousness. Mind, for Descartes, was a thing apart from the physical universe, a separate substance, linking human beings to the mind of God. The non-human, on the other hand, are nothing but complex automata, with no souls, minds, or reason. They can see, hear, and touch, but they are not, in any sense, conscious, and are unable to suffer or even to feel pain.[8] In the Discourse, published in 1637, Descartes wrote that the ability to reason and use language involves being able to respond in complex ways to all the contingencies of life, something that animals clearly cannot do. He argued from this that any sounds animals make do not constitute language, but are simply automatic responses to external stimuli.[12]"];
        } else if (i==2) {
            [subview setText:@"Page 3 : \r\nRichard Ryder writes that the first known legislation against animal cruelty in the English-speaking world was passed in Ireland in 1635. It prohibited pulling wool off sheep, and the attaching of ploughs to horses' tails, referring to the cruelty used to beasts, which Ryder writes is probably the earliest reference to this concept in the English language.[13] In 1641, the year Descartes' Meditations was published, the first legal code to protect domestic animals in North America was passed by the Massachusetts Bay Colony.[14] The colony's constitution was based on The Body of Liberties by the Reverend Nathaniel Ward (1578–1652), a lawyer, Puritan clergyman, and University of Cambridge graduate, originally from Suffolk, England.[15] Ward listed the rites the Colony's general court later endorsed, including rite number 92: No man shall exercise any Tirrany or Crueltie toward any bruite Creature which are usuallie kept for man's use. Historian Roderick Nash writes that, at the height of Descartes' influence in Europe, it is significant that the early New Englanders created a law that implied animals were not unfeeling automata.[16]"];
        }
        [self.scrollView addSubview:subview];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * pageCount, self.scrollView.frame.size.height);
    
    [self.view setNeedsDisplay];
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration {
    NSArray* subviews = [self.scrollView subviews];
    int i=0;
    for (UIView* view in subviews) {
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i++;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        view.frame = frame;
        
        [view setNeedsDisplay];
    }

    self.scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [subviews count], scrollView.frame.size.height);
}

- (void)viewDidLoad
{
    [super viewDidLoad];

   

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setPageControl:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) viewDidAppear:(BOOL)animated  {
    [super viewDidAppear:animated];
    [self initScrollViewContentSize];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    
    // Add the popover button to the toolbar.
    self.navigationItem.leftBarButtonItem = barButtonItem;
}


- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    
    // Remove the popover button from the toolbar.
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}


-(void)showPopUp:(NSString*)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Policy sent %@.", message]
                                                    message:[NSString stringWithFormat:@"Policy sent %@.", message]
                                                   delegate:nil 
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}



- (IBAction)pageChanged:(id)sender {
    // update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

- (IBAction)sendByEmail:(id)sender {
    [self showPopUp:@"by e-mail"];
}

- (IBAction)sendWithGmail:(id)sender {
    [self showPopUp:@"with gmail"];
}
@end
