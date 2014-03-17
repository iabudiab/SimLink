//
//  SLMenuItem.m
//  SimLink
//
//  Created by Iska on 13/03/14.
//  Copyright (c) 2014 BrainCookie. All rights reserved.
//

#import "SLMenuItem.h"
#import "SLApplicationBundle.h"
#import "SLSimulatorRemoteClient.h"

@interface SLMenuItem ()
{
	SLApplicationBundle *_appBundle;
	SLMenuItemAction _action;
}

- (void)setupWithPath:(NSString *)path;
- (void)openApplicationFolder;
- (void)deleteApplicationFolder;
- (void)runApplicationInSimulator;

@end

@implementation SLMenuItem

#pragma mark - Lifecycle

- (id)initWithApplicationDirectoryPath:(NSString *)path
{
	self = [super initWithTitle:@"" action:NULL keyEquivalent:@""];
	if (self) {
		[self setupWithPath:path];
	}
	return self;
}

- (void)setupWithPath:(NSString *)path
{
	_appBundle = [[SLApplicationBundle alloc] initWithApplicationDirectoryPath:path];

	self.title = _appBundle.displayName;
	SLMenuItemView *view = [[SLMenuItemView alloc] initWithName:_appBundle.displayName
										   identifier:_appBundle.identifier
											  version:_appBundle.version
												 size:_appBundle.size
											  andIcon:_appBundle.icon];
	view.delegate = self;
	self.view = view;
}

#pragma mark - Actions

- (void)setCurrentAction:(NSNumber *)action
{
	_action = [action shortValue];
}

- (void)openApplicationFolder
{
	NSString *path = [_appBundle.path stringByAppendingPathComponent:_appBundle.name];
	NSURL *url = [NSURL fileURLWithPath:path];
	[[NSWorkspace sharedWorkspace] activateFileViewerSelectingURLs:@[  url ]];
}

- (void)deleteApplicationFolder
{
	if ([_appBundle isSystemApplication]) return;

	[[NSFileManager defaultManager] removeItemAtPath:_appBundle.path error:nil];

	NSMenu *menu = self.menu;
	NSInteger index = [menu indexOfItem:self];
	[menu removeItemAtIndex:index];
	[menu removeItemAtIndex:index];
	[self.menu update];
}

- (void)runApplicationInSimulator
{
	NSString *path = [_appBundle.path stringByAppendingPathComponent:_appBundle.name];
	[[SLSimulatorRemoteClient sharedClient] launchApplicationAtPath:[path stringByResolvingSymlinksInPath]];
}

#pragma mark - App View Delegate (SLMenuItemViewDelegate)

- (void)menuItemViewClicked:(SLMenuItemView *)appView
{
	switch (_action) {
		case SLMenuItemActionDefault:
			[self openApplicationFolder];
			break;
		case SLMenuItemActionDelete:
			[self deleteApplicationFolder];
			break;
		case SLMenuItemActionRun:
			[self runApplicationInSimulator];
			break;
	}
}

@end
