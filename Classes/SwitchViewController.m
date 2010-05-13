    //
//  SwitchViewController.m
//  Pnd
//
//  Created by Ben Mills on 5/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SwitchViewController.h"
#import "ListViewController.h"
#import "PosterViewController.h"

@implementation SwitchViewController
@synthesize posterViewController, listViewController;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)viewDidLoad {
	ListViewController *listViewController = [[ListViewController alloc] initWithNibName:@"ListView" bundle:nil];
	self.listViewController = listViewController; 
	self.listViewController.switchViewController = self;
	[self.view insertSubview:listViewController.view atIndex:0];
	[listViewController release];
	[super viewDidLoad];
}

- (void)switch_views {
	[UIView beginAnimations:@"View Flip" context:nil];
	[UIView setAnimationDuration:1.25];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	if (self.posterViewController.view.superview == nil) {
		if (self.posterViewController == nil) {
			PosterViewController *posterViewController = [[PosterViewController alloc] initWithNibName:@"PosterView" bundle:nil];
			self.posterViewController = posterViewController;
			self.posterViewController.switchViewController = self;
			[posterViewController release];
		}
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
		[listViewController viewWillAppear:YES];
		[posterViewController viewWillDisappear:YES];
		
		[listViewController.view removeFromSuperview];
		[self.view insertSubview:posterViewController.view atIndex:0];
		
		[posterViewController viewDidDisappear:YES];
		[listViewController viewDidAppear:YES];
	} else {
		if (self.listViewController == nil) {
			ListViewController *listViewController = [[ListViewController alloc] initWithNibName:@"ListView" bundle:nil];
			self.listViewController = listViewController;
			self.listViewController.switchViewController = self;
			[self.listViewController update_data];
			[listViewController release];
		}
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
		[posterViewController viewWillAppear:YES];
		[listViewController viewWillDisappear:YES];
		
		[posterViewController.view removeFromSuperview];
		[self.view insertSubview:listViewController.view atIndex:0];
		
		[posterViewController viewDidDisappear:YES];
		[listViewController viewDidAppear:YES];
		
	}
	[UIView commitAnimations];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
