    //
//  PosterViewController.m
//  Pnd
//
//  Created by Ben Mills on 5/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PosterViewController.h"

@implementation PosterViewController
@synthesize switchViewController, message, username, password;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)back_button_pressed:(id)sender {
	[self.switchViewController switch_views];
}

- (void)post_button_pressed:(id)sender {
	if (message.text.length && username.text.length && password.text.length) {
		
		NSLog(@"Making request...");
		
		NSString *post = [NSString stringWithFormat:@"user=%@&password=%@&message=%@", username.text, password.text, message.text];
		NSLog(@"%@", post);
		
		NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
		
		NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
		
		NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
		[request setURL:[NSURL URLWithString:@"http://pndapp.com/api/post/"]];
		[request setHTTPMethod:@"POST"];
		[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
		[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
		[request setHTTPBody:postData];
		
		NSURLConnection *conn=[[NSURLConnection alloc] initWithRequest:request delegate:self];
		if (conn)
		{
			NSLog(@"Got data");
			message.text = Nil;
			[self.switchViewController switch_views];
		}
		else
		{
			NSLog(@"Nope");
		}
		
	}
}

- (void)background_tap:(id)sender {
	[message resignFirstResponder]; 
	[username resignFirstResponder];
	[password resignFirstResponder];
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
