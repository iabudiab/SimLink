//
//  SLApplicationBundle.m
//  SimLink
//
//  Created by Iska on 14/03/14.
//  Copyright (c) 2014 BrainCookie. All rights reserved.
//

#import "SLApplicationBundle.h"
#import "SLFilesUtils.h"

@interface SLApplicationBundle ()
{
	NSString *_path;
	NSString *_name;
	NSString *_version;
	NSString *_identifier;
	NSString *_size;
	NSImage *_icon;
	BOOL _systemApplication;
}

- (BOOL)scanApplicationDirectoryAtPath:(NSString *)path;

@end

@implementation SLApplicationBundle
@synthesize name = _name;
@synthesize identifier = _identifier;
@synthesize version = _version;
@synthesize size = _size;
@synthesize icon = _icon;
@synthesize systemApplication = _systemApplication;

- (instancetype)initWithApplicationDirectoryPath:(NSString *)path
{
	self = [super init];
	if (self) {
		_path = path;
		if ([self scanApplicationDirectoryAtPath:_path] == NO) return nil;
	}
	return self;
}

- (BOOL)scanApplicationDirectoryAtPath:(NSString *)path
{
	SLFilesUtils *fileUtils = [SLFilesUtils sharedInstance];
	NSArray *applicationBundles = [fileUtils contentsOfDirectoryAtPath:path
																ofType:@"app"
													   includeSymlinks:YES];
	if (applicationBundles.count == 0) return NO;

	NSString *bundlePath = [applicationBundles objectAtIndex:0];
	NSString *plistPath = [bundlePath stringByAppendingPathComponent:@"info.plist"];

	if ([fileUtils isItemSymlinkAtPath:bundlePath]) {
		_systemApplication = YES;
		plistPath = [plistPath stringByResolvingSymlinksInPath];
	}

	NSDictionary *infoPlist = [NSDictionary dictionaryWithContentsOfFile:plistPath];

	if (infoPlist == nil) return NO;

	_name = [infoPlist objectForKey:@"CFBundleDisplayName"];
	_identifier = [infoPlist objectForKey:@"CFBundleIdentifier"];
	_version = [infoPlist objectForKey:@"CFBundleVersion"];
	_size = [NSByteCountFormatter stringFromByteCount:[fileUtils sizeOfItemAtPath:bundlePath]
										   countStyle:NSByteCountFormatterCountStyleBinary];
	_icon = [[NSImage alloc] initWithContentsOfFile:[bundlePath stringByAppendingPathComponent:@"icon@2x~ipad.png"]];
	if (!_icon) _icon = [[NSImage alloc] initWithContentsOfFile:[bundlePath stringByAppendingPathComponent:@"icon@2x~iphone.png"]];

	return YES;
}

@end
