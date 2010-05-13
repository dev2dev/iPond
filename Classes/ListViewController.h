//
//  ListViewController.h
//  Pnd
//
//  Created by Ben Mills on 5/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SwitchViewController;

@interface ListViewController : UIViewController {
	SwitchViewController *switchViewController;
	NSMutableData *responseData;
	UITableView *tableView;
	UIImageView *loading;
	NSMutableArray *items;
}

@property (retain, nonatomic) SwitchViewController *switchViewController;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIImageView *loading;

-(IBAction)post_button_pressed:(id)sender;
-(IBAction)update_button_pressed:(id)sender;

@end
