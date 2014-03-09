//
//  SLAppController.m
//  SimLink
//
//  Created by Iska on 09/03/14.
//  Copyright (c) 2014 BrainCookie. All rights reserved.
//

#import "SLAppController.h"

@implementation SLAppController

- (void)awakeFromNib
{
	_statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];

	[_statusItem setTitle:@"SimLink"];
	[_statusItem setMenu:_statusMenu];
	[_statusItem setToolTip:@"BrainCookie"];
	[_statusItem setHighlightMode:YES];
}

- (void)hello:(id)sender
{
	NSLog(@"Hi");
}

@end
