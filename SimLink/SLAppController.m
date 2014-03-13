//
//  SLAppController.m
//  SimLink
//
//  Created by Iska on 09/03/14.
//  Copyright (c) 2014 BrainCookie. All rights reserved.
//

#import "SLAppController.h"
#import "SLAppView.h"
#import "SLFilesUtils.h"

@interface SLAppController ()
{
	NSString *_simulatorBasePath;
	NSMenu *_statusMenu;
	NSStatusItem *_statusItem;
}

- (void)statusItemClicked:(id)sender;
- (NSMenu *)menuForSimulatorPath:(NSString *)path;
- (void)addSimulatorMenuItems;
- (void)addDefaultMenuItems;

@end

@implementation SLAppController

- (void)awakeFromNib
{
	_statusMenu = [[NSMenu alloc] init];
	_statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];

	[_statusItem setTitle:@"SimLink"];
	[_statusItem setToolTip:@"BrainCookie"];
	[_statusItem setTarget:self];
	[_statusItem setAction:@selector(statusItemClicked:)];

	NSArray *supportDirectoryPath = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
	_simulatorBasePath = [[supportDirectoryPath objectAtIndex:0] stringByAppendingPathComponent:@"iPhone Simulator"];
}

- (IBAction)openPreferences:(id)sender
{
	NSLog(@"Preferences");
}

- (void)statusItemClicked:(id)sender
{
	[_statusMenu removeAllItems];

	[self addSimulatorMenuItems];
	[self addDefaultMenuItems];

	[_statusItem popUpStatusItemMenu:_statusMenu];
}

- (void)addSimulatorMenuItems
{
	NSArray *simulatorVersions = [[SLFilesUtils sharedInstance] subdirectoriesAtPath:_simulatorBasePath];

	for (NSString *simulatorDirectory in simulatorVersions) {
		NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:[simulatorDirectory lastPathComponent] action:NULL keyEquivalent:@""];
		[item setSubmenu:[self menuForSimulatorPath:simulatorDirectory]];
		[_statusMenu addItem:item];
	}
}

- (NSMenu *)menuForSimulatorPath:(NSString *)path
{
	NSMenu *menu = [[NSMenu alloc] init];
	[menu addItem:[NSMenuItem separatorItem]];

	NSString *applicationsPath = [path stringByAppendingPathComponent:@"Applications"];
	NSArray *applications = [[SLFilesUtils sharedInstance] subdirectoriesAtPath:applicationsPath];

	for (NSString *applicationDirectory in applications) {
		NSArray *appBundles = [[SLFilesUtils sharedInstance] contentsOfDirectoryAtPath:applicationDirectory ofType:@"app"];
		if (appBundles.count != 0) {
			NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:[appBundles objectAtIndex:0] action:NULL keyEquivalent:@""];
			NSString *appBundlePath = [applicationDirectory stringByAppendingPathComponent:[appBundles objectAtIndex:0]];
			item.view = [[SLAppView alloc] initWithAppBundlePath:appBundlePath];
			[menu addItem:item];
			[menu addItem:[NSMenuItem separatorItem]];
		}
	}

	return menu;
}

- (void)addDefaultMenuItems
{
	[_statusMenu addItem:[NSMenuItem separatorItem]];
	NSMenuItem *preferencesItem = [[NSMenuItem alloc] initWithTitle:@"Preferences" action:@selector(openPreferences:) keyEquivalent:@""];
	[preferencesItem setTarget:self];
	[_statusMenu addItem:preferencesItem];
	[_statusMenu addItem:[NSMenuItem separatorItem]];
	[_statusMenu addItemWithTitle:@"Quit" action:@selector(terminate:) keyEquivalent:@""];
}

@end
