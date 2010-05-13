//
//  PndAppDelegate.h
//  Pnd
//
//  Created by Ben Mills on 5/9/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SwitchViewController;

@interface PndAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	SwitchViewController *switchViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SwitchViewController *switchViewController;

@end

