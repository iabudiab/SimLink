//
//  SLAppController.m
//  SimLink
//
//  Created by Iska on 09/03/14.
//  Copyright (c) 2014 BrainCookie. All rights reserved.
//

#import "SLAppController.h"

@interface SLAppController ()

- (void)statusItemClicked:(id)sender;

@end

@implementation SLAppController

- (void)awakeFromNib
{
	_statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];

	[_statusItem setTitle:@"SimLink"];
	[_statusItem setToolTip:@"BrainCookie"];
	[_statusItem setTarget:self];
	[_statusItem setAction:@selector(statusItemClicked:)];

}

- (IBAction)openPreferences:(id)sender
{
	NSLog(@"Preferences");
}

- (void)statusItemClicked:(id)sender
{
	NSLog(@"Test");
	[_statusItem popUpStatusItemMenu:_statusMenu];
}

@end
