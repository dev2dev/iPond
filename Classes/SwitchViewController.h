//
//  SwitchViewController.h
//  Pnd
//
//  Created by Ben Mills on 5/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListViewController, PosterViewController;

@interface SwitchViewController : UIViewController {
	ListViewController *listViewController;
	PosterViewController *posterViewController;
}

@property (retain, nonatomic) ListViewController *listViewController;
@property (retain, nonatomic) PosterViewController *posterViewController;

-(void) switch_views;

@end
