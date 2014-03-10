//
//  SLAppController.m
//  SimLink
//
//  Created by Iska on 09/03/14.
//  Copyright (c) 2014 BrainCookie. All rights reserved.
//

#import "SLAppController.h"

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

- (NSArray *)subdirectoriesAtPath:(NSString *)path;
- (NSArray *)contentsOfDirectoryAtPath:(NSString *)path ofType:(NSString *)type;

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
	[self addSimulatorMenuItems];
	[self addDefaultMenuItems];

	[_statusItem popUpStatusItemMenu:_statusMenu];
}

- (void)addSimulatorMenuItems
{
	NSArray *simulatorVersions = [self subdirectoriesAtPath:_simulatorBasePath];

	[_statusMenu removeAllItems];
	for (NSURL *simulator in simulatorVersions) {
		NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:[simulator lastPathComponent] action:NULL keyEquivalent:@""];
		[item setSubmenu:[self menuForSimulatorPath:simulator.path]];
		[_statusMenu insertItem:item atIndex:0];
	}
}

- (NSMenu *)menuForSimulatorPath:(NSString *)path
{
	NSMenu *menu = [[NSMenu alloc] init];

	NSString *applicationsPath = [path stringByAppendingPathComponent:@"Applications"];
	NSArray *applications = [self subdirectoriesAtPath:applicationsPath];

	for (NSURL *application in applications) {
		NSArray *appBundles = [self contentsOfDirectoryAtPath:application.path ofType:@"app"];
		if (appBundles.count != 0) {
			NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:[appBundles objectAtIndex:0] action:NULL keyEquivalent:@""];
			[menu addItem:item];
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

- (NSArray *)subdirectoriesAtPath:(NSString *)path
{
	NSFileManager *fileManager = [NSFileManager defaultManager];

	NSDirectoryEnumerator *dirEnumerator  = [fileManager enumeratorAtURL:[NSURL fileURLWithPath:path]
											  includingPropertiesForKeys:@[ NSURLNameKey, NSURLIsDirectoryKey ]
																 options:NSDirectoryEnumerationSkipsSubdirectoryDescendants | NSDirectoryEnumerationSkipsHiddenFiles
															errorHandler:nil];
	NSMutableArray *dirList = [NSMutableArray array];
	for (NSURL *dir in dirEnumerator) {
		NSNumber *isDirectory;
		[dir getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:NULL];

		if ([isDirectory boolValue]) [dirList addObject:dir];
	}
	return dirList;
}

- (NSArray *)contentsOfDirectoryAtPath:(NSString *)path ofType:(NSString *)type
{
	NSFileManager *fileManager = [NSFileManager defaultManager];

	NSArray *items = [fileManager contentsOfDirectoryAtPath:path error:nil];

	NSMutableArray *appsList = [NSMutableArray array];

	for (NSString *item in items) {
		if (![[item pathExtension] isEqualToString:type]) continue;

		NSDictionary *attributes = [fileManager attributesOfItemAtPath:[path stringByAppendingPathComponent:item] error:nil];
		if ([attributes objectForKey:NSFileType] == NSFileTypeSymbolicLink) continue;

		[appsList addObject:item];
	}
	return appsList;
}

@end
