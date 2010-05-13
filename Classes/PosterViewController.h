//
//  PosterViewController.h
//  Pnd
//
//  Created by Ben Mills on 5/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SwitchViewController;

@interface PosterViewController : UIViewController {
	SwitchViewController *switchViewController;
	UITextView *message;
	UITextField *username;
	UITextField *password;
}

@property (retain, nonatomic) SwitchViewController *switchViewController;
@property (retain, nonatomic) IBOutlet UITextView *message;
@property (retain, nonatomic) IBOutlet UITextField *username;
@property (retain, nonatomic) IBOutlet UITextField *password;

-(IBAction)post_button_pressed:(id)sender;
-(IBAction)back_button_pressed:(id)sender;
-(IBAction)background_tap:(id)sender;

@end
