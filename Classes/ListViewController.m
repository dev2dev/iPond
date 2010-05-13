    //
//  ListViewController.m
//  Pnd
//
//  Created by Ben Mills on 5/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ListViewController.h"
#import "SwitchViewController.h"
#import "JSON/JSON.h"

#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

@implementation ListViewController
@synthesize switchViewController;
@synthesize tableView, loading;

/**
 * Set up 
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	items = [[NSMutableArray alloc] init];
	responseData = [[NSMutableData data] retain];
	[self update_data];
}

/**
 * Events
 */

- (void)post_button_pressed:(id)sender {
	[self.switchViewController switch_views];
}

- (void)update_button_pressed:(id)sender {
	[self update_data];
}

/**
 * Request Logic
 */

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[responseData appendData:data];
	loading.hidden = YES;	
	//NSLog(@"Got Data %@", data);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[connection release];
	NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	[responseData release];
	SBJSON *parser = [[SBJSON alloc] init];
	NSArray *statuses = [parser objectWithString:responseString error:nil];
	NSLog(@"%@", statuses);
	
	for (NSDictionary *status in statuses) {
		NSString *val = [NSString stringWithFormat:@"%@: %@", [status objectForKey:@"user"], [status objectForKey:@"message"]];
		[items addObject:val];
	}
	[tableView reloadData];
	
	
	
	//NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:([items count] - 1) inSection:0];
	//[[self tableView] scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
	
	NSLog(@"Got data");
}

-(void)update_data {
	NSLog(@"Updating");
	
	items = [[NSMutableArray alloc] init];
	
	responseData = [[NSMutableData data] retain];
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.pndapp.com/feed.json"]];
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	[UIView setAnimationTransition: UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
}

/**
 * Clean up 
 */


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

/**
 * Table view
 */

#pragma mark -
#pragma mark UITableView Delegaates

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
	return [items count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; {
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath; {
	NSString *text = [items objectAtIndex:[indexPath row]];
	CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
	CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
	CGFloat height = MAX(size.height, 44.0f);
	
	return height + (CELL_CONTENT_MARGIN * 2);
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell;
	UILabel *label = nil;
	
	cell = [tv dequeueReusableCellWithIdentifier:@"Cell"];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"Cell"] autorelease];
		
		label = [[UILabel alloc] initWithFrame:CGRectZero];
		[label setLineBreakMode:UILineBreakModeWordWrap];
		[label setMinimumFontSize:FONT_SIZE];
		[label setNumberOfLines:0];
		[label setFont:[UIFont systemFontOfSize:FONT_SIZE]];
		[label setTag:1];
		
		[[cell contentView] addSubview:label];
		
	}
	NSString *text = [items objectAtIndex:[indexPath row]];
	
	CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
	
	CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
	
	if (!label)
		label = (UILabel*)[cell viewWithTag:1];
	
	[label setText:text];
	[label setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAX(size.height, 44.0f))];
	
	return cell;
}

@end
