//
//  SLMenuItem.m
//  SimLink
//
//  Created by Iska on 13/03/14.
//  Copyright (c) 2014 BrainCookie. All rights reserved.
//

#import "SLMenuItem.h"

#import "SLApplicationBundle.h"

@interface SLMenuItem ()
{
	SLApplicationBundle *_appBundle;
}

- (void)setupWithPath:(NSString *)path;
- (void)openApplicationFolder:(id)sender;

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
	SLAppView *view = [[SLAppView alloc] initWithName:_appBundle.displayName
										   identifier:_appBundle.identifier
											  version:_appBundle.version
												 size:_appBundle.size
											  andIcon:_appBundle.icon];
	view.delegate = self;
	self.view = view;
}

#pragma mark - Actions

- (void)openApplicationFolder:(id)sender
{
	NSString *path = [_appBundle.path stringByAppendingPathComponent:_appBundle.name];
	NSURL *url = [NSURL fileURLWithPath:path];
	[[NSWorkspace sharedWorkspace] activateFileViewerSelectingURLs:@[  url ]];
}

#pragma mark - App View Delegate (SLAppViewDelegate)

- (void)appView:(SLAppView *)appView wasClickedWithKeyModifier:(NSString *)keyModifier
{
	[self openApplicationFolder:nil];
}

@end
