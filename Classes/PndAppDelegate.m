//
//  PndAppDelegate.m
//  Pnd
//
//  Created by Ben Mills on 5/9/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "PndAppDelegate.h"
#import "SwitchViewController.h"

@implementation PndAppDelegate

@synthesize window, switchViewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	
    // Override point for customization after application launch
		[window addSubview:switchViewController.view];
    [window makeKeyAndVisible];
    
    return YES;
}


- (void)dealloc {
    [window release];
		[switchViewController release];
    [super dealloc];
}


@end
